import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

/// All Bills screen (`05 — Bills & Services / 06 All Bills`).
class AllBillsScreen extends StatefulWidget {
  const AllBillsScreen({
    super.key,
    this.onBack,
    this.onAddBill,
    this.onBillTap,
  });

  final VoidCallback? onBack;
  final VoidCallback? onAddBill;
  final VoidCallback? onBillTap;

  @override
  State<AllBillsScreen> createState() => _AllBillsScreenState();
}

class _AllBillsScreenState extends State<AllBillsScreen> {
  static const List<String> _filters = ['All', 'Upcoming', 'Paid', 'Overdue'];
  int _selectedFilter = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
                child: _buildHeading(context),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchField(),
                      const SizedBox(height: 20),
                      _buildFilterTabs(),
                      const SizedBox(height: 20),
                      _buildSummaryCard(),
                      const SizedBox(height: 20),
                      _buildSection(
                        title: 'Utilities',
                        rows: const [
                          _BillData(
                            artwork: 'assets/images/all_bills/electricity.png',
                            title: 'Electricity',
                            subtitle: 'Jun 18 · Omar',
                            amount: '148 DZD',
                            status: DarnaStatusType.upcoming,
                          ),
                          _BillData(
                            artwork: 'assets/images/all_bills/water.png',
                            title: 'Water',
                            subtitle: 'Jun 20 · Maya',
                            amount: '62 DZD',
                            status: DarnaStatusType.upcoming,
                          ),
                          _BillData(
                            artwork: 'assets/images/all_bills/gas.png',
                            title: 'Gas',
                            subtitle: 'Jun 22 · Omar',
                            amount: '100 DZD',
                            status: DarnaStatusType.upcoming,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildSection(
                        title: 'Home obligations',
                        rows: const [
                          _BillData(
                            artwork: 'assets/images/all_bills/rent.png',
                            title: 'Rent',
                            subtitle: 'Jun 01 · Maya',
                            amount: '1,450 DZD',
                            status: DarnaStatusType.paidRecorded,
                          ),
                          _BillData(
                            artwork: 'assets/images/all_bills/housing.png',
                            title: 'Housing installments',
                            subtitle: 'Jun 28 · Maya',
                            amount: '850 DZD',
                            status: DarnaStatusType.upcoming,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Payment status reflects records added by your household, not provider confirmation.',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFA0A8A2),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildBottomCta(),
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
          height: 40,
          child: GestureDetector(
            onTap: widget.onBack,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                'assets/icons/arrow_left_all_bills.svg',
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
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF626B64),
                  height: 1.5,
                  letterSpacing: 0,
                ),
              ),
              Text(
                'All bills',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF262E29),
                  height: 1.18,
                  letterSpacing: -0.9,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: widget.onAddBill,
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
              'assets/icons/plus.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Find a bill',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF262E29),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: DarnaColors.border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x21093D36),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF262E29),
                    height: 1.5,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'Enter service or bill name',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFA0A8A2),
                      height: 1.5,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/icons/search.svg',
                width: 18,
                height: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    return Row(
      children: List.generate(_filters.length, (index) {
        final selected = index == _selectedFilter;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedFilter = index),
            child: Container(
              height: 34,
              margin: EdgeInsets.only(right: index == _filters.length - 1 ? 0 : 6),
              decoration: BoxDecoration(
                color: selected ? DarnaColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: selected
                    ? null
                    : Border.all(color: DarnaColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                _filters[index],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : const Color(0xFF626B64),
                  height: 1.0,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xF20F4D46), Color(0xF223B3A3)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Expanded(
                child: Text(
                  'June total · 5 bills',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
              Text(
                '2,610 DZD',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.0,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: const Color(0x99C2D4BB),
          ),
          const SizedBox(height: 10),
          _summaryDetailRow(
            dotColor: const Color(0xFFC18C66),
            label: 'Unpaid · 4',
            amount: '1,160 DZD',
          ),
          const SizedBox(height: 8),
          _summaryDetailRow(
            dotColor: DarnaColors.primary,
            label: 'Paid · 1',
            amount: '1,450 DZD',
          ),
        ],
      ),
    );
  }

  Widget _summaryDetailRow({
    required Color dotColor,
    required String label,
    required String amount,
  }) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFFF7F3E8),
            height: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<_BillData> rows,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF262E29),
              height: 1.0,
            ),
          ),
        ),
        ...rows.map((row) {
          final isLast = row == rows.last;
          return _BillRow(
            data: row,
            showDivider: !isLast,
            onTap: widget.onBillTap,
          );
        }),
      ],
    );
  }

  Widget _buildBottomCta() {
    return Container(
      color: const Color(0xFFF7F3E8),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: GestureDetector(
        onTap: widget.onAddBill,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: DarnaColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/plus.svg',
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              const Text(
                'Add Bill',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
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

class _BillData {
  const _BillData({
    required this.artwork,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
  });

  final String artwork;
  final String title;
  final String subtitle;
  final String amount;
  final DarnaStatusType status;
}

class _BillRow extends StatelessWidget {
  const _BillRow({
    required this.data,
    required this.showDivider,
    this.onTap,
  });

  final _BillData data;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: DarnaColors.border))
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                data.artwork,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
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
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF626B64),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  DarnaStatusBadge(type: data.status),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              data.amount,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF262E29),
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
