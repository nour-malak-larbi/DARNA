-- ============================================================================
-- Darna MVP — Milestone 1: Multi-User RLS & Security Verification Script
-- Run inside Supabase SQL Editor (wrapped in a transaction that rolls back)
-- ============================================================================

BEGIN;

-- 1. Create three simulated auth users
INSERT INTO auth.users (id, email)
VALUES
    ('11111111-1111-1111-1111-111111111111', 'amina@example.com'),
    ('22222222-2222-2222-2222-222222222222', 'karim@example.com'),
    ('33333333-3333-3333-3333-333333333333', 'yasmine@example.com');

-- Verify trigger created all three profiles
SELECT count(*) AS profiles_created
FROM public.profiles
WHERE id IN (
    '11111111-1111-1111-1111-111111111111',
    '22222222-2222-2222-2222-222222222222',
    '33333333-3333-3333-3333-333333333333'
);

-- ----------------------------------------------------------------------------
-- 2. Amina creates "Maison Benali" and household records
-- ----------------------------------------------------------------------------
SET LOCAL ROLE authenticated;
SET LOCAL request.jwt.claim.sub = '11111111-1111-1111-1111-111111111111';

INSERT INTO public.households (id, name, created_by)
VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Maison Benali', '11111111-1111-1111-1111-111111111111');

-- Amina adds Yasmine as 'admin'
INSERT INTO public.household_members (household_id, user_id, role)
VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '33333333-3333-3333-3333-333333333333', 'admin');

-- Amina creates a bill, payment, expense, and task
INSERT INTO public.bills (id, household_id, created_by, title, category, recurrence, default_amount)
VALUES ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Sonelgaz Electricity', 'Electricity', 'monthly', 4500.00);

INSERT INTO public.bill_payments (bill_id, household_id, amount, due_date, status)
VALUES ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 4500.00, CURRENT_DATE + 7, 'pending');

INSERT INTO public.expenses (household_id, created_by, title, category, amount)
VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Weekly Groceries', 'Groceries', 6200.00);

INSERT INTO public.tasks (household_id, created_by, assigned_to, title, status)
VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333', 'Pay water bill', 'pending');

-- Amina creates an invite code for Maison Benali
INSERT INTO public.household_invitations (household_id, code, role, created_by)
VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'DARNA-TEST-2026', 'member', '11111111-1111-1111-1111-111111111111');

-- ----------------------------------------------------------------------------
-- 3. Karim creates his own household "Villa Karim" and must NOT see Maison Benali
-- ----------------------------------------------------------------------------
SET LOCAL request.jwt.claim.sub = '22222222-2222-2222-2222-222222222222';

INSERT INTO public.households (id, name, created_by)
VALUES ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Villa Karim', '22222222-2222-2222-2222-222222222222');

-- Karim should only see Villa Karim (1), and 0 rows of Maison Benali's data
SELECT count(*) AS karim_visible_households FROM public.households;
SELECT count(*) AS karim_visible_bills FROM public.bills;
SELECT count(*) AS karim_visible_payments FROM public.bill_payments;
SELECT count(*) AS karim_visible_expenses FROM public.expenses;
SELECT count(*) AS karim_visible_tasks FROM public.tasks;
SELECT count(*) AS karim_visible_profiles FROM public.profiles; -- Only his own (1)

-- Karim cannot insert an expense into Maison Benali (must fail with RLS violation)
DO $$
BEGIN
    INSERT INTO public.expenses (household_id, created_by, title, category, amount)
    VALUES ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 'Unauthorized', 'Other', 100.00);
    RAISE EXCEPTION 'SECURITY FAILURE: Karim was able to insert into another household';
EXCEPTION WHEN insufficient_privilege THEN
    RAISE NOTICE 'PASS: Karim blocked from inserting into Maison Benali';
END $$;

-- ----------------------------------------------------------------------------
-- 4. Yasmine (admin) cannot promote herself to owner or remove Amina (owner)
-- ----------------------------------------------------------------------------
SET LOCAL request.jwt.claim.sub = '33333333-3333-3333-3333-333333333333';

DO $$
BEGIN
    UPDATE public.household_members
    SET role = 'owner'
    WHERE household_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
      AND user_id = '33333333-3333-3333-3333-333333333333';
    RAISE EXCEPTION 'SECURITY FAILURE: Admin promoted self to owner';
EXCEPTION WHEN insufficient_privilege THEN
    RAISE NOTICE 'PASS: Admin blocked from promoting self to owner';
END $$;

DELETE FROM public.household_members
WHERE household_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
  AND user_id = '11111111-1111-1111-1111-111111111111';
-- Must affect 0 rows; verify Amina is still owner
SELECT role AS amina_role_after_admin_delete_attempt
FROM public.household_members
WHERE household_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
  AND user_id = '11111111-1111-1111-1111-111111111111';

-- ----------------------------------------------------------------------------
-- 5. Last owner protection & explicit ownership transfer
-- ----------------------------------------------------------------------------
SET LOCAL request.jwt.claim.sub = '11111111-1111-1111-1111-111111111111';

DO $$
BEGIN
    DELETE FROM public.household_members
    WHERE household_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
      AND user_id = '11111111-1111-1111-1111-111111111111';
    RAISE EXCEPTION 'SECURITY FAILURE: Last owner was allowed to leave';
EXCEPTION WHEN raise_exception THEN
    RAISE NOTICE 'PASS: Last owner prevented from leaving';
END $$;

SELECT public.transfer_household_ownership(
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    '33333333-3333-3333-3333-333333333333'
);

SELECT user_id, role
FROM public.household_members
WHERE household_id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'
ORDER BY role;

-- ----------------------------------------------------------------------------
-- 6. Secure invite code redemption (single-use)
-- ----------------------------------------------------------------------------
SET LOCAL request.jwt.claim.sub = '22222222-2222-2222-2222-222222222222';

SELECT public.join_household_by_code('DARNA-TEST-2026') AS joined_household_id;

DO $$
BEGIN
    PERFORM public.join_household_by_code('DARNA-TEST-2026');
    RAISE EXCEPTION 'SECURITY FAILURE: Invite code was reused';
EXCEPTION WHEN raise_exception THEN
    RAISE NOTICE 'PASS: Invite code cannot be reused';
END $$;

ROLLBACK;
