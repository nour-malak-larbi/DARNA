import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Bill Details screen (`05 — Bills & Services / 09 Bill Details`).
class BillDetailsScreen extends StatelessWidget {
  const BillDetailsScreen({
    super.key,
    this.onBack,
    this.onEditBill,
    this.onMarkPaid,
    this.onAssign,
    this.onEditReminder,
    this.onViewHistory,
    this.onReviewBillAlert,
  });

  final VoidCallback? onBack;
  final VoidCallback? onEditBill;
  final VoidCallback? onMarkPaid;
  final VoidCallback? onAssign;
  final VoidCallback? onEditReminder;
  final VoidCallback? onViewHistory;
  final VoidCallback? onReviewBillAlert;

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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),
                child: _buildHeading(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroCard(),
                      const SizedBox(height: 16),
                      _buildDetailsCard(),
                      const SizedBox(height: 16),
                      _buildHistorySection(),
                      const SizedBox(height: 16),
                      _buildNextOccurrence(),
                      const SizedBox(height: 16),
                      _buildAnomalyAlert(),
                      const SizedBox(height: 16),
                      _buildResponsibilitySection(),
                      const SizedBox(height: 16),
                      _buildInfoAlert(),
                      const SizedBox(height: 16),
                      _buildEditBillButton(),
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

  Widget _buildHeading(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 36,
          child: GestureDetector(
            onTap: onBack,
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
                'HOME ELECTRICITY · JUNE 2026',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2E6F63),
                  height: 1.4,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 1),
              Text(
                'Electricity',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F4D46),
                  height: 1.18,
                  letterSpacing: -0.9,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onEditBill,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: DarnaColors.border),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/bill_details_pencil.svg',
              width: 18,
              height: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment(0.33, -0.94),
          end: Alignment(1.06, 1.34),
          colors: [Color(0xFF0F4D46), Color(0xFF23B3A3)],
          stops: [0.498, 1.0],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x300F4D46),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          const SizedBox(height: 14, width: double.infinity),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                _buildStatusPill(),
                const SizedBox(height: 14),
                const Text(
                  'Current bill',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xCCF7F3E8),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '148 DZD',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0x80F7F3E8),
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: const [
                    SizedBox(
                      width: 3,
                      height: 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFD4AF37),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Due June 18, 2026',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xB3F7F3E8),
                        height: 1.0,
                      ),
                    ),
                    SizedBox(width: 6),
                    SizedBox(
                      width: 3,
                      height: 3,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFD4AF37),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Monthly · day 18',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xB3F7F3E8),
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: onReviewBillAlert,
                  child: Container(
                    height: 46,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0x40D4AF37),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0x33D4AF37),
                          Color(0x00D4AF37),
                        ],
                        stops: [0.0, 0.6],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            gradient: LinearGradient(
                              begin: Alignment(0.09, 0.96),
                              end: Alignment(0.91, 0.04),
                              colors: [
                                Color(0xFF1A6358),
                                Color(0xFF2E6F63),
                                Color(0xFF1A6358),
                              ],
                              stops: [0.25, 0.5, 0.75],
                            ),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/bill_details_arrow_right.svg',
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Review bill alert',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFF7F3E8),
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -9,
            right: -18,
            child: Opacity(
              opacity: 0.22,
              child: Image.asset(
                'assets/images/bill_details_motion_artwork.png',
                width: 52,
                height: 52,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x26FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/bill_details_clock_3.svg',
            width: 11,
            height: 11,
          ),
          const SizedBox(width: 5),
          const Text(
            'Unpaid · upcoming',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF7F3E8),
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return _card(
      child: Column(
        children: [
          _detailRow('Provider', 'City Electric', const Color(0xFF0F4D46), true),
          _detailRow('Reference', 'CE-4821', const Color(0xFF262E29), true),
          _detailRow('Recurrence', 'Monthly · day 18', const Color(0xFF262E29), false),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, Color valueColor, bool divider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        border: divider
            ? const Border(bottom: BorderSide(color: Color(0xFFF0EDE6)))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF626B64),
                height: 1.5,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Recent bill history',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF262E29),
                  height: 1.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: onViewHistory,
              child: const Text(
                'View history',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F4D46),
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _card(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _historyRow('May 18 · Paid · recorded', '112 DZD', true),
              _historyRow('Apr 18 · Paid · recorded', '108 DZD', true),
              _historyRow('Mar 18 · Paid · recorded', '110 DZD', true),
              Container(
                color: const Color(0xFFF7F3E8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '3-month average',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF626B64),
                          height: 1.5,
                        ),
                      ),
                    ),
                    const Text(
                      '110 DZD',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F4D46),
                        height: 1.0,
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

  Widget _historyRow(String label, String amount, bool divider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: divider
            ? const Border(bottom: BorderSide(color: Color(0xFFF0EDE6)))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF626B64),
                height: 1.5,
              ),
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF262E29),
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextOccurrence() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE7D8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Next occurrence · July 18',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F4D46),
              height: 1.4,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Expected 110 DZD. Actual amount hasn't been entered yet. Your July reminder is July 16 at 9:00 AM.",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF262E29),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnomalyAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6EE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDD9C0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bill_details_circle_alert.svg',
                width: 12,
                height: 12,
              ),
              const SizedBox(width: 6),
              const Text(
                'Worth a look',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF805421),
                  height: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '38 DZD higher than your usual bill',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF262E29),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '+34.5% compared with your 110 DZD average. A change in usage or rates may explain it.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF626B64),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsibilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Who's taking care of it?",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF262E29),
                  height: 1.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: onAssign,
              child: const Text(
                'Assign',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F4D46),
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _card(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/avatar_omar.png',
                  width: 38,
                  height: 38,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Omar larbi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF262E29),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Responsible · due June 18',
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
              SvgPicture.asset(
                'assets/icons/bill_details_chevron_right.svg',
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onEditReminder,
          child: _card(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE7D8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/bill_details_bell.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Reminder is on',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF262E29),
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        'June 16 · 9:00 AM · Edit reminder',
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
                SvgPicture.asset(
                  'assets/icons/bill_details_chevron_right_small.svg',
                  width: 14,
                  height: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/bill_details_info.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Recording is not paying',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF345A71),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Recording a payment does not pay the provider. Pay externally first, then add your payment record here.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF262E29),
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

  Widget _buildEditBillButton() {
    return GestureDetector(
      onTap: onEditBill,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: DarnaColors.border),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Edit Bill',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F4D46),
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildActionFooter() {
    return Container(
      width: double.infinity,
      height: 104,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E3DA))),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onMarkPaid,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x33D4AF37)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x400F4D46),
                    blurRadius: 14,
                    offset: Offset(0, 4),
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x26D4AF37),
                    Color(0x00D4AF37),
                  ],
                  stops: [0.0, 0.55],
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      gradient: LinearGradient(
                        begin: Alignment(0.09, 0.96),
                        end: Alignment(0.91, 0.04),
                        colors: [
                          Color(0xFF0F4D46),
                          Color(0xFF1A6358),
                          Color(0xFF0F4D46),
                        ],
                        stops: [0.25, 0.475, 0.75],
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Mark as Paid',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF7F3E8),
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 112,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF262E29),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  }) {
    return Container(
      width: double.infinity,
      padding: padding == EdgeInsets.zero ? null : padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DarnaColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05262E29),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
