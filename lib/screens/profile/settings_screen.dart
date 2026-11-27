import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

/// Settings screen (`09 — Profile & Settings / 19 Settings`).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    this.onBack,
    this.onTabSelected,
    this.onLogOut,
  });

  final VoidCallback? onBack;
  final ValueChanged<DarnaNavTab>? onTabSelected;
  final VoidCallback? onLogOut;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  DarnaNavTab _tab = DarnaNavTab.profile;

  bool _billReminders = true;
  bool _familyAssignments = true;
  bool _tasksEvents = true;
  bool _weeklySummary = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.ivory,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 40,
                    child: GestureDetector(
                      onTap: widget.onBack,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          'assets/icons/arrow_left_dark.svg',
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'SETTINGS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2E6F63),
                            height: 1.5,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Make yourself at home',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: DarnaColors.primary,
                            height: 1.18,
                            letterSpacing: -0.9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Section(
                        title: 'A gentle nudge',
                        children: [
                          _PreferenceRow(
                            title: 'Bill reminders',
                            subtitle: 'On · 2 days before, 9:00 AM',
                            trailing: _Toggle(
                              value: _billReminders,
                              onChanged: (v) =>
                                  setState(() => _billReminders = v),
                            ),
                            showDivider: true,
                          ),
                          _PreferenceRow(
                            title: 'Family assignments',
                            subtitle: 'When a responsibility is shared',
                            trailing: _Toggle(
                              value: _familyAssignments,
                              onChanged: (v) =>
                                  setState(() => _familyAssignments = v),
                            ),
                            showDivider: true,
                          ),
                          _PreferenceRow(
                            title: 'Tasks & events',
                            subtitle: 'At the time you choose',
                            trailing: _Toggle(
                              value: _tasksEvents,
                              onChanged: (v) =>
                                  setState(() => _tasksEvents = v),
                            ),
                            showDivider: true,
                          ),
                          _PreferenceRow(
                            title: 'Weekly household summary',
                            subtitle: 'A quiet Sunday overview',
                            trailing: _Toggle(
                              value: _weeklySummary,
                              onChanged: (v) =>
                                  setState(() => _weeklySummary = v),
                            ),
                            showDivider: true,
                          ),
                          _PreferenceRow(
                            title: 'Default reminder time',
                            subtitle: '9:00 AM · America/New_York',
                            trailing: SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                              width: 18,
                              height: 18,
                            ),
                            showDivider: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _Section(
                        title: 'Your preferences',
                        children: [
                          _PreferenceRow(
                            title: 'Currency & region',
                            subtitle: 'DZD · Algeria',
                            trailing: SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                              width: 18,
                              height: 18,
                            ),
                            showDivider: true,
                          ),
                          _PreferenceRow(
                            title: 'Language',
                            subtitle: 'English',
                            trailing: SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                              width: 18,
                              height: 18,
                            ),
                            showDivider: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _Section(
                        title: 'Privacy & account',
                        children: [
                          _PreferenceRow(
                            title: 'Privacy & data',
                            subtitle: 'Your records, your control',
                            trailing: SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                              width: 18,
                              height: 18,
                            ),
                            showDivider: true,
                          ),
                          _PreferenceRow(
                            title: 'Account security',
                            subtitle: 'Password and sign-in help',
                            trailing: SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                              width: 18,
                              height: 18,
                            ),
                            showDivider: true,
                          ),
                          _PreferenceRow(
                            title: 'Help & support',
                            subtitle: 'Guides, contact and feedback',
                            trailing: SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                              width: 18,
                              height: 18,
                            ),
                            showDivider: true,
                          ),
                          _PreferenceRow(
                            title: 'Terms of Use',
                            subtitle: 'How Darna works',
                            trailing: SvgPicture.asset(
                              'assets/icons/chevron_right.svg',
                              width: 18,
                              height: 18,
                            ),
                            showDivider: false,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _SettingsFooter(onLogOut: widget.onLogOut),
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

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3,
              height: 18,
              decoration: BoxDecoration(
                color: DarnaColors.mutedGold,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: DarnaColors.primary,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.showDivider = true,
  });

  final String title;
  final String subtitle;
  final Widget trailing;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: Color(0xFFF0EDE6)))
            : null,
      ),
      child: Row(
        children: [
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
          const SizedBox(width: 12),
          trailing,
        ],
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  const _Toggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 42,
        height: 26,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? DarnaColors.primary : DarnaColors.disabledSurface,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _SettingsFooter extends StatelessWidget {
  const _SettingsFooter({this.onLogOut});

  final VoidCallback? onLogOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onLogOut,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: DarnaColors.primary,
              borderRadius: BorderRadius.circular(12),
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
            child: const Text(
              'Log Out',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Darna v1.0 · User-entered, household-shared.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: DarnaColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}