import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.onTabSelected,
    this.onAllBills,
    this.onAddObligation,
    this.onReviewBill,
    this.onOpenPlanner,
    this.onOpenFamilySpace,
    this.onOpenTodoList,
    this.onOpenSalary,
  });

  final ValueChanged<DarnaNavTab>? onTabSelected;
  final VoidCallback? onAllBills;
  final VoidCallback? onAddObligation;
  final VoidCallback? onReviewBill;
  final VoidCallback? onOpenPlanner;
  final VoidCallback? onOpenFamilySpace;
  final VoidCallback? onOpenTodoList;
  final VoidCallback? onOpenSalary;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DarnaNavTab _tab = DarnaNavTab.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroSection(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _UpcomingBillCard(onReviewBill: widget.onReviewBill),
                          const SizedBox(height: 16),
                          _ServicesSection(onAllBills: widget.onAllBills),
                          const SizedBox(height: 16),
                          _AddObligationButton(
                            onTap: widget.onAddObligation,
                          ),
                          const SizedBox(height: 16),
                          _QuickAccessSection(
                            onFamilySpace: widget.onOpenFamilySpace,
                            onTodoList: widget.onOpenTodoList,
                            onSalary: widget.onOpenSalary,
                          ),
                          const SizedBox(height: 16),
                          _RemindersSection(onOpenPlanner: widget.onOpenPlanner),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 204,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFC7E4DB), Colors.white],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 104,
            top: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Good morning,', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: DarnaColors.textPrimary, height: 1.14, letterSpacing: -0.8)),
                Text('Maya', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: DarnaColors.textPrimary, height: 1.14, letterSpacing: -0.8)),
              ],
            ),
          ),
          Positioned(
            right: 24,
            top: 12,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0E5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/icons/bell.svg', width: 18, height: 18),
            ),
          ),
          Positioned(
            left: 24,
            top: 108,
            child: Container(
              height: 32,
              padding: const EdgeInsets.only(left: 10, right: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(child: Image.asset('assets/images/home/member_avatar.png', width: 22, height: 22, fit: BoxFit.cover)),
                  const SizedBox(width: 8),
                  const Text('Nour  household', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: DarnaColors.textPrimary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UpcomingBillCard extends StatelessWidget {
  const _UpcomingBillCard({this.onReviewBill});

  final VoidCallback? onReviewBill;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [DarnaColors.primary, Color(0xFF2E6F63)],
        ),
        boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 2, offset: Offset(0, 4))],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Opacity(
                opacity: 0.15,
                child: Image.asset('assets/images/home/card_flow_art.png', fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 0,
            child: Container(
              width: 60,
              height: 2,
              decoration: BoxDecoration(
                color: DarnaColors.mutedGold,
                borderRadius: BorderRadius.all(Radius.circular(1)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/clock_3.svg', width: 12, height: 12, colorFilter: const ColorFilter.mode(DarnaColors.mutedGold, BlendMode.srcIn)),
                        const SizedBox(width: 6),
                        const Text('NEXT UP · IN 2 DAYS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: DarnaColors.mutedGold, letterSpacing: 0.8)),
                      ],
                    ),
                    SvgPicture.asset('assets/icons/zap.svg', width: 20, height: 20, colorFilter: const ColorFilter.mode(DarnaColors.ivory, BlendMode.srcIn)),
                  ],
                ),
                const SizedBox(height: 6),
                const Text('Electricity is due June 18', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: DarnaColors.ivory, height: 1.3)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('14800 DZD', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: -1)),
                    Text('Omar is on it', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFFD9EDD9))),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onReviewBill,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.arrow_forward, size: 14, color: DarnaColors.ivory),
                        SizedBox(width: 8),
                        Text('Review bill', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: DarnaColors.ivory)),
                      ],
                    ),
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

class _ServicesSection extends StatelessWidget {
  const _ServicesSection({this.onAllBills});

  final VoidCallback? onAllBills;

  @override
  Widget build(BuildContext context) {
    final services = [
      ('assets/images/home/electricity_3d.png', 'Electricity'),
      ('assets/images/home/water_3d.png', 'Water'),
      ('assets/images/home/gas_3d.png', 'Gas'),
      ('assets/images/home/rent_3d.png', 'Rent'),
      ('assets/images/home/housing_3d.png', 'Housing\ninstallments'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Your services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: DarnaColors.primary)),
            GestureDetector(
              onTap: onAllBills,
              child: const _Pill(label: 'All bills'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: services.map((s) {
            return Expanded(
              child: Column(
                children: [
                  Image.asset(s.$1, width: 64, height: 64, fit: BoxFit.contain),
                  const SizedBox(height: 4),
                  Text(s.$2, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: DarnaColors.textPrimary, height: 1.37)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: DarnaColors.primary, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: DarnaColors.ivory)),
    );
  }
}

class _AddObligationButton extends StatelessWidget {
  const _AddObligationButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(colors: [DarnaColors.primary, Color(0xFF1A6459)]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add, size: 18, color: DarnaColors.ivory),
            SizedBox(width: 8),
            Text('Add an obligation', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: DarnaColors.ivory)),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessSection extends StatelessWidget {
  const _QuickAccessSection({
    this.onFamilySpace,
    this.onTodoList,
    this.onSalary,
  });

  final VoidCallback? onFamilySpace;
  final VoidCallback? onTodoList;
  final VoidCallback? onSalary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick access', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: DarnaColors.primary)),
        const SizedBox(height: 8),
        Row(
          children: [
            _QuickAccess(icon: 'assets/icons/users.svg', label: 'Family Space', active: false, onTap: onFamilySpace),
            _QuickAccess(icon: 'assets/icons/check_white.svg', label: 'To-do List', active: false, onTap: onTodoList),
            _QuickAccess(icon: 'assets/icons/chart.svg', label: 'Salary\nDistribution', active: false, onTap: onSalary),
          ],
        ),
      ],
    );
  }
}

class _QuickAccess extends StatelessWidget {
  const _QuickAccess({required this.icon, required this.label, required this.active, this.onTap});
  final String icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: const Color(0xFFEEF5EC), borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: SvgPicture.asset(icon, width: 18, height: 18),
            ),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: DarnaColors.textPrimary, height: 1.33)),
          ],
        ),
      ),
    );
  }
}

class _RemindersSection extends StatelessWidget {
  const _RemindersSection({this.onOpenPlanner});

  final VoidCallback? onOpenPlanner;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Don't forget", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: DarnaColors.primary)),
            GestureDetector(
              onTap: onOpenPlanner,
              child: const Text('Planner →', style: TextStyle(fontSize: 12, color: Color(0xFF2E6F63))),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onOpenPlanner,
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8EDE5)),
            ),
            child: Row(
              children: [
                Container(width: 3, height: 30, margin: const EdgeInsets.only(left: 0), decoration: BoxDecoration(color: DarnaColors.mutedGold, borderRadius: BorderRadius.circular(2))),
                const SizedBox(width: 16),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: const Color(0xFFEEF5EC), borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.center,
                  child: SvgPicture.asset('assets/icons/bell.svg', width: 18, height: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Pick up pantry essentials', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: DarnaColors.primary)),
                      Text('Today · Lina · Household task', style: TextStyle(fontSize: 12, color: Color(0xFF6B7567))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SvgPicture.asset('assets/icons/chevron_right.svg', width: 16, height: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}