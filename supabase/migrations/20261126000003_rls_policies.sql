-- ============================================================================
-- Darna MVP — Milestone 1: Row Level Security (RLS) Policies
-- ============================================================================

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.households ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.household_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.household_invitations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bills ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bill_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

-- ----------------------------------------------------------------------------
-- 1. profiles
-- ----------------------------------------------------------------------------
CREATE POLICY "Users can view own profile or household co-members"
    ON public.profiles FOR SELECT
    TO authenticated
    USING (
        id = auth.uid()
        OR public.shares_household_with(id)
    );

CREATE POLICY "Users can update own profile"
    ON public.profiles FOR UPDATE
    TO authenticated
    USING (id = auth.uid())
    WITH CHECK (id = auth.uid());

-- ----------------------------------------------------------------------------
-- 2. households
-- ----------------------------------------------------------------------------
CREATE POLICY "Members can view their households"
    ON public.households FOR SELECT
    TO authenticated
    USING (
        created_by = auth.uid()
        OR public.is_household_member(id)
    );

CREATE POLICY "Authenticated users can create households"
    ON public.households FOR INSERT
    TO authenticated
    WITH CHECK (created_by = auth.uid());

CREATE POLICY "Owners and admins can update households"
    ON public.households FOR UPDATE
    TO authenticated
    USING (public.has_household_role(id, ARRAY['owner', 'admin']))
    WITH CHECK (public.has_household_role(id, ARRAY['owner', 'admin']));

CREATE POLICY "Owners can delete households"
    ON public.households FOR DELETE
    TO authenticated
    USING (public.has_household_role(id, ARRAY['owner']));

-- ----------------------------------------------------------------------------
-- 3. household_members
-- ----------------------------------------------------------------------------
CREATE POLICY "Members can view household membership list"
    ON public.household_members FOR SELECT
    TO authenticated
    USING (public.is_household_member(household_id));

CREATE POLICY "Owners and admins can add household members"
    ON public.household_members FOR INSERT
    TO authenticated
    WITH CHECK (public.has_household_role(household_id, ARRAY['owner', 'admin']));

CREATE POLICY "Owners and admins can update member roles"
    ON public.household_members FOR UPDATE
    TO authenticated
    USING (public.has_household_role(household_id, ARRAY['owner', 'admin']))
    WITH CHECK (public.has_household_role(household_id, ARRAY['owner', 'admin']));

CREATE POLICY "Owners/admins can remove members or members can leave"
    ON public.household_members FOR DELETE
    TO authenticated
    USING (
        user_id = auth.uid()
        OR public.has_household_role(household_id, ARRAY['owner', 'admin'])
    );

-- ----------------------------------------------------------------------------
-- 4. household_invitations
-- ----------------------------------------------------------------------------
CREATE POLICY "Owners and admins can view invitations"
    ON public.household_invitations FOR SELECT
    TO authenticated
    USING (public.has_household_role(household_id, ARRAY['owner', 'admin']));

CREATE POLICY "Owners and admins can create invitations"
    ON public.household_invitations FOR INSERT
    TO authenticated
    WITH CHECK (
        created_by = auth.uid()
        AND public.has_household_role(household_id, ARRAY['owner', 'admin'])
    );

CREATE POLICY "Owners and admins can revoke invitations"
    ON public.household_invitations FOR DELETE
    TO authenticated
    USING (public.has_household_role(household_id, ARRAY['owner', 'admin']));

-- ----------------------------------------------------------------------------
-- 5. bills
-- ----------------------------------------------------------------------------
CREATE POLICY "Household members can view bills"
    ON public.bills FOR SELECT
    TO authenticated
    USING (public.is_household_member(household_id));

CREATE POLICY "Household members can create bills"
    ON public.bills FOR INSERT
    TO authenticated
    WITH CHECK (
        created_by = auth.uid()
        AND public.is_household_member(household_id)
    );

CREATE POLICY "Household members can update bills"
    ON public.bills FOR UPDATE
    TO authenticated
    USING (public.is_household_member(household_id))
    WITH CHECK (public.is_household_member(household_id));

CREATE POLICY "Household members can delete bills"
    ON public.bills FOR DELETE
    TO authenticated
    USING (public.is_household_member(household_id));

-- ----------------------------------------------------------------------------
-- 6. bill_payments
-- ----------------------------------------------------------------------------
CREATE POLICY "Household members can view bill payments"
    ON public.bill_payments FOR SELECT
    TO authenticated
    USING (public.is_household_member(household_id));

CREATE POLICY "Household members can create bill payments"
    ON public.bill_payments FOR INSERT
    TO authenticated
    WITH CHECK (public.is_household_member(household_id));

CREATE POLICY "Household members can update bill payments"
    ON public.bill_payments FOR UPDATE
    TO authenticated
    USING (public.is_household_member(household_id))
    WITH CHECK (public.is_household_member(household_id));

CREATE POLICY "Household members can delete bill payments"
    ON public.bill_payments FOR DELETE
    TO authenticated
    USING (public.is_household_member(household_id));

-- ----------------------------------------------------------------------------
-- 7. expenses
-- ----------------------------------------------------------------------------
CREATE POLICY "Household members can view expenses"
    ON public.expenses FOR SELECT
    TO authenticated
    USING (public.is_household_member(household_id));

CREATE POLICY "Household members can create expenses"
    ON public.expenses FOR INSERT
    TO authenticated
    WITH CHECK (
        created_by = auth.uid()
        AND public.is_household_member(household_id)
    );

CREATE POLICY "Household members can update expenses"
    ON public.expenses FOR UPDATE
    TO authenticated
    USING (public.is_household_member(household_id))
    WITH CHECK (public.is_household_member(household_id));

CREATE POLICY "Household members can delete expenses"
    ON public.expenses FOR DELETE
    TO authenticated
    USING (public.is_household_member(household_id));

-- ----------------------------------------------------------------------------
-- 8. tasks
-- ----------------------------------------------------------------------------
CREATE POLICY "Household members can view tasks"
    ON public.tasks FOR SELECT
    TO authenticated
    USING (public.is_household_member(household_id));

CREATE POLICY "Household members can create tasks"
    ON public.tasks FOR INSERT
    TO authenticated
    WITH CHECK (
        created_by = auth.uid()
        AND public.is_household_member(household_id)
    );

CREATE POLICY "Household members can update tasks"
    ON public.tasks FOR UPDATE
    TO authenticated
    USING (public.is_household_member(household_id))
    WITH CHECK (public.is_household_member(household_id));

CREATE POLICY "Household members can delete tasks"
    ON public.tasks FOR DELETE
    TO authenticated
    USING (public.is_household_member(household_id));
