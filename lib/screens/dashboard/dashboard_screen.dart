import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    this.onTabSelected,
    this.onViewFinancialDetails,
    this.onAllBills,
    this.onHeaderAction,
  });

  final ValueChanged<DarnaNavTab>? onTabSelected;
  final VoidCallback? onViewFinancialDetails;
  final VoidCallback? onAllBills;
  final VoidCallback? onHeaderAction;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DarnaNavTab _tab = DarnaNavTab.dashboard;

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
              _PageHeading(onHeaderAction: widget.onHeaderAction),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _HeroCard(),
                      const SizedBox(height: 14),
                      const _MonthlySpendingSection(),
                      const SizedBox(height: 14),
                      const _HousingProgressSection(),
                      const SizedBox(height: 14),
                      _DueDatesSection(onAllBills: widget.onAllBills),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
              _CtaButton(onTap: widget.onViewFinancialDetails),
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
      ),
    );
  }
}

class _PageHeading extends StatelessWidget {
  const _PageHeading({this.onHeaderAction});

  final VoidCallback? onHeaderAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'JUNE 2026 · DZD',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF626B64),
                    height: 1.5,
                  ),
                ),
                Text(
                  'The bigger picture',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.textPrimary,
                    height: 1.18,
                    letterSpacing: -0.9,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onHeaderAction,
            child: Container(
              width: 36,
              height: 36,
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
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/sliders_horizontal.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F4D46),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(15, 46, 38, 0.28),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 3,
              width: double.infinity,
              color: DarnaColors.mutedGold,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 23),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '2229 DZD',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: DarnaColors.ivory,
                          height: 1.1,
                          letterSpacing: -1.5,
                        ),
                      ),
                      Text(
                        'Remaining to record this month',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFA8C5BC),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: DarnaColors.mutedGold.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Paid · 1 bill',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFA8C5BC),
                              ),
                            ),
                            Text(
                              '1450 DZD',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: DarnaColors.ivory,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 44,
                        color: DarnaColors.mutedGold.withValues(alpha: 0.25),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Unpaid · 4 bills',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFA8C5BC),
                                ),
                              ),
                              Text(
                                '12300 DZD',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: DarnaColors.ivory,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E6F63),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 169,
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [DarnaColors.mutedGold, Color(0xFFF0D060)],
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '56% of 12000 DZD recorded as paid',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFA8C5BC),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthlySpendingSection extends StatelessWidget {
  const _MonthlySpendingSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Monthly spending',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: DarnaColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: DarnaColors.border),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
                BoxShadow(
                  color: Color.fromRGBO(38, 46, 41, 0.05),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Recorded expenses so far',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF626B64),
                        height: 1.5,
                      ),
                    ),
                    Text(
                      '11234 DZD',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: DarnaColors.textPrimary,
                        height: 1.1,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(height: 1, width: double.infinity, color: DarnaColors.border),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Bills recorded paid',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF626B64),
                            height: 1.5,
                          ),
                        ),
                      ),
                      Text(
                        '12333 DZD',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: DarnaColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Groceries + other purchases',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF626B64),
                            height: 1.5,
                          ),
                        ),
                      ),
                      Text(
                        '12329 DZD',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: DarnaColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 1, width: double.infinity, color: DarnaColors.border),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _MonthBar(
                      topLabel: '28909 DZD',
                      barHeight: 20.9,
                      barColor: Color(0xFFDCE7D8),
                      bottomLabel: 'Apr',
                    ),
                    SizedBox(width: 0),
                    _MonthBar(
                      topLabel: '31240 DZD',
                      barHeight: 24.2,
                      barColor: Color(0xFFDCE7D8),
                      bottomLabel: 'May',
                    ),
                    _MonthBar(
                      topLabel: '123009 DZD',
                      barHeight: 14.3,
                      barColor: Color(0xFF0F4D46),
                      bottomLabel: 'Jun¹',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '¹ June is in progress, through June 16.  ·  User-entered expenses, not bank transactions.',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3A0),
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

class _MonthBar extends StatelessWidget {
  const _MonthBar({
    required this.topLabel,
    required this.barHeight,
    required this.barColor,
    required this.bottomLabel,
  });

  final String topLabel;
  final double barHeight;
  final Color barColor;
  final String bottomLabel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            topLabel,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0xFF626B64),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: barHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            bottomLabel,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0xFF626B64),
            ),
          ),
        ],
      ),
    );
  }
}

class _HousingProgressSection extends StatelessWidget {
  const _HousingProgressSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F4D46),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(15, 46, 38, 0.22),
              blurRadius: 20,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E6F63),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/icons/house_gold.svg',
                          width: 18,
                          height: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'A home, one step at a time',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: DarnaColors.ivory,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Paid toward 1023456 DZD',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA8C5BC),
                          ),
                        ),
                      ),
                      const Text(
                        '306000 DZD',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: DarnaColors.ivory,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E6F63),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 91,
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [DarnaColors.mutedGold, Color(0xFFF0D060)],
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Remaining',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA8C5BC),
                          ),
                        ),
                      ),
                      const Text(
                        '712340990 DZD',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.ivory,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '36 of 120 payments recorded · 84 to go. Next: June 28, 2026. Estimated finish: May 2033, if all remaining 850 DZD monthly payments are recorded on schedule.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7FAAA0),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 4,
              width: double.infinity,
              color: DarnaColors.mutedGold.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

class _DueDatesSection extends StatelessWidget {
  const _DueDatesSection({this.onAllBills});

  final VoidCallback? onAllBills;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Next due dates',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.textPrimary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onAllBills,
                child: const Text(
                  'All bills',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0F4D46),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: DarnaColors.border),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(38, 46, 41, 0.05),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: const [
                _DueRow(
                  icon: 'assets/icons/icon_electricity.svg',
                  title: 'Electricity',
                  date: 'Jun 18',
                  amount: '148 DZD',
                  iconBg: Color(0xFFDCE7D8),
                  showDivider: true,
                ),
                _DueRow(
                  icon: 'assets/icons/icon_water.svg',
                  title: 'Water',
                  date: 'Jun 20',
                  amount: '62 DZD',
                  iconBg: Color(0xFFDCE7D8),
                  showDivider: true,
                ),
                _DueRow(
                  icon: 'assets/icons/icon_gas.svg',
                  title: 'Gas',
                  date: 'Jun 22',
                  amount: '100 DZD',
                  iconBg: Color(0xFFDCE7D8),
                  showDivider: true,
                ),
                _DueRow(
                  icon: 'assets/icons/icon_housing_installments.svg',
                  title: 'Installment',
                  date: 'Jun 28',
                  amount: '850 DZD',
                  iconBg: Color(0x2ED4AF37), // approx opacity 0.18
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DueRow extends StatelessWidget {
  const _DueRow({
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.iconBg,
    required this.showDivider,
  });

  final String icon;
  final String title;
  final String date;
  final String amount;
  final Color iconBg;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: Color(0xFFF0EDE6)))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(icon, width: 22, height: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.textPrimary,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF626B64),
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: DarnaColors.textPrimary,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFDCE7D8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Upcoming',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF254C3B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  const _CtaButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
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
          alignment: Alignment.center,
          child: const Text(
            'View financial details',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F4D46),
            ),
          ),
        ),
      ),
    );
  }
}