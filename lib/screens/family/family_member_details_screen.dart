import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Family Member Details screen (`06 — Family Space / 12 Family Member Details`).
class FamilyMemberDetailsScreen extends StatelessWidget {
  const FamilyMemberDetailsScreen({
    super.key,
    this.onBack,
    this.onAssignResponsibility,
    this.onAssignAnother,
  });

  final VoidCallback? onBack;
  final VoidCallback? onAssignResponsibility;
  final VoidCallback? onAssignAnother;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3E9),
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
              _buildHero(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _assignedBills(),
                      const SizedBox(height: 12),
                      _pendingTasks(),
                      const SizedBox(height: 12),
                      _completedTasks(),
                      const SizedBox(height: 12),
                      _linkedPurchasesCard(),
                      const SizedBox(height: 16),
                      _assignAnotherButton(onTap: onAssignAnother),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: DarnaColors.primary,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F4D46), Color(0xFF0F4D46)],
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: DarnaColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                              'Larbi  Household · Member',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFA8C5BC),
                                height: 1.5,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const Text(
                              'Omar Larbi',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: DarnaColors.mutedGold, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 26,
                          backgroundColor: Color(0xFF2E6F63),
                          child: Icon(Icons.person, size: 26, color: DarnaColors.ivory),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Thanks for your help, Omar.',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: DarnaColors.ivory,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Text(
                                  '2 bills · 1 pending task',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFFA8C5BC),
                                    height: 1.5,
                                  ),
                                ),
                                Container(
                                  width: 3,
                                  height: 3,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: DarnaColors.mutedGold,
                                  ),
                                ),
                                const Text(
                                  'Next: Jun 17',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: DarnaColors.mutedGold,
                                    height: 1.5,
                                  ),
                                ),
                              ],
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
          Container(
            height: 3,
            width: double.infinity,
            color: DarnaColors.mutedGold,
          ),
        ],
      ),
    );
  }

  Widget _assignedBills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assigned bills',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: DarnaColors.textPrimary,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: DarnaColors.border),
            boxShadow: DarnaColors.cardShadow,
          ),
          child: Column(
            children: [
              _billRow(
                icon: 'assets/icons/zap.svg',
                iconBg: const Color(0xFFF7F3E8),
                title: 'Electricity',
                subtitle: 'Jun 18 · Omar',
                amount: '14800 DZD',
                status: 'Upcoming',
              ),
              Container(
                color: const Color(0xFFF0EDE6),
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              _billRow(
                icon: 'assets/icons/flame.svg',
                iconBg: Colors.white,
                title: 'Gas',
                subtitle: 'Jun 22 · Omar',
                amount: '1000 DZD',
                status: 'Upcoming',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _billRow({
    required String icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String amount,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        border: Border.all(color: DarnaColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(icon, width: 20, height: 20),
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
                    height: 1.4,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCE7D8),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.schedule, size: 12, color: DarnaColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: DarnaColors.textPrimary,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tasksSection(String heading, bool completed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: DarnaColors.textPrimary,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: DarnaColors.border),
            boxShadow: DarnaColors.cardShadow,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                decoration: BoxDecoration(border: Border.all(color: DarnaColors.border)),
                child: Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF626B64)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            completed ? 'Compare electricity statements' : 'Check meter reading',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: completed
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: DarnaColors.textPrimary,
                              height: 1.4,
                            ),
                          ),
                          Text(
                            completed
                                ? 'Completed Jun 12 · Omar'
                                : 'Jun 17 · for electricity review · Omar',
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
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFFDCE7D8),
                      child: Icon(Icons.person, size: 14, color: Color(0xFF254C3B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pendingTasks() {
    return _tasksSection('Pending', false);
  }

  Widget _completedTasks() {
    return _tasksSection('Completed', true);
  }

  Widget _linkedPurchasesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DarnaColors.border),
        boxShadow: DarnaColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Linked purchases',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: DarnaColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'No purchases assigned to Omar yet. You can share a shopping responsibility from Family Space.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _assignAnotherButton({VoidCallback? onTap}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        color: DarnaColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(14),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F4D46), Color(0xFF1A6459)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x330F4D46),
            blurRadius: 12,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Center(
        child: const Text(
          'Assign another responsibility',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: DarnaColors.ivory,
          ),
        ),
      ),
    );
  }
}
