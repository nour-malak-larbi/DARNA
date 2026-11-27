import 'package:flutter/material.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

/// Planner Calendar screen (`07 — Planner / 14 Planner Calendar`).
class PlannerCalendarScreen extends StatefulWidget {
  const PlannerCalendarScreen({super.key, this.onBack, this.onAddEvent, this.onTabSelected});

  final VoidCallback? onBack;
  final VoidCallback? onAddEvent;
  final VoidCallback? onTabSelected;

  @override
  State<PlannerCalendarScreen> createState() => _PlannerCalendarScreenState();
}

class _PlannerCalendarScreenState extends State<PlannerCalendarScreen> {
  DarnaNavTab _tab = DarnaNavTab.planner;

  static const _weeks = [
    [1, 2, 3, 4, 5, 6, 7],
    [8, 9, 10, 11, 12, 13, 14],
    [15, 16, 17, 18, 19, 20, 21],
    [22, 23, 24, 25, 26, 27, 28],
    [29, 30, 1, 2, 3, 4, 5],
    [6, 7, 8, 9, 10, 11, 12],
  ];

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
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _calendarCard(),
                      const SizedBox(height: 14),
                      _selectedDayCard(),
                      const SizedBox(height: 14),
                      _comingUp(),
                    ],
                  ),
                ),
              ),
              _buildActionFooter(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DarnaBottomNavBar(
        selectedTab: _tab,
        onTabSelected: (t) {
          setState(() => _tab = t);
          widget.onTabSelected?.call();
        },
      ),
    );
  }

  Widget _buildHeading() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'HOUSEHOLD PLANNER',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.textSecondary,
                    height: 1.0,
                    letterSpacing: 0.6,
                  ),
                ),
                const Text(
                  'Room for everything',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2E23),
                    height: 1.18,
                    letterSpacing: -0.9,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F09151B),
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.add, size: 20, color: DarnaColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _calendarCard() {
    const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E4DA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0F4D46),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F3E8),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F09151B),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.chevron_left, size: 16, color: DarnaColors.textPrimary),
              ),
              const SizedBox(width: 8),
              Text(
                'June 2026',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2E23),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F3E8),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F09151B),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.chevron_right, size: 16, color: DarnaColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final d in weekdays)
                Expanded(
                  child: Text(
                    d,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFA0A89E),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          ..._weeks.map(
            (week) => _calendarRow(
              days: week,
              onDayTap: (_) {},
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              _LegendItem(label: 'Outlined: today, Jun 16', outlined: true),
              SizedBox(width: 16),
              _LegendItem(label: 'Dot: activity', outlined: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calendarRow({required List<int> days, required ValueChanged<int> onDayTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          for (final day in days) _CalendarDayCell(day: day, onTap: onDayTap),
        ],
      ),
    );
  }

  Widget _selectedDayCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E4DA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0F4D46),
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFDCE7D8),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.bolt, size: 20, color: Color(0xFF254C3B)),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BILL · Electricity due',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.textPrimary,
                    height: 1.4,
                  ),
                ),
                Text(
                  '148 DZD · Omar · Unpaid',
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
        ],
      ),
    );
  }

  Widget _comingUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3,
              height: 18,
              decoration: const BoxDecoration(
                color: DarnaColors.navActive,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
            const Text(
              'Coming up',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A2E23),
                height: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8E4DA)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F0F4D46),
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              _agendaRow(
                icon: const Color(0xFFEBF2EB),
                iconWidget: const Icon(Icons.checklist, size: 18, color: Color(0xFF254C3B)),                badge: 'TASK',
                title: 'Prepare building documents',
                subtitle: 'Jun 19 · Maya',
              ),
              Container(
                color: const Color(0xFFE8E4DA),
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 14),
              ),
              _agendaRow(
                icon: const Color(0xFFDCE7D8),
                iconWidget: const Icon(Icons.bolt, size: 18, color: Color(0xFF254C3B)),
                title: 'BILL · Water due',
                subtitle: 'Jun 20 · 62 DZD · Maya',
              ),
              _agendaRow(
                icon: const Color(0xFFDCE7D8),
                iconWidget: const Icon(Icons.gas_meter, size: 18, color: Color(0xFF254C3B)),
                title: 'BILL · Gas due',
                subtitle: 'Jun 22 · 100 DZD · Omar',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _agendaRow({
    required Color icon,
    required Widget iconWidget,
    String? badge,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE8E4DA))),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: icon,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: iconWidget,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (badge != null)
                  Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E6F63),
                      letterSpacing: 0.5,
                    ),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2E23),
                    height: 1.4,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7D8880),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 16, color: Color(0xFF7D8880)),
        ],
      ),
    );
  }

  Widget _buildActionFooter() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 52,
            decoration: const BoxDecoration(
              color: DarnaColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(14),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2E6F63), Color(0xFF0F4D46)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x330F4D46),
                  blurRadius: 12,
                  offset: Offset(0, 7),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Add Event',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: 112,
            height: 4,
            decoration: BoxDecoration(
              color: DarnaColors.textPrimary,
              borderRadius: BorderRadius.all(Radius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({required this.day, required this.onTap});

  final int day;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isToday = day == 16;
    final isSelected = day == 18;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(day),
        child: Container(
          height: 34,
          decoration: BoxDecoration(
            color: isSelected ? DarnaColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: isToday && !isSelected
                ? Border.all(color: DarnaColors.primary, width: 1.5)
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            '$day',
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected || isToday ? FontWeight.w700 : FontWeight.w400,
              color: isSelected ? Colors.white : DarnaColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.label, required this.outlined});

  final String label;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: DarnaColors.primary, width: 1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: DarnaColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
