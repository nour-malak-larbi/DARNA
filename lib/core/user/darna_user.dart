/// Household member shown in the app shell, sourced from the signed-in account.
class DarnaUser {
  const DarnaUser({
    required this.name,
    required this.email,
    this.phone = '',
  });

  final String name;
  final String email;
  final String phone;

  /// Placeholder until the Supabase auth + profiles tables are wired.
  static const DarnaUser guest = DarnaUser(
    name: 'Maya Larbi',
    email: 'maya.nour@example.com',
    phone: '+213 555 0148',
  );
}
