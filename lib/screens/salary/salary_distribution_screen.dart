import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

/// Salary Distribution screen (`08 — Salary & Insights / 16 Salary Distribution`).
class SalaryDistributionScreen extends StatelessWidget {
  const SalaryDistributionScreen({
    super.key,
    this.onBack,
    this.onEditIncome,
    this.onEditAllocation,
    this.onEditAll,
    this.onAllocationTap,
  });

  final VoidCallback? onBack;
  final VoidCallback? onEditIncome;
  final VoidCallback? onEditAllocation;
  final VoidCallback? onEditAll;
  final VoidCallback? onAllocationTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _buildHeading(context),
              const _GoldAccentLine(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMonthlyIncomeCard(),
                      const SizedBox(height: 12),
                      _buildAllocationSummaryCard(),
                      const SizedBox(height: 12),
                      _buildCategoriesSection(),
                      const SizedBox(height: 12),
                      _buildAlertCard(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              _buildBottomCta(),
              DarnaBottomNavBar(
                selectedTab: DarnaNavTab.home,
                onTabSelected: (_) {},
                showHomeIndicator: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.only(left: 24, right: 16, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onBack,
                      child: SvgPicture.asset(
                        'assets/icons/arrow_left_dark.svg',
                        width: 22,
                        height: 22,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'JUNE 2026 ·',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E6F63),
                        height: 1.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Give your income a plan',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F4D46),
                    height: 1.18,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 115,
            height: 101,
            child: Image.asset(
              'assets/images/salary/monthly_budget.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyIncomeCard() {
    return GestureDetector(
      onTap: onEditIncome,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: DarnaColors.border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x21093D36),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Monthly household income',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF626B64),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Entered by you · Edit income',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF262E29),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              '6,500 DZD',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F4D46),
                height: 1.0,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllocationSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F4D46), Color(0xFF23B3A3)],
          stops: [0.395, 1.0],
          transform: GradientRotation(2.229),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x400F4D46),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Remaining unallocated',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFFDCE7D8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            '3,000 DZD',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 8),
          _buildProgressArea(),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF2E6F63),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '54% allocated',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFDCE7D8),
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Keep this flexible — every dollar doesn\'t need a job yet.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFDCE7D8),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: Color(0x21FFFFFF),
            borderRadius: BorderRadius.circular(100),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.538,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD4AF37), Colors.white],
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '3,500 DZD allocated',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFFDCE7D8),
                height: 1.0,
              ),
            ),
            Text(
              '6,500 DZD income',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFFDCE7D8),
                height: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    const rows = [
      _AllocationData(
        icon: 'assets/icons/zap.svg',
        title: 'Utilities',
        subtitle: 'Electricity, water & gas',
        amount: '310 DZD',
      ),
      _AllocationData(
        icon: 'assets/icons/key_round.svg',
        title: 'Rent',
        subtitle: 'Monthly rental home',
        amount: '1,450 DZD',
      ),
      _AllocationData(
        icon: 'assets/icons/house.svg',
        title: 'Housing installments',
        subtitle: 'Family home payment plan',
        amount: '850 DZD',
      ),
      _AllocationData(
        icon: 'assets/icons/shopping_basket.svg',
        title: 'Groceries',
        subtitle: 'Household shopping budget',
        amount: '650 DZD',
      ),
      _AllocationData(
        icon: 'assets/icons/ellipsis.svg',
        title: 'Other',
        subtitle: 'Everyday flexibility',
        amount: '240 DZD',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Your allocations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F4D46),
                  height: 1.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: onEditAll,
              child: const Text(
                'Edit all',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFD4AF37),
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: DarnaColors.border),
          ),
          child: Column(
            children: List.generate(rows.length, (index) {
              final row = rows[index];
              final isLast = index == rows.length - 1;
              return _AllocationRow(
                data: row,
                showDivider: !isLast,
                onTap: onAllocationTap,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildAlertCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFEDF3F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0x212E6F63)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/info.svg',
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Your money, your rules',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F4D46),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Amounts are user-controlled, not fixed percentages. This plan does not move money, connect a bank or automatically pay bills.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF626B64),
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

  Widget _buildBottomCta() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: GestureDetector(
        onTap: onEditAllocation,
        child: Container(
          height: 54,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2E6F63), Color(0xFF0F4D46)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(14)),
            boxShadow: [
              BoxShadow(
                color: Color(0x3B062924),
                blurRadius: 12,
                offset: Offset(0, 8),
              ),
              BoxShadow(
                color: Color(0xF2062924),
                blurRadius: 0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/sliders_horizontal.svg',
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              const Text(
                'Edit allocation',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoldAccentLine extends StatelessWidget {
  const _GoldAccentLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 2,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x00D4AF37),
              Color(0xFFD4AF37),
              Color(0x00D4AF37),
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
      ),
    );
  }
}

class _AllocationData {
  const _AllocationData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  final String icon;
  final String title;
  final String subtitle;
  final String amount;
}

class _AllocationRow extends StatelessWidget {
  const _AllocationRow({
    required this.data,
    required this.showDivider,
    this.onTap,
  });

  final _AllocationData data;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: DarnaColors.border))
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: DarnaColors.sageTint,
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                data.icon,
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF262E29),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF262E29),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              data.amount,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F4D46),
                height: 1.0,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/icons/pencil.svg',
              width: 14,
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}