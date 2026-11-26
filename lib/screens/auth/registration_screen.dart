import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/darna_colors.dart';
import '../../widgets/widgets.dart';

/// Registration screen (`03 — Authentication / 03 Registration`).
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
    required this.onBack,
    required this.onLoginTap,
    required this.onCreateAccount,
  });

  final VoidCallback onBack;
  final VoidCallback onLoginTap;
  final void Function(String fullName, String email, String password)
      onCreateAccount;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    setState(() {
      _nameError = name.isEmpty ? 'Please enter your full name.' : null;
      _emailError = email.isEmpty ? 'Please enter your email or phone.' : null;
      _passwordError = password.length < 8
          ? 'Use at least 8 characters, with a letter and number.'
          : null;
      _confirmError =
          confirm != password ? 'Passwords do not match.' : null;
    });

    if (_nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmError == null) {
      widget.onCreateAccount(name, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.ivory,
      body: Column(
        children: [
          // Sage hero header
          Container(
            width: double.infinity,
            height: 260,
            color: DarnaColors.sageTint,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  right: -20,
                  top: 60,
                  width: 240,
                  height: 220,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color(0x55D4AF37),
                          Color(0x00DCE7D8),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 44,
                  width: 210,
                  height: 210,
                  child: Image.asset(
                    'assets/images/auth_register_3d.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: widget.onBack,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SvgPicture.asset(
                                  'assets/icons/arrow_left_dark.svg',
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                            Text(
                              'CREATE YOUR ACCOUNT',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 11,
                                    letterSpacing: 1,
                                    color: DarnaColors.primary,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Make room\nfor calm',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: DarnaColors.primary,
                                height: 1.25,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable form body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 20, 28, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Start with you. Bring your household along when you're ready.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: const Color(0xFF5A6B61),
                          height: 1.6,
                        ),
                  ),
                  const SizedBox(height: 16),
                  DarnaTextField(
                    label: 'Full name',
                    hintText: 'Maya Hassan',
                    controller: _nameController,
                    errorText: _nameError,
                  ),
                  const SizedBox(height: 14),
                  DarnaTextField(
                    label: 'Email or phone',
                    hintText: 'maya.hassan@example.com',
                    controller: _emailController,
                    errorText: _emailError,
                    suffixIconPath: 'assets/icons/mail.svg',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  DarnaTextField(
                    label: 'Password',
                    hintText: '••••••••••••',
                    controller: _passwordController,
                    errorText: _passwordError,
                    isPassword: true,
                  ),
                  if (_passwordError == null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Use at least 8 characters, with a letter and number.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: DarnaColors.textPrimary,
                          ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  DarnaTextField(
                    label: 'Confirm password',
                    hintText: '••••••••••••',
                    controller: _confirmController,
                    errorText: _confirmError,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'By creating an account, you agree to the Terms of Use and Privacy Policy. Find both in Settings → Privacy & account.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: DarnaColors.textPrimary,
                          height: 1.6,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: widget.onLoginTap,
                      child: Text(
                        'Already part of Darna? Log In',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: DarnaColors.primary,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  DarnaPrimaryButton(
                    label: 'Create account',
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
