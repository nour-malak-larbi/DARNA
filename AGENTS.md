# AGENTS.md

## Project
Darna: Flutter (Dart SDK ^3.13.7) household-management app for Algerian households. Supabase/Postgres backend exists as SQL migrations + RLS only; the Flutter app has no Supabase client dependency yet.

## Commands
- Install deps: `flutter pub get`
- Static analysis: `flutter analyze` (must be clean; analyzer excludes platform dirs)
- All tests: `flutter test`
- Single test file: `flutter test test/widget_test.dart`
- Single test by name: `flutter test --name "Authentication flow"`
- Run app: `flutter run`
- Backend: apply `supabase/migrations/*.sql` in filename order; verify with `supabase/tests/rls_verification.sql` in the Supabase SQL Editor (wrapped in a transaction that rolls back).

## Structure
- `lib/main.dart`: app entry, `_AppRoute` state machine, and `DarnaUiKitShowcase`; there is no router package.
- `lib/core/theme/`: `DarnaColors` tokens and `DarnaTheme.light`.
- `lib/widgets/widgets.dart`: barrel export for the reusable UI kit; import this rather than individual widget files.
- `lib/screens/auth/`: auth screens re-exported by `auth_screens.dart`.
- `supabase/`: Postgres schema, triggers/functions, RLS policies, membership-security refinements.

## Conventions
- Use `DarnaColors` tokens instead of hardcoded colors.
- Import widgets via `package:darna_app/widgets/widgets.dart`.
- Assets are registered under `assets/icons/` and `assets/images/`; reference by full asset path.
- Backend changes: add a numbered migration in `supabase/migrations/`; keep RLS policies and security-definer helpers consistent; run the RLS verification script.

## Backend security model
- Roles: `owner` / `admin` / `member`. Only owners can create/promote owners; admins can add admin/member. The last owner cannot be removed or demoted; use `transfer_household_ownership()`. Invite codes are single-use via `join_household_by_code()`. All tables are RLS-scoped to household membership.

## Verification
Before finishing changes run `flutter analyze` then `flutter test`.