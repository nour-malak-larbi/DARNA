import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Assign Responsibility screen (`06 — Family Space / 11 Assign Responsibility`).
class AssignResponsibilityScreen extends StatelessWidget {
  const AssignResponsibilityScreen({
    super.key,
    this.onBack,
    this.onConfirmAssignment,
  });

  final VoidCallback? onBack;
  final VoidCallback? onConfirmAssignment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC7E4DB),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFC7E4DB), Colors.white],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildHeading(),
              _buildArt(),
              const Divider(color: DarnaColors.border, height: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Who can help?',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: DarnaColors.primary,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const _MemberRow(
                        name: 'Maya Larbi',
                        subtitle: 'You · currently responsible',
                        selected: false,
                      ),
                      const SizedBox(height: 6),
                      const _MemberRow(
                        name: 'Omar Larbi',
                        subtitle: '2 upcoming bills · 1 task',
                        selected: false,
                      ),
                      const SizedBox(height: 6),
                      const _MemberRow(
                        name: 'Lina Larbi',
                        subtitle: '1 household task',
                        selected: true,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'What needs a hand?',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: DarnaColors.primary,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 7),
                      _FilterTab(
                        label: 'Bill',
                        selected: true,
                        onTap: () {},
                      ),
                      const SizedBox(height: 6),
                      _FilterTab(label: 'Purchase', selected: false, onTap: () {}),
                      const SizedBox(height: 6),
                      _FilterTab(label: 'Task', selected: false, onTap: () {}),
                      const SizedBox(height: 14),
                      _AssigneeField(
                        label: 'Choose bill',
                        controller: TextEditingController(
                          text: 'Water · 62 DZD · Jun 20',
                        ),
                        suffixIcon: Icons.chevron_right,
                      ),
                      const SizedBox(height: 14),
                      _AssigneeField(
                        label: 'Deadline',
                        controller: TextEditingController(text: 'June 20, 2026'),
                        suffixIcon: Icons.calendar_today,
                      ),
                      const SizedBox(height: 14),
                      _AssigneeField(
                        label: 'Note · optional',
                        controller: TextEditingController(
                          text: 'Please check the water bill and add the payment record when paid.',
                        ),
                        maxLines: true,
                      ),
                      const SizedBox(height: 14),
                      _AssigneeField(
                        label: 'Reminder',
                        controller: TextEditingController(text: '1 day before · 9:00 AM'),
                        suffixIcon: Icons.notifications_outlined,
                      ),
                      const SizedBox(height: 14),
                      _AssignmentAlert(),
                    ],
                  ),
                ),
              ),
              _buildActionFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 30,
              height: 40,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LARBI  HOUSEHOLD',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  'Share a responsibility',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
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
    );
  }

  Widget _buildArt() {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'A small handoff can make everyone\'s day lighter.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: DarnaColors.textSecondary,
                      height: 1.38,
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: const BoxDecoration(
                      color: DarnaColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 12, color: DarnaColors.ivory),
                        SizedBox(width: 4),
                        Text(
                          'Assigning to Lina',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: DarnaColors.ivory,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 78,
              height: 66,
              child: Image.asset(
                'assets/images/member_avatar.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionFooter() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: const BoxDecoration(
              color: DarnaColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(14)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x330F4D46),
                  blurRadius: 12,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'Confirm assignment',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: DarnaColors.ivory,
              ),
            ),
          ),
          Container(
            width: 112,
            height: 4,
            decoration: BoxDecoration(
              color: DarnaColors.textPrimary,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({
    required this.name,
    required this.subtitle,
    required this.selected,
  });

  final String name;
  final String subtitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? DarnaColors.primary : DarnaColors.border,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F09351B),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFDCE7D8),
            child: Icon(Icons.person, size: 18, color: Color(0xFF254C3B)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: selected ? DarnaColors.primary : DarnaColors.textPrimary,
                    height: 1.33,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: selected ? Color(0xFF2E6F63) : DarnaColors.textSecondary,
                    height: 1.42,
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle, size: 18, color: DarnaColors.primary),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  const _FilterTab({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 34,
          decoration: BoxDecoration(
            color: selected ? DarnaColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? DarnaColors.primary : DarnaColors.border,
            ),
            boxShadow: selected
                ? const [
                    BoxShadow(
                      color: Color(0x0F09351B),
                      blurRadius: 7,
                      offset: Offset(0, 4),
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x0F09351B),
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              color: selected ? DarnaColors.ivory : DarnaColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _AssigneeField extends StatelessWidget {
  const _AssigneeField({
    required this.label,
    required this.controller,
    this.suffixIcon,
    this.maxLines = false,
  });

  final String label;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final bool maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: DarnaColors.textPrimary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: DarnaColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines ? 3 : 1,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textPrimary,
              height: 1.5,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              suffixIcon: suffixIcon == null
                  ? null
                  : Icon(suffixIcon, size: 18, color: DarnaColors.textSecondary),
            ),
          ),
        ),
      ],
    );
  }
}

class _AssignmentAlert extends StatelessWidget {
  const _AssignmentAlert();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFFE8F4F1),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F09351B),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 20, color: Color(0xFF0F4D46)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lina will see the assignment',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.primary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Water moves from Maya to Lina. The bill amount and due date stay the same. This does not make a payment.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2E6F63),
                    height: 1.5,
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
