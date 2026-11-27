import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Bill Details · Payment recorded (`05 — Bills & Services / Bill Details · Payment recorded`).
class BillDetailsPaymentScreen extends StatelessWidget {
  const BillDetailsPaymentScreen({
    super.key,
    this.onBack,
    this.onEditBill,
    this.onEditPayment,
    this.onReviewBillAlert,
    this.onAssign,
    this.onViewHistory,
  });

  final VoidCallback? onBack;
  final VoidCallback? onEditBill;
  final VoidCallback? onEditPayment;
  final VoidCallback? onReviewBillAlert;
  final VoidCallback? onAssign;
  final VoidCallback? onViewHistory;

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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSuccessAlert(),
                      const SizedBox(height: 20),
                      _billHero(),
                      const SizedBox(height: 20),
                      _historySection(onViewHistory: onViewHistory),
                      const SizedBox(height: 20),
                      _nextOccurrence(),
                      const SizedBox(height: 20),
                      _anomalyEntry(onReviewBillAlert: onReviewBillAlert),
                      const SizedBox(height: 20),
                      _responsibilitySection(onAssign: onAssign),
                      const SizedBox(height: 20),
                      _infoAlert(),
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
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
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
              children: [
                const Text(
                  'Home Electricity · June 2026',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  'Electricity',
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
      ),
    );
  }

  Widget _buildSuccessAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color(0xFFEAF2EA),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 20, color: Color(0xFF245D40)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment recorded',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF245D40),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Recorded by Maya · June 16, 2026. June now has 2 paid bills (1,598 DZD) and 3 unpaid (1,012 DZD).',
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
    );
  }

  Widget _billHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F4D46), Color(0xFF2E6F63)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x330F4D46),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: const BoxDecoration(
                  color: Color(0x0FFFFFFF),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 12, color: Color(0xFFD4AF37)),
                    SizedBox(width: 4),
                    Text(
                      'Paid · recorded Jun 16',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFEAF2EA),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/bill_details_motion_artwork.png',
                    width: 36,
                    height: 36,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'External payment recorded',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xBFF7F3E8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '148 DZD',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFF7F3E8),
                  height: 1.1,
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 16),
            color: const Color(0x38D4AF37),
          ),
          _billField('Due date', 'June 18, 2026'),
          _billField('Recurrence', 'Monthly · day 18'),
          _billField('Provider', 'City Electric'),
          _billField('Reference', 'CE-4821'),
        ],
      ),
    );
  }

  Widget _billField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xB3F7F3E8),
                  height: 1.5,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFFF7F3E8),
                height: 1.0,
              ),
            ),
          ],
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: const Color(0x0FFFFFFF),
        ),
      ],
    );
  }

  Widget _historySection({VoidCallback? onViewHistory}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Recent bill history',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DarnaColors.textPrimary,
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
                  color: DarnaColors.primary,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: DarnaColors.border),
            boxShadow: DarnaColors.cardShadow,
          ),
          child: Column(
            children: [
              _historyRow('May 18 · Paid · recorded', '112 DZD', divider: true),
              _historyRow('Apr 18 · Paid · recorded', '108 DZD', divider: true),
              _historyRow('Mar 18 · Paid · recorded', '110 DZD', divider: true),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                color: const Color(0xFFF7F3E8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '3-month average',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: DarnaColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const Text(
                      '110 DZD',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: DarnaColors.primary,
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

  Widget _historyRow(String label, String amount, {required bool divider}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: divider
            ? const Border(bottom: BorderSide(color: DarnaColors.border))
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
                color: DarnaColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: DarnaColors.textPrimary,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nextOccurrence() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE7D8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Next occurrence · July 18',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F4D46),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Expected 110 DZD. Actual amount hasn\'t been entered yet. Your July reminder is July 16 at 9:00 AM.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _anomalyEntry({VoidCallback? onReviewBillAlert}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DarnaColors.border),
        boxShadow: DarnaColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xFFF5EADC),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up, size: 12, color: Color(0xFF805421)),
                SizedBox(width: 4),
                Text(
                  'Worth a look',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF805421),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '38 DZD higher than your usual bill',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: DarnaColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '+34.5% compared with your 110 DZD average. A change in usage or rates may explain it.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: DarnaColors.border),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Review bill alert',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: DarnaColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _responsibilitySection({VoidCallback? onAssign}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                "Who's taking care of it?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DarnaColors.textPrimary,
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
                  color: DarnaColors.primary,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: DarnaColors.border),
            boxShadow: DarnaColors.cardShadow,
          ),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFDCE7D8),
                child: Icon(Icons.person, size: 20, color: Color(0xFF254C3B)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Omar larbi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DarnaColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Responsible · external payment recorded',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: DarnaColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 16, color: DarnaColors.textSecondary),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: DarnaColors.border),
            boxShadow: DarnaColors.cardShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCE7D8),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.notifications_outlined, size: 18, color: Color(0xFF254C3B)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'June reminder stopped',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DarnaColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Next reminder · July 16 · 9:00 AM',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: DarnaColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 14, color: DarnaColors.textSecondary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color(0xFFEAF0F4),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 20, color: Color(0xFF345A71)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recording is not paying',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF345A71),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Recording a payment does not pay the provider. Pay externally first, then add your payment record here.',
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
    );
  }

  Widget _buildActionFooter() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: const BoxDecoration(
              color: DarnaColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Edit payment record',
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
