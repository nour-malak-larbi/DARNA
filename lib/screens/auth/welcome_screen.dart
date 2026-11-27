import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

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
      backgroundColor: DarnaColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Hero(onGetStarted: onGetStarted),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 16, 28, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _WelcomeMessage(),
                    const SizedBox(height: 14),
                    _ProductIntroduction(),
                    const SizedBox(height: 14),
                    _WelcomeActions(
                      onGetStarted: onGetStarted,
                      onLogin: onLogin,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.onGetStarted});
  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 286,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(color: DarnaColors.sageTint),
          Positioned(
            left: 185,
            top: 99,
            child: SizedBox(
              width: 300,
              height: 264,
              child: SvgPicture.asset(
                'assets/icons/welcome_emerald_backdrop.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 223,
            top: 74,
            child: Image.asset(
              'assets/images/welcome/welcome_3d.png',
              width: 207,
              height: 204,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: 289,
            top: 158,
            child: SizedBox(
              width: 78,
              height: 78,
              child: SvgPicture.asset(
                'assets/icons/welcome_lavender_bubble.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 301,
            top: 219,
            child: SizedBox(
              width: 34,
              height: 34,
              child: SvgPicture.asset(
                'assets/icons/welcome_coral_bubble.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 57,
            child: Text(
              'A little more calm.\nA lot more home.',
              style: GoogleFonts.manrope(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: DarnaColors.primary,
                letterSpacing: -1.7,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: DarnaColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _ProductIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: DarnaColors.sageTint,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
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
                children: const [
                  Text(
                    'A SHARED SENSE OF HOME',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: DarnaColors.navActive,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Less to keep in mind.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: DarnaColors.navActive,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/icons/house_welcome.svg',
                width: 28,
                height: 28,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final asset in [
                'assets/images/welcome/avatar_maya.png',
                'assets/images/welcome/avatar_omar.png',
                'assets/images/welcome/avatar_lina.png',
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ClipOval(
                    child: Image.asset(asset, width: 32, height: 32, fit: BoxFit.cover),
                  ),
                ),
              const Flexible(
                child: Text(
                  'Better, together.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: DarnaColors.navActive,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: DarnaColors.border),
              boxShadow: DarnaColors.cardShadow,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/circle_check_welcome.svg',
                  width: 22,
                  height: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'The little things, handled.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Clear bills. Shared responsibilities.',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: DarnaColors.textSecondary,
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
    );
  }
}

class _WelcomeActions extends StatelessWidget {
  const _WelcomeActions({required this.onGetStarted, required this.onLogin});
  final VoidCallback onGetStarted;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 54,
          width: double.infinity,
          decoration: BoxDecoration(
            color: DarnaColors.primary,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 2,
                offset: Offset(0, 4),
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
                    'assets/icons/arrow_right_welcome.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: DarnaColors.ivory,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: DarnaColors.border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onLogin,
              child: const Center(
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Your home, better managed.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}