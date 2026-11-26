import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/darna_colors.dart';
import '../../widgets/widgets.dart';

/// Login screen (`03 — Authentication / 02 Login`).
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onBack,
    required this.onForgotPassword,
    required this.onCreateAccount,
    required this.onLoginSubmit,
    this.userName = 'Nour',
  });

  final VoidCallback onBack;
  final VoidCallback onForgotPassword;
  final VoidCallback onCreateAccount;
  final void Function(String email, String password) onLoginSubmit;
  final String userName;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    setState(() {
      _emailError = email.isEmpty ? 'Please enter your email or phone.' : null;
      _passwordError =
          password.isEmpty ? 'Please enter your password.' : null;
    });
    if (_emailError == null && _passwordError == null) {
      widget.onLoginSubmit(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.sageTint,
      body: Column(
        children: [
          // Deep green hero panel
          Container(
            width: double.infinity,
            height: 245,
            color: DarnaColors.primary,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  right: -20,
                  top: 0,
                  width: 260,
                  height: 260,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Color(0x44D4AF37),
                          Color(0x000F4D46),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 16,
                  width: 220,
                  height: 220,
                  child: Image.asset(
                    'assets/images/auth_login_3d.png',
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
                        GestureDetector(
                          onTap: widget.onBack,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: SvgPicture.asset(
                              'assets/icons/arrow_left_white.svg',
                              width: 22,
                              height: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Welcome back\n${widget.userName}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                color: DarnaColors.ivory,
                                height: 1.12,
                                letterSpacing: -1.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sage body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A familiar place for everything home.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: const Color(0xFF2E6F63),
                        ),
                  ),
                  const SizedBox(height: 20),
                  DarnaTextField(
                    label: 'Email or phone',
                    hintText: 'maya.hassan@example.com',
                    controller: _emailController,
                    errorText: _emailError,
                    suffixIconPath: 'assets/icons/mail.svg',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  DarnaTextField(
                    label: 'Password',
                    hintText: '••••••••••••',
                    controller: _passwordController,
                    errorText: _passwordError,
                    isPassword: true,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: widget.onForgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: DarnaColors.textPrimary,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  DarnaPrimaryButton(
                    label: 'Log In',
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: widget.onCreateAccount,
                      child: Text(
                        'New to Darna? Create an account',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 13,
                              color: DarnaColors.textSecondary,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: DarnaColors.sageTint,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: DarnaColors.primary.withValues(alpha: 0.14),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/info.svg',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your household, your information',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: DarnaColors.primary,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Track your finances without connecting a bank account. Darna never moves your money.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 12,
                                      color: DarnaColors.textPrimary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
