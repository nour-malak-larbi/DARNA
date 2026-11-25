-- ============================================================================
-- Darna MVP — Milestone 1: Triggers & Security Helper Functions
-- ============================================================================

-- 1. Automatically create a profile when a new user signs up in auth.users
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.profiles (id, full_name, email, avatar_url)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data ->> 'full_name', ''),
        COALESCE(NEW.email, ''),
        NEW.raw_user_meta_data ->> 'avatar_url'
    );
    RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();

-- 2. Automatically add household creator as 'owner' in household_members
CREATE OR REPLACE FUNCTION public.handle_new_household()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.household_members (household_id, user_id, role)
    VALUES (NEW.id, NEW.created_by, 'owner');
    RETURN NEW;
END;
$$;

CREATE TRIGGER on_household_created
    AFTER INSERT ON public.households
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_household();

-- 3. Keep households.updated_at current
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;

CREATE TRIGGER set_households_updated_at
    BEFORE UPDATE ON public.households
    FOR EACH ROW
    EXECUTE FUNCTION public.set_updated_at();

-- 4. Unassign tasks when a member is removed from a household
CREATE OR REPLACE FUNCTION public.handle_member_removed()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    UPDATE public.tasks
    SET assigned_to = NULL
    WHERE household_id = OLD.household_id
      AND assigned_to = OLD.user_id;
    RETURN OLD;
END;
$$;

CREATE TRIGGER on_household_member_removed
    BEFORE DELETE ON public.household_members
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_member_removed();

-- ============================================================================
-- Non-recursive RLS Helper Functions (SECURITY DEFINER with fixed search_path)
-- ============================================================================

CREATE OR REPLACE FUNCTION public.is_household_member(p_household_id UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1
        FROM public.household_members
        WHERE household_id = p_household_id
          AND user_id = auth.uid()
    );
$$;

CREATE OR REPLACE FUNCTION public.has_household_role(p_household_id UUID, p_roles TEXT[])
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1
        FROM public.household_members
        WHERE household_id = p_household_id
          AND user_id = auth.uid()
          AND role = ANY(p_roles)
    );
$$;

CREATE OR REPLACE FUNCTION public.shares_household_with(p_other_user_id UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1
        FROM public.household_members hm_self
        JOIN public.household_members hm_other
          ON hm_self.household_id = hm_other.household_id
        WHERE hm_self.user_id = auth.uid()
          AND hm_other.user_id = p_other_user_id
    );
$$;

-- ============================================================================
-- Secure Invite Code Redemption RPC
-- ============================================================================

CREATE OR REPLACE FUNCTION public.join_household_by_code(p_code TEXT)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_invite public.household_invitations%ROWTYPE;
    v_user_id UUID := auth.uid();
BEGIN
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Authentication required';
    END IF;

    SELECT *
    INTO v_invite
    FROM public.household_invitations
    WHERE code = trim(p_code)
      AND used_at IS NULL
      AND expires_at > now()
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invalid or expired invitation code';
    END IF;

    INSERT INTO public.household_members (household_id, user_id, role)
    VALUES (v_invite.household_id, v_user_id, v_invite.role)
    ON CONFLICT (household_id, user_id) DO NOTHING;

    UPDATE public.household_invitations
    SET used_at = now(),
        used_by = v_user_id
    WHERE id = v_invite.id;

    RETURN v_invite.household_id;
END;
$$;

REVOKE ALL ON FUNCTION public.is_household_member(UUID) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.has_household_role(UUID, TEXT[]) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.shares_household_with(UUID) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.join_household_by_code(TEXT) FROM PUBLIC;

GRANT EXECUTE ON FUNCTION public.is_household_member(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.has_household_role(UUID, TEXT[]) TO authenticated;
GRANT EXECUTE ON FUNCTION public.shares_household_with(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.join_household_by_code(TEXT) TO authenticated;
