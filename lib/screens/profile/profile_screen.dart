import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/core/user/darna_user.dart';
import 'package:darna_app/widgets/widgets.dart';

/// Profile screen (`09 — Profile & Settings / 18 Profile`).
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.user,
    this.onSettings,
    this.onOpenFamilySpace,
    this.onEditProfile,
    this.onTabSelected,
    this.onUserUpdated,
  });

  final DarnaUser? user;
  final VoidCallback? onSettings;
  final VoidCallback? onOpenFamilySpace;
  final VoidCallback? onEditProfile;
  final ValueChanged<DarnaNavTab>? onTabSelected;
  final ValueChanged<DarnaUser>? onUserUpdated;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DarnaNavTab _tab = DarnaNavTab.profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.ivory,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _HeroHeader(
              onSettings: widget.onSettings,
              name: widget.user?.name,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFC7E4DB), Colors.white],
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProfileIdentityCard(
                        user: widget.user,
                        onUserUpdated: widget.onUserUpdated,
                      ),
                      const SizedBox(height: 12),
                      _HouseholdCard(onOpenFamilySpace: widget.onOpenFamilySpace),
                      const SizedBox(height: 12),
                      _ProfileRoutes(
                        onSettings: widget.onSettings,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Darna · Your home, better managed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFA0A8A2),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
            DarnaBottomNavBar(
              selectedTab: _tab,
              onTabSelected: (t) {
                setState(() => _tab = t);
                widget.onTabSelected?.call(t);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({this.onSettings, this.name});

  final VoidCallback? onSettings;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 191,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF0F4D46), Color(0xFF23B3A3)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PROFILE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.mutedGold,
                          height: 1.5,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Your corner of home',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.ivory,
                          height: 1.18,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onSettings,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E6F63),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x260F4D46),
                          blurRadius: 7,
                          offset: Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Color(0x470F4D46),
                          blurRadius: 0,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/settings_white.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: DarnaColors.mutedGold, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avatar_maya.png',
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name ?? DarnaUser.guest.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.ivory,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E6F63),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/clock_3.svg',
                              width: 12,
                              height: 12,
                              colorFilter: const ColorFilter.mode(
                                DarnaColors.mutedGold,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Household owner',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: DarnaColors.mutedGold,
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
          ],
        ),
      ),
    );
  }
}

class _ProfileIdentityCard extends StatefulWidget {
  const _ProfileIdentityCard({this.user, this.onUserUpdated});

  final DarnaUser? user;
  final ValueChanged<DarnaUser>? onUserUpdated;

  @override
  State<_ProfileIdentityCard> createState() => _ProfileIdentityCardState();
}

class _ProfileIdentityCardState extends State<_ProfileIdentityCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final user = widget.user ?? DarnaUser.guest;
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  DarnaUser get _currentUser => DarnaUser(
        name: _nameController.text.trim().isNotEmpty
            ? _nameController.text.trim()
            : (widget.user?.name ?? DarnaUser.guest.name),
        email: _emailController.text.trim().isNotEmpty
            ? _emailController.text.trim()
            : (widget.user?.email ?? DarnaUser.guest.email),
        phone: _phoneController.text.trim().isNotEmpty
            ? _phoneController.text.trim()
            : (widget.user?.phone ?? DarnaUser.guest.phone),
      );

  void _save() {
    widget.onUserUpdated?.call(_currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarnaColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DarnaColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x260F4D46),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
          BoxShadow(
            color: Color(0x1A0F4D46),
            blurRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: DarnaColors.mutedGold,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          _DetailRow(label: 'Email', value: _currentUser.email),
          const _Divider(),
          _DetailRow(label: 'Phone', value: _currentUser.phone),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _save,
            child: Container(
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                color: DarnaColors.ivory,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: DarnaColors.sageTint),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x260F4D46),
                    blurRadius: 7,
                    offset: Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Color(0x470F4D46),
                    blurRadius: 0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/pencil.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      DarnaColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: DarnaColors.primary,
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: DarnaColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: DarnaColors.border,
      margin: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}

class _HouseholdCard extends StatelessWidget {
  const _HouseholdCard({this.onOpenFamilySpace});

  final VoidCallback? onOpenFamilySpace;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarnaColors.sageTint,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x260F4D46),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
          BoxShadow(
            color: Color(0x1A0F4D46),
            blurRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Larbi household',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.primary,
                    height: 1.4,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: DarnaColors.primary, width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/avatar_maya.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Maya, Omar and Lina · 3 people sharing the everyday.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: DarnaColors.primary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onOpenFamilySpace,
            child: Container(
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                color: DarnaColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: DarnaColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x260F4D46),
                    blurRadius: 7,
                    offset: Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Color(0x470F4D46),
                    blurRadius: 0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/users_round.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      DarnaColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Open Family Space',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: DarnaColors.primary,
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

class _ProfileRoutes extends StatelessWidget {
  const _ProfileRoutes({this.onSettings});

  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Make Darna yours',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: DarnaColors.textPrimary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        _RouteRow(
          icon: 'assets/icons/settings_icon.svg',
          iconBg: DarnaColors.sageTint,
          title: 'Settings',
          subtitle: 'Reminders, currency, language and account',
          onTap: onSettings,
          showDivider: true,
        ),
        _RouteRow(
          icon: 'assets/icons/help_circle.svg',
          iconBg: DarnaColors.sageTint,
          title: 'Help & support',
          subtitle: 'A little guidance when you need it',
          onTap: () {},
          showDivider: false,
        ),
      ],
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.showDivider = true,
  });

  final String icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: DarnaColors.border))
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(icon, width: 18, height: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DarnaColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: DarnaColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/icons/chevron_right.svg',
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}