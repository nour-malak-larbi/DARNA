import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/darna_colors.dart';
import '../../widgets/widgets.dart';

/// Account recovery screen (`03 — Authentication / Forgot Password`).
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
    required this.onBack,
    required this.onBackToLogin,
    required this.onSendReset,
  });

  final VoidCallback onBack;
  final VoidCallback onBackToLogin;
  final ValueChanged<String> onSendReset;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? _emailError;
  bool _sent = false;
  String _submittedEmail = 'maya.hassan@example.com';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _emailError = 'Enter a valid email address.');
      return;
    }
    setState(() {
      _emailError = null;
      _sent = true;
      _submittedEmail = email;
    });
    widget.onSendReset(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.ivory,
      body: Column(
        children: [
          // Sage hero
          Container(
            width: double.infinity,
            height: 240,
            color: DarnaColors.sageTint,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                // Emerald recovery halo
                Positioned(
                  right: -42,
                  top: 42,
                  width: 254,
                  height: 236,
                  child: SvgPicture.asset(
                    'assets/icons/recovery_emerald_halo.svg',
                    fit: BoxFit.contain,
                  ),
                ),
                // Lavender corner bubble
                Positioned(
                  left: 219,
                  top: 134,
                  width: 80,
                  height: 80,
                  child: SvgPicture.asset(
                    'assets/icons/recovery_lavender_bubble.svg',
                    fit: BoxFit.contain,
                  ),
                ),
                // 3D artwork
                Positioned(
                  right: -10,
                  top: 0,
                  width: 260,
                  height: 260,
                  child: Image.asset(
                    'assets/images/auth_recovery_3d.png',
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
                                padding: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(
                                  'assets/icons/arrow_left_dark.svg',
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                            Text(
                              'ACCOUNT RECOVERY',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontSize: 11,
                                    letterSpacing: 1.2,
                                    color: DarnaColors.primary,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 190,
                          child: Text(
                            "Let's get you back in",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: DarnaColors.primary,
                                  height: 1.3,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter your account email. We'll send instructions to reset your password.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: const Color(0xFF4A5E52),
                          height: 1.6,
                        ),
                  ),
                  const SizedBox(height: 18),
                  DarnaTextField(
                    label: 'Email address',
                    hintText: 'maya.hassan@example.com',
                    controller: _emailController,
                    errorText: _emailError,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 18),
                  DarnaPrimaryButton(
                    label: 'Send reset instructions',
                    onPressed: _submit,
                  ),
                  if (_sent) ...[
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: DarnaColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE8E2D4)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F0F4D46),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: DarnaColors.sageTint,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/icons/mail_check.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Check your inbox',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: DarnaColors.primary,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Reset instructions have been requested for $_submittedEmail. If there's an account, you'll receive an email shortly.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                  color: DarnaColors.textPrimary,
                                  height: 1.6,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Open the secure reset link in your email to choose a new password, then return to Log In.',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontSize: 13,
                                  color: DarnaColors.textSecondary,
                                  height: 1.6,
                                ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: 1,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0x00D4AF37),
                                  Color(0x66D4AF37),
                                  Color(0x00D4AF37),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          DarnaPrimaryButton(
                            label: 'Back to Log In',
                            onPressed: widget.onBackToLogin,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'No email? Check your spam folder or resend instructions after 60 seconds.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 13,
                            color: DarnaColors.textPrimary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}