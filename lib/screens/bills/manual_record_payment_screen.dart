import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Manual Record Payment confirmation (`05 — Bills & Services / Manual Record Payment confirmation`).
class ManualRecordPaymentScreen extends StatelessWidget {
  const ManualRecordPaymentScreen({
    super.key,
    this.onBack,
    this.onConfirmPayment,
  });

  final VoidCallback? onBack;
  final VoidCallback? onConfirmPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.background,
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
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _alreadyPaidAlert(),
                      const SizedBox(height: 16),
                      _amountCard(),
                      const SizedBox(height: 16),
                      _paymentDateField(),
                      const SizedBox(height: 16),
                      _recordedByField(),
                      const SizedBox(height: 16),
                      _externalNoteField(),
                      const SizedBox(height: 16),
                      _confirmationPreview(),
                      const SizedBox(height: 16),
                      const Text(
                        'Confirmation returns to Bill Details with this paid record. Edit or remove a mistaken record from bill history.',
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
                  'ELECTRICITY · JUNE 2026',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  'Record a payment',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.primary,
                    height: 1.15,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12),
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFDCE7D8),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/home/electricity_3d.png',
                width: 44,
                height: 44,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _alreadyPaidAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0F5),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color(0xFFC5D8E6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 20, color: Color(0xFF2E6F63)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Already paid outside Darna?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E6F63),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'This only updates your household\'s tracking record. Darna will not send money or pay City Electric.',
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

  Widget _amountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: DarnaColors.border),
        boxShadow: DarnaColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 3,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD4AF37), Color(0xFFC4962A)],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount paid externally',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: DarnaColors.textSecondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '148 DZD',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: DarnaColors.primary,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: DarnaColors.border, height: 1),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Expanded(
                child: Text(
                  'Provider reference',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
              Text(
                'CE-4821',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: DarnaColors.textPrimary,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            border: Border.all(color: DarnaColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: DarnaColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
              if (label == 'Payment date')
                const Icon(Icons.calendar_today, size: 18, color: DarnaColors.textSecondary)
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE7D8),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/member_avatar.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentDateField() {
    return _paymentField(
      label: 'Payment date',
      controller: TextEditingController(text: 'June 16, 2026'),
      keyboardType: TextInputType.datetime,
    );
  }

  Widget _recordedByField() {
    return _paymentField(
      label: 'Recorded by',
      controller: TextEditingController(text: 'Maya larbi'),
    );
  }

  Widget _externalNoteField() {
    return _paymentField(
      label: 'Note / external receipt · optional',
      controller: TextEditingController(text: 'Paid directly to City Electric.'),
    );
  }

  Widget _confirmationPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: Color(0xFFDCE7D8),
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'After you confirm',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: DarnaColors.primary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xFFEAF2EA),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check, size: 12, color: Color(0xFF245D40)),
                SizedBox(width: 4),
                Text(
                  'Electricity · Paid · recorded',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF245D40),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Expanded(
                    child: Text(
                      'June paid · 2 of 5',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: DarnaColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Text(
                    '1,598 DZD',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: DarnaColors.textPrimary,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Expanded(
                    child: Text(
                      'June unpaid · 3 of 5',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: DarnaColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Text(
                    '1,012 DZD',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: DarnaColors.textPrimary,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFF0F4D46), height: 1, indent: 0, endIndent: 0),
          const SizedBox(height: 12),
          const Text(
            "June's electricity reminder will stop. July 18 remains the next occurrence; its amount is not entered.",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF3A5C4A),
              height: 1.5,
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
              'Confirm payment record',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: DarnaColors.ivory,
              ),
            ),
          ),
          const SizedBox(height: 12),
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
