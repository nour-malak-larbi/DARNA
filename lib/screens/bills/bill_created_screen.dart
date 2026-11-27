import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Bill created successfully (`05 — Bills & Services / Bill created successfully`).
class BillCreatedScreen extends StatelessWidget {
  const BillCreatedScreen({
    super.key,
    this.onBack,
    this.onViewBillDetails,
    this.onBackToAllBills,
  });

  final VoidCallback? onBack;
  final VoidCallback? onViewBillDetails;
  final VoidCallback? onBackToAllBills;

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
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _successHero(),
                      const SizedBox(height: 20),
                      _summaryCard(),
                      const SizedBox(height: 16),
                      _savedBanner(),
                    ],
                  ),
                ),
              ),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFC7E4DB),
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
                    height: 36,
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
                    children: const [
                      Text(
                        'BILL SAVED',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: DarnaColors.textSecondary,
                          height: 1.5,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        'One less thing to remember',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.textPrimary,
                          height: 1.18,
                          letterSpacing: -0.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: DarnaColors.border, height: 1),
        ],
      ),
    );
  }

  Widget _successHero() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFDCE7D8),
                borderRadius: BorderRadius.all(Radius.circular(100)),
                border: Border(
                  top: BorderSide(color: Color(0xFFC8D9C3)),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/check_white.svg',
                  width: 26,
                  height: 26,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              child: SvgPicture.asset(
                'assets/images/artwork_gentle_reminder.png',
                width: 72,
                height: 72,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            const Text(
              'Electricity is on the list.',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: DarnaColors.textPrimary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your household can see the bill and who\'s taking care of it.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: DarnaColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _summaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DarnaColors.border),
        boxShadow: DarnaColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(
                color: Color(0xFFDCE7D8),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule, size: 12, color: DarnaColors.primary),
                  SizedBox(width: 4),
                  Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: DarnaColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
            height: 1,
            color: const Color(0xFFF0F2EE),
          ),
          _billRow('Home electricity', '148 DZD', bold: true),
          _billRow('Due', 'June 18, 2026', bold: false),
          _billRow('Responsible', 'Omar larbi', bold: false),
          _billRow('Reminder', 'June 16 · 9:00 AM', bold: false, divider: false),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value, {required bool bold, bool divider = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: divider
            ? const Border(bottom: BorderSide(color: Color(0xFFF0F2EE))
            )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
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
              fontSize: bold ? 16 : 13,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color: bold ? DarnaColors.textPrimary : DarnaColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _savedBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2EA),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color(0xFFC8DDCA)),
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
                  'Saved to June',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF245D40),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '5 bills · 2,610 DZD total. Rent is recorded as paid; 1,160 DZD remains unpaid.',
                  style: TextStyle(
                    fontSize: 13,
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

  Widget _buildBottomActions() {
    return Container(
      width: double.infinity,
      color: DarnaColors.ivory,
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
              'View Bill Details',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: DarnaColors.ivory,
              ),
            ),
          ),
          const SizedBox(height: 10),
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
              'Back to All Bills',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: DarnaColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 10),
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
