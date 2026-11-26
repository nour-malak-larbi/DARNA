import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/darna_colors.dart';
import '../../widgets/widgets.dart';

/// Welcome screen (`03 — Authentication / 01 Welcome`).
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
    required this.onLogin,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.ivory,
      body: Column(
        children: [
          // Top sage hero with 3D illustration
          Container(
            width: double.infinity,
            height: 286,
            color: DarnaColors.sageTint,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  right: -40,
                  top: 70,
                  width: 280,
                  height: 240,
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
                  right: 0,
                  top: 74,
                  width: 207,
                  height: 204,
                  child: Image.asset(
                    'assets/images/auth_welcome_3d.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 18, right: 160),
                    child: Text(
                      'A little more calm.\nA lot more home.',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: DarnaColors.primary,
                            height: 1.15,
                            letterSpacing: -1.4,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 16, 28, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 3,
                    decoration: BoxDecoration(
                      color: DarnaColors.mutedGold,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Bills, family plans and everyday finances. One thoughtful place to keep your household moving together.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: DarnaColors.textSecondary,
                          height: 1.6,
                        ),
                  ),
                  const SizedBox(height: 14),

                  // Product introduction sage card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: DarnaColors.sageTint,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F000000),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'A SHARED SENSE OF HOME',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        fontSize: 10,
                                        letterSpacing: 1,
                                        color: DarnaColors.navActive,
                                      ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Less to keep in mind.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: DarnaColors.navActive,
                                      ),
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              'assets/icons/house_auth.svg',
                              width: 28,
                              height: 28,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            for (final avatar in const [
                              'assets/images/avatar_lina.png',
                              'assets/images/avatar_omar.png',
                              'assets/images/avatar_maya.png',
                            ]) ...[
                              ClipOval(
                                child: Image.asset(
                                  avatar,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              'Better, together.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: DarnaColors.navActive,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: DarnaColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: DarnaColors.border),
                            boxShadow: DarnaColors.cardShadow,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/circle_check_auth.svg',
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'The little things, handled.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      'Clear bills. Shared responsibilities.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(fontSize: 13),
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
                  const SizedBox(height: 16),

                  // Primary CTA with arrow icon
                  SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: DarnaColors.primary,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: onGetStarted,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/arrow_right.svg',
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Get Started',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: DarnaColors.ivory,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DarnaSecondaryButton(
                    label: 'Log In',
                    onPressed: onLogin,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Your home, better managed.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                          ),
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
