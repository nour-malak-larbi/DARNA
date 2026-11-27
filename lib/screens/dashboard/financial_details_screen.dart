import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Financial details screen (`04 — Home & Dashboard / Financial details`).
class FinancialDetailsScreen extends StatelessWidget {
  const FinancialDetailsScreen({
    super.key,
    this.onBack,
    this.onViewAllBills,
    this.onSalaryDistribution,
  });

  final VoidCallback? onBack;
  final VoidCallback? onViewAllBills;
  final VoidCallback? onSalaryDistribution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: SizedBox(
                  height: 120,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        "One clear view of what's planned, due and already recorded.",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: DarnaColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PlanSection(),
                      const SizedBox(height: 28),
                      _ObligationsSection(onViewAllBills: onViewAllBills),
                      const SizedBox(height: 28),
                      _SpendingSection(),
                    ],
                  ),
                ),
              ),
              _buildPinnedAction(),
              Container(
                height: 34,
                alignment: Alignment.center,
                child: Container(
                  width: 112,
                  height: 4,
                  decoration: BoxDecoration(
                    color: DarnaColors.textPrimary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'JUNE 2026 · DZD',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E6F63),
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Financial details',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.primary,
                    height: 1.18,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinnedAction() {
    return Container(
      color: DarnaColors.ivory,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2E6F63), DarnaColors.primary],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(15, 77, 70, 0.25),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onSalaryDistribution,
              child: const Center(
                child: Text(
                  'Salary Distribution',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.ivory,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.trailing});

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: DarnaColors.primary,
            ),
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2E6F63),
          ),
        ),
      ],
    );
  }
}

class _GoldRule extends StatelessWidget {
  const _GoldRule();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: DarnaColors.mutedGold.withValues(alpha: 0.5),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor = DarnaColors.textPrimary,
    this.valueWeight = FontWeight.w600,
    this.valueSize = 14,
    this.height = 46,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final Color valueColor;
  final FontWeight valueWeight;
  final double valueSize;
  final double height;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: DarnaColors.border))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
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
            style: TextStyle(
              fontSize: valueSize,
              fontWeight: valueWeight,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(title: 'Your monthly plan', trailing: 'June 2026'),
        const SizedBox(height: 16),
        const _GoldRule(),
        const _DetailRow(label: 'Income · user-entered', value: '6500 DZD',
            valueColor: DarnaColors.primary, valueWeight: FontWeight.w700,
            valueSize: 17),
        const _DetailRow(label: 'Allocated budget', value: '3500 DZD'),
        const _DetailRow(
          label: 'Unallocated',
          value: '3000 DZD',
          showDivider: false,
        ),
        const SizedBox(height: 16),
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: DarnaColors.sageTint,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 3500 / 6500,
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: DarnaColors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '3500 DZD allocated of 6500 DZD',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: DarnaColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ObligationsSection extends StatelessWidget {
  const _ObligationsSection({this.onViewAllBills});

  final VoidCallback? onViewAllBills;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(title: 'June obligations', trailing: '5 bills'),
        const SizedBox(height: 16),
        const _GoldRule(),
        const _DetailRow(label: 'Utilities · 3 bills', value: '3100ZD'),
        const _DetailRow(label: 'Rent · 1 bill', value: '14500 DZD'),
        const _DetailRow(label: 'Housing · 1 installment', value: '8500 DZD'),
        const _DetailRow(
          label: 'Total · 5 bills',
          value: '26100 DZD',
          valueColor: DarnaColors.primary,
          valueWeight: FontWeight.w700,
          valueSize: 18,
          height: 52,
        ),
        const _DetailRow(
          label: 'Paid · 1 of 5',
          value: '1450 DZD',
          valueColor: Color(0xFF2E6F63),
        ),
        const _DetailRow(
          label: 'Unpaid · 4 of 5',
          value: '1160 DZD',
          valueColor: Color(0xFFC18C66),
          showDivider: false,
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: onViewAllBills,
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: DarnaColors.ivory,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: DarnaColors.primary),
            ),
            alignment: Alignment.center,
            child: const Text(
              'View All Bills',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: DarnaColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SpendingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(
          title: 'Recorded spending',
          trailing: 'Through Jun 16',
        ),
        const SizedBox(height: 16),
        const _GoldRule(),
        const _DetailRow(label: 'Bills · rent paid Jun 01', value: '1,450 DZD'),
        const _DetailRow(
          label: 'Groceries · purchases to date',
          value: '320 DZD',
        ),
        const _DetailRow(label: 'Other · purchases to date', value: '40 DZD'),
        const _DetailRow(
          label: 'Total through Jun 16',
          value: '1,810 DZD',
          valueColor: DarnaColors.primary,
          valueWeight: FontWeight.w700,
          valueSize: 18,
          height: 52,
          showDivider: false,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: DarnaColors.infoBackground,
            borderRadius: BorderRadius.circular(10),
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
                  children: const [
                    Text(
                      "Planned isn't the same as spent",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF345A71),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Budgets are your own allocations. Spending includes only '
                      'expenses you manually record; upcoming bills are not '
                      'counted as spent.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: DarnaColors.textPrimary,
                        height: 1.5,
                      ),
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
}
