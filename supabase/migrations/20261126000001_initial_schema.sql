-- ============================================================================
-- Darna MVP — Milestone 1: Initial Database Schema
-- ============================================================================

-- 1. Profiles (extends auth.users)
CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT NOT NULL DEFAULT '',
    email TEXT NOT NULL,
    avatar_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Households
CREATE TABLE public.households (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL CHECK (char_length(trim(name)) > 0),
    created_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 3. Household Members (many-to-many between profiles and households)
CREATE TABLE public.household_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    household_id UUID NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    role TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('owner', 'admin', 'member')),
    joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (household_id, user_id)
);

-- 4. Household Invitations (secure invite-code flow)
CREATE TABLE public.household_invitations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    household_id UUID NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
    code TEXT NOT NULL UNIQUE,
    role TEXT NOT NULL DEFAULT 'member' CHECK (role IN ('admin', 'member')),
    created_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    expires_at TIMESTAMPTZ NOT NULL DEFAULT (now() + interval '7 days'),
    used_at TIMESTAMPTZ,
    used_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 5. Bills (bill definitions)
CREATE TABLE public.bills (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    household_id UUID NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
    created_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    title TEXT NOT NULL CHECK (char_length(trim(title)) > 0),
    category TEXT NOT NULL CHECK (char_length(trim(category)) > 0),
    recurrence TEXT NOT NULL DEFAULT 'monthly' CHECK (recurrence IN ('none', 'monthly', 'quarterly', 'yearly')),
    default_amount NUMERIC(12,2) NOT NULL CHECK (default_amount >= 0),
    currency TEXT NOT NULL DEFAULT 'DZD',
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    -- Enables composite FK from bill_payments to enforce same-household integrity
    UNIQUE (id, household_id)
);

-- 6. Bill Payments (individual payment occurrences)
CREATE TABLE public.bill_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bill_id UUID NOT NULL,
    household_id UUID NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
    amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0),
    due_date DATE NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'overdue')),
    paid_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    FOREIGN KEY (bill_id, household_id)
        REFERENCES public.bills(id, household_id)
        ON DELETE CASCADE
);

-- 7. Expenses
CREATE TABLE public.expenses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    household_id UUID NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
    created_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    title TEXT NOT NULL CHECK (char_length(trim(title)) > 0),
    category TEXT NOT NULL CHECK (char_length(trim(category)) > 0),
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    currency TEXT NOT NULL DEFAULT 'DZD',
    expense_date DATE NOT NULL DEFAULT CURRENT_DATE,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 8. Tasks
CREATE TABLE public.tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    household_id UUID NOT NULL REFERENCES public.households(id) ON DELETE CASCADE,
    created_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
    assigned_to UUID,
    title TEXT NOT NULL CHECK (char_length(trim(title)) > 0),
    description TEXT,
    due_date TIMESTAMPTZ,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'in_progress', 'completed')),
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    -- Enforces that assigned_to (when non-null) is a member of the same household
    FOREIGN KEY (household_id, assigned_to)
        REFERENCES public.household_members(household_id, user_id)
);

-- ============================================================================
-- Indexes for frequently queried fields
-- ============================================================================
CREATE INDEX idx_household_members_user_id ON public.household_members(user_id);
CREATE INDEX idx_household_members_household_id ON public.household_members(household_id);
CREATE INDEX idx_household_invitations_household_id ON public.household_invitations(household_id);
CREATE INDEX idx_bills_household_id ON public.bills(household_id);
CREATE INDEX idx_bill_payments_household_due_date ON public.bill_payments(household_id, due_date);
CREATE INDEX idx_bill_payments_bill_id ON public.bill_payments(bill_id);
CREATE INDEX idx_bill_payments_status ON public.bill_payments(household_id, status);
CREATE INDEX idx_expenses_household_date ON public.expenses(household_id, expense_date DESC);
CREATE INDEX idx_expenses_category ON public.expenses(household_id, category);
CREATE INDEX idx_tasks_household_status ON public.tasks(household_id, status);
CREATE INDEX idx_tasks_assigned_to ON public.tasks(household_id, assigned_to);
