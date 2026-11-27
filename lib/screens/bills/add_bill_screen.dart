import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';

/// Add Bill screen (`05 — Bills & Services / 08 Add Bill · Variable utility`).
///
/// Used for variable utilities (with expected / actual amounts) and reusable by
/// the fixed-bill flows through [billKind].
class AddBillScreen extends StatefulWidget {
  const AddBillScreen({
    super.key,
    this.onBack,
    this.onSaveBill,
    this.serviceName = 'Electricity',
    this.expectedAmount,
    this.actualAmount,
    this.amountUnit = 'DZD',
    this.dueDateLabel = 'June 18, 2026',
    this.recurrenceLabel = 'Monthly',
    this.reminderLabel = '2 days before · 9:00 AM',
    this.responsibleMember = 'Omar larbi',
    this.notes,
    this.billKind = AddBillKind.variable,
  });

  final VoidCallback? onBack;
  final VoidCallback? onSaveBill;
  final String serviceName;
  final String? expectedAmount;
  final String? actualAmount;
  final String amountUnit;
  final String dueDateLabel;
  final String recurrenceLabel;
  final String reminderLabel;
  final String responsibleMember;
  final String? notes;
  final AddBillKind billKind;

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

enum AddBillKind { variable, fixed }

class _AddBillScreenState extends State<AddBillScreen> {
  final _billNameController = TextEditingController(text: 'Home electricity');
  final _providerController = TextEditingController(text: 'City Electric');
  final _accountController = TextEditingController(text: 'CE-4821');
  final _expectedController = TextEditingController(text: '110.00');
  final _actualController = TextEditingController(text: '148.00');
  final _responsibleController = TextEditingController(text: 'Omar larbi');
  final _notesController = TextEditingController(
    text: 'Review the increase before recording payment.',
  );

  @override
  void dispose() {
    _billNameController.dispose();
    _providerController.dispose();
    _accountController.dispose();
    _expectedController.dispose();
    _actualController.dispose();
    _responsibleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

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
              _buildServiceIdentity(),
              _buildAnomalyCallout(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBillForm(),
                      const SizedBox(height: 18),
                      _buildBeforeSaveAlert(),
                      const SizedBox(height: 20),
                      const Text(
                        'Before-save example. Saving leads to the June household baseline: 5 bills totaling 2,610 DZD. Next due: July 18 electricity.',
                        style: TextStyle(
                          fontSize: 11,
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
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onBack,
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
                  'CONFIGURE SERVICE · 2 OF 2',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                    letterSpacing: 0.8,
                  ),
                ),
                const Text(
                  'Add electricity bill',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.primary,
                    height: 1.18,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceIdentity() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: const BoxDecoration(
        color: DarnaColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color(0x401F261F),
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFFEAF2EA),
            ),
            child: Image.asset(
              'assets/images/home/electricity_3d.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon_electricity.svg',
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.serviceName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: DarnaColors.ivory,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A6B5C),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.schedule, size: 12, color: DarnaColors.mutedGold),
                      SizedBox(width: 4),
                      Text(
                        'Variable amount · unpaid',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.mutedGold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Due ${widget.dueDateLabel} · Omar is responsible',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFA8C4BB),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.actualAmount ?? widget.actualAmount ?? ''} ${widget.amountUnit}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: DarnaColors.ivory,
                  height: 1.0,
                ),
              ),
              const Text(
                'DZD · this bill',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFA8C4BB),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnomalyCallout() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: DarnaColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        border: const Border(
          top: BorderSide(color: DarnaColors.mutedGold),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.bug_report, size: 16, color: Color(0xFF8B5E2A)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '+38 DZD vs expected (+34.5% anomaly) · Historical avg: 110 DZD / 108 DZD / 112 DZD',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8B5E2A),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DarnaColors.border),
        boxShadow: DarnaColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formField('Bill name', _billNameController, keyboardType: TextInputType.text),
          const SizedBox(height: 14),
          _formField('Provider · optional', _providerController, keyboardType: TextInputType.text),
          const SizedBox(height: 14),
          _formField('Account / reference · optional', _accountController, keyboardType: TextInputType.text),
          if (widget.billKind == AddBillKind.variable) ...[
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _formField(
                    'Expected · ${widget.amountUnit}',
                    _expectedController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _formField(
                    'This bill · ${widget.amountUnit}',
                    _actualController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],
          const SizedBox(height: 14),
          _formField('Recurrence', TextEditingController(text: widget.recurrenceLabel), keyboardType: TextInputType.text),
          const SizedBox(height: 14),
          _formField('Due date', TextEditingController(text: widget.dueDateLabel), keyboardType: TextInputType.datetime),
          const SizedBox(height: 14),
          _formField('Reminder', TextEditingController(text: widget.reminderLabel), keyboardType: TextInputType.text),
          const SizedBox(height: 14),
          _formField('Responsible member', _responsibleController, keyboardType: TextInputType.text),
          const SizedBox(height: 14),
          _formField(
            'Notes · optional',
            _notesController,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 14),
          Text(
            'Utilities can change each month. Expected is a planning estimate; the actual amount is used for this bill. Enter the next bill\'s amount when it arrives.',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _formField(
    String label,
    TextEditingController controller, {
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
          decoration: BoxDecoration(
            border: Border.all(color: DarnaColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textPrimary,
              height: 1.5,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBeforeSaveAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: DarnaColors.infoBackground,
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
                  'Your record, not a provider payment',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF345A71),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Save this bill to your household. You can record an external payment later. No money moves through Darna.',
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

  Widget _buildActionFooter() {
    return Container(
      width: double.infinity,
      height: 104,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      decoration: const BoxDecoration(
        color: DarnaColors.ivory,
        border: Border(top: BorderSide(color: DarnaColors.border)),
      ),
      child: Column(
        children: [
          Container(
            height: 52,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: DarnaColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x400F4D46),
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'Save Bill',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: DarnaColors.ivory,
                height: 1.0,
              ),
            ),
          ),
          SizedBox(height: 12),
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
