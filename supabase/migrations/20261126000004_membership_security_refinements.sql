-- ============================================================================
-- Darna MVP — Milestone 1: Membership Security Refinements
-- ============================================================================
-- Hardens role management on public.household_members:
--   1. Prevents admins from inserting or promoting anyone to 'owner'.
--   2. Prevents admins from modifying or removing an 'owner'.
--   3. Prevents the last 'owner' from leaving, being removed, or being demoted.
--   4. Adds an atomic, explicit transfer_household_ownership() RPC.
-- ============================================================================

-- 1. Replace household_members INSERT / UPDATE / DELETE policies
DROP POLICY IF EXISTS "Owners and admins can add household members" ON public.household_members;
DROP POLICY IF EXISTS "Owners and admins can update member roles" ON public.household_members;
DROP POLICY IF EXISTS "Owners/admins can remove members or members can leave" ON public.household_members;

CREATE POLICY "Owners and admins can add household members"
    ON public.household_members FOR INSERT
    TO authenticated
    WITH CHECK (
        public.has_household_role(household_id, ARRAY['owner'])
        OR (
            public.has_household_role(household_id, ARRAY['admin'])
            AND role IN ('admin', 'member')
        )
    );

CREATE POLICY "Owners can update any role; admins can update non-owners"
    ON public.household_members FOR UPDATE
    TO authenticated
    USING (
        public.has_household_role(household_id, ARRAY['owner'])
        OR (
            public.has_household_role(household_id, ARRAY['admin'])
            AND role <> 'owner'
        )
    )
    WITH CHECK (
        public.has_household_role(household_id, ARRAY['owner'])
        OR (
            public.has_household_role(household_id, ARRAY['admin'])
            AND role IN ('admin', 'member')
        )
    );

CREATE POLICY "Owners can remove any; admins non-owners; members can leave"
    ON public.household_members FOR DELETE
    TO authenticated
    USING (
        user_id = auth.uid()
        OR public.has_household_role(household_id, ARRAY['owner'])
        OR (
            public.has_household_role(household_id, ARRAY['admin'])
            AND role <> 'owner'
        )
    );

-- 2. Trigger: Prevent removing or demoting the last owner of an existing household
CREATE OR REPLACE FUNCTION public.prevent_last_owner_loss()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_other_owners_exist BOOLEAN;
    v_household_exists BOOLEAN;
BEGIN
    IF OLD.role <> 'owner' THEN
        IF TG_OP = 'DELETE' THEN
            RETURN OLD;
        END IF;
        RETURN NEW;
    END IF;

    IF TG_OP = 'UPDATE' AND NEW.role = 'owner' THEN
        RETURN NEW;
    END IF;

    -- Allow ON DELETE CASCADE when the parent household itself is being deleted
    SELECT EXISTS (
        SELECT 1 FROM public.households WHERE id = OLD.household_id
    ) INTO v_household_exists;

    IF NOT v_household_exists THEN
        RETURN OLD;
    END IF;

    SELECT EXISTS (
        SELECT 1
        FROM public.household_members
        WHERE household_id = OLD.household_id
          AND role = 'owner'
          AND id <> OLD.id
    ) INTO v_other_owners_exist;

    IF NOT v_other_owners_exist THEN
        RAISE EXCEPTION 'Cannot remove or demote the last owner of a household';
    END IF;

    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_prevent_last_owner_loss
    BEFORE UPDATE OR DELETE ON public.household_members
    FOR EACH ROW
    EXECUTE FUNCTION public.prevent_last_owner_loss();

-- 3. Secure, explicit ownership transfer RPC
CREATE OR REPLACE FUNCTION public.transfer_household_ownership(
    p_household_id UUID,
    p_new_owner_id UUID
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_caller_id UUID := auth.uid();
    v_caller_role TEXT;
    v_target_exists BOOLEAN;
BEGIN
    IF v_caller_id IS NULL THEN
        RAISE EXCEPTION 'Authentication required';
    END IF;

    IF p_new_owner_id = v_caller_id THEN
        RAISE EXCEPTION 'Cannot transfer ownership to yourself';
    END IF;

    -- Lock caller's membership row and verify they are currently an owner
    SELECT role
    INTO v_caller_role
    FROM public.household_members
    WHERE household_id = p_household_id
      AND user_id = v_caller_id
    FOR UPDATE;

    IF v_caller_role IS DISTINCT FROM 'owner' THEN
        RAISE EXCEPTION 'Only a household owner can transfer ownership';
    END IF;

    -- Lock target's membership row and verify they belong to the same household
    SELECT EXISTS (
        SELECT 1
        FROM public.household_members
        WHERE household_id = p_household_id
          AND user_id = p_new_owner_id
        FOR UPDATE
    ) INTO v_target_exists;

    IF NOT v_target_exists THEN
        RAISE EXCEPTION 'Target user must be an existing member of the household';
    END IF;

    -- Promote new owner first, then demote previous owner to admin
    UPDATE public.household_members
    SET role = 'owner'
    WHERE household_id = p_household_id
      AND user_id = p_new_owner_id;

    UPDATE public.household_members
    SET role = 'admin'
    WHERE household_id = p_household_id
      AND user_id = v_caller_id;
END;
$$;

REVOKE ALL ON FUNCTION public.transfer_household_ownership(UUID, UUID) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.transfer_household_ownership(UUID, UUID) TO authenticated;
