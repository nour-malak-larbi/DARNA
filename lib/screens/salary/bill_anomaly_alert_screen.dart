import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

/// Bill Anomaly Alert screen (`08 — Salary & Insights / 17 Bill Anomaly Alert`).
class BillAnomalyAlertScreen extends StatelessWidget {
  const BillAnomalyAlertScreen({
    super.key,
    this.onBack,
    this.onReviewBill,
    this.onMarkAsExpected,
    this.onInvestigate,
  });

  final VoidCallback? onBack;
  final VoidCallback? onReviewBill;
  final VoidCallback? onMarkAsExpected;
  final VoidCallback? onInvestigate;

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
              _buildHero(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAlert(),
                      const SizedBox(height: 10),
                      _buildComparisonCard(),
                      const SizedBox(height: 12),
                      _buildContextCard(),
                      const SizedBox(height: 13),
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          'Mark as Expected dismisses this June alert only. '
                          "It doesn't change the amount or record a payment.",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF496258),
                            height: 16 / 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F4D46),
            Color(0xFF1FA192),
            Color(0xFF23B3A3),
          ],
          stops: [0.34, 0.86, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 34,
            right: 0,
            width: 145,
            height: 145,
            child: Image.asset(
              'assets/images/salary/bill_anomaly_electricity.png',
              fit: BoxFit.contain,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onBack,
                      child: SizedBox(
                        width: 30,
                        height: 40,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'assets/icons/arrow_left_white.svg',
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
                            'POTENTIAL CHANGE · ELECTRICITY',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFA8C4BE),
                              height: 1.5,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'A bill worth a look',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFF7F3E8),
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
              SizedBox(
                height: 108,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 16, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'June bill · due June 18',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA8C4BE),
                          height: 1.5,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: const [
                          Text(
                            '148',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFF7F3E8),
                              height: 1.0,
                              letterSpacing: -2,
                            ),
                          ),
                          Text(
                            ' DZD',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFA8C4BE),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      _buildAnomalyBadge(),
                    ],
                  ),
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: const Color(0x73D4AF37),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnomalyBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x21D4AF37),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0x54D4AF37)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/alert_gold.svg',
            width: 10,
            height: 10,
          ),
          const SizedBox(width: 4),
          const Text(
            '+38 DZD · +34.5%',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: DarnaColors.mutedGold,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/circle_alert_warning.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Higher than your recent average',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF73451A),
                    height: 18 / 13,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'This is a gentle heads-up, not a confirmed error. '
                  'There may be a perfectly ordinary reason.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF664F36),
                    height: 17 / 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(17, 13, 17, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: DarnaColors.border),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF103F3B), Color(0xFF2AA59B)],
          stops: [0.2, 1.0],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3307302C),
            blurRadius: 16,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 36,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Home electricity',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 24 / 17,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _buildComparisonColumn(
                  value: const Text(
                    '110 DZD',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE1ECCE),
                      height: 27 / 22,
                    ),
                  ),
                  barHeight: 40,
                  barColor: const Color(0xFFDCE8CA),
                  label: 'Usual avg',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildComparisonColumn(
                  value: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: const [
                      Text(
                        '148 DZD',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFCC91),
                          height: 27 / 22,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '+34.5%',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFCC91),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  barHeight: 54,
                  barColor: const Color(0xFFF2AB72),
                  label: 'June',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Expanded(
                child: Text(
                  'Recent average · Mar–May',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFC9DBD4),
                    height: 18 / 11,
                  ),
                ),
              ),
              Text(
                '110 DZD',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 18 / 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          const Text(
            'Based on 3 manually entered bills: March 110 DZD, '
            'April 108 DZD, May 112 DZD.',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFFC9DBD4),
              height: 16 / 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonColumn({
    required Widget value,
    required double barHeight,
    required Color barColor,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        value,
        const SizedBox(height: 4),
        Container(
          height: barHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Color(0xFFD8E7E1),
            height: 16 / 11,
          ),
        ),
      ],
    );
  }

  Widget _buildContextCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F1E7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'What might explain it?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF153F39),
              height: 23 / 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'More cooling, a longer billing period or a rate change can '
            'increase a bill. Check your entry and provider statement '
            'before deciding.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF455B50),
              height: 17 / 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onReviewBill,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: DarnaColors.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3B062924),
                    blurRadius: 6,
                    offset: Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Color(0xF2062924),
                    blurRadius: 0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/arrow_right.svg',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Review Bill',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF7F3E8),
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: const Color(0xB3D4AF37),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DarnaSecondaryButton(
                  label: 'Mark as Expected',
                  onPressed: onMarkAsExpected,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DarnaSecondaryButton(
                  label: 'Investigate',
                  onPressed: onInvestigate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: 112,
            height: 4,
            decoration: BoxDecoration(
              color: DarnaColors.textPrimary,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
