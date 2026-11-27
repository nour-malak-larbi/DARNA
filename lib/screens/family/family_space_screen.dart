import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:darna_app/core/theme/darna_colors.dart';
import 'package:darna_app/widgets/widgets.dart';

/// Family Space overview screen (`06 — Family Space / 10 Family Space Overview`).
class FamilySpaceScreen extends StatefulWidget {
  const FamilySpaceScreen({
    super.key,
    this.onBack,
    this.onInvite,
    this.onAssignResponsibility,
    this.onAllBills,
    this.onTodoList,
    this.onTabSelected,
  });

  final VoidCallback? onBack;
  final VoidCallback? onInvite;
  final VoidCallback? onAssignResponsibility;
  final VoidCallback? onAllBills;
  final VoidCallback? onTodoList;
  final ValueChanged<DarnaNavTab>? onTabSelected;

  @override
  State<FamilySpaceScreen> createState() => _FamilySpaceScreenState();
}

class _FamilySpaceScreenState extends State<FamilySpaceScreen> {
  DarnaNavTab _tab = DarnaNavTab.family;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarnaColors.ivory,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _HouseholdHeader(
              onBack: widget.onBack,
              onInvite: widget.onInvite,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFC7E4DB), Colors.white],
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _WeeklyOverviewCard(
                        onAssign: widget.onAssignResponsibility,
                      ),
                      const SizedBox(height: 16),
                      _SharedBillsSection(onAllBills: widget.onAllBills),
                      const SizedBox(height: 16),
                      _SharedTasksSection(onTodoList: widget.onTodoList),
                      const SizedBox(height: 16),
                    ],
                  ),
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

class _HouseholdHeader extends StatelessWidget {
  const _HouseholdHeader({this.onBack, this.onInvite});

  final VoidCallback? onBack;
  final VoidCallback? onInvite;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: DarnaColors.primary,
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0x002E6F63), Color(0x400F4D46)],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'FAMILY SPACE',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0x99D4AF37),
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Larbi household',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: DarnaColors.ivory,
                            height: 1.15,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: onInvite,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.09),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.13),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1F09332B),
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/icons/user_plus.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            DarnaColors.ivory,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'A shared home. A little teamwork.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xCCF7F3E8),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _AvatarCircle(
                            asset: 'assets/images/avatar_maya.png',
                            borderColor: DarnaColors.primary,
                          ),
                          Transform.translate(
                            offset: const Offset(-10, 0),
                            child: _AvatarCircle(
                              asset: 'assets/images/avatar_omar.png',
                              borderColor: DarnaColors.primary,
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(-20, 0),
                            child: _AvatarCircle(
                              asset: 'assets/images/avatar_lina.png',
                              borderColor: DarnaColors.primary,
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(-20, 0),
                            child: GestureDetector(
                              onTap: onInvite,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: const Text(
                                  '+ Invite',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: DarnaColors.ivory,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: const [
                          Text(
                            'Maya Larbi · owner',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xCCF7F3E8),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Omar Larbi',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0x99F7F3E8),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Lina Larbi',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0x99F7F3E8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 3,
            child: Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    DarnaColors.mutedGold,
                    DarnaColors.mutedGold,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.4, 0.7, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({required this.asset, required this.borderColor});

  final String asset;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: ClipOval(
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }
}

class _WeeklyOverviewCard extends StatelessWidget {
  const _WeeklyOverviewCard({this.onAssign});

  final VoidCallback? onAssign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DarnaColors.sageTint,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1C09332B),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'This week, together',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: DarnaColors.primary,
                  height: 1.4,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: DarnaColors.primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Jun 16–22',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  value: '4',
                  label: 'Bills to record',
                  footer: '1,160 DZD',
                  footerColor: DarnaColors.textPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  value: '3',
                  label: 'Open tasks',
                  footer: 'this week',
                  footerColor: DarnaColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Water is due June 20. Could someone help Maya with it this week?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: DarnaColors.textPrimary,
              height: 18 / 13,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onAssign,
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: DarnaColors.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3309332B),
                    blurRadius: 12,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/plus.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      DarnaColors.ivory,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Assign responsibility',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: DarnaColors.ivory,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.footer,
    required this.footerColor,
  });

  final String value;
  final String label;
  final String footer;
  final Color footerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: DarnaColors.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1209332B),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: DarnaColors.primary,
              height: 1.0,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2E6F63),
              height: 16 / 12,
            ),
          ),
          Text(
            footer,
            style: TextStyle(
              fontSize: 12,
              fontWeight: footer == '1,160 DZD'
                  ? FontWeight.w600
                  : FontWeight.w400,
              color: footerColor,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _SharedBillsSection extends StatelessWidget {
  const _SharedBillsSection({this.onAllBills});

  final VoidCallback? onAllBills;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Who's taking care of what?",
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: DarnaColors.textPrimary,
                  height: 1.0,
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
                  color: DarnaColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
            color: DarnaColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: DarnaColors.border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1C09332B),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              _BillRow(
                iconAsset: 'assets/icons/zap.svg',
                title: 'Electricity',
                subtitle: 'Jun 18 · Omar',
                amount: '148 DZD',
                status: 'Upcoming',
              ),
              _BillRow(
                iconAsset: 'assets/icons/zap.svg',
                title: 'Water',
                subtitle: 'Jun 20 · Maya',
                amount: '62 DZD',
                status: 'Upcoming',
              ),
              _BillRow(
                iconAsset: 'assets/icons/flame.svg',
                title: 'Gas',
                subtitle: 'Jun 22 · Omar',
                amount: '100 DZD',
                status: 'Upcoming',
                showDivider: false,
              ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rent · 1,450 DZD · Maya · paid record added Jun 01',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BillRow extends StatelessWidget {
  const _BillRow({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    this.showDivider = true,
  });

  final String iconAsset;
  final String title;
  final String subtitle;
  final String amount;
  final String status;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: DarnaColors.border))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: DarnaColors.sageTint,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(iconAsset, width: 20, height: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: DarnaColors.textPrimary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: DarnaColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: DarnaColors.sageTint,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/clock_3.svg',
                        width: 12,
                        height: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: DarnaColors.textPrimary,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _SharedTasksSection extends StatelessWidget {
  const _SharedTasksSection({this.onTodoList});

  final VoidCallback? onTodoList;

  @override
  Widget build(BuildContext context) {
    final tasks = [
      ('Pick up pantry essentials', 'Today · Jun 16 · Lina', 'assets/images/avatar_lina.png'),
      ('Check meter reading', 'Tomorrow · Jun 17 · Omar', 'assets/images/avatar_omar.png'),
      ('Prepare building documents', 'Jun 19 · Maya', 'assets/images/avatar_maya.png'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Little things, shared',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: DarnaColors.textPrimary,
                  height: 1.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: onTodoList,
              child: const Text(
                'To-do List',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: DarnaColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: tasks.map((t) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: DarnaColors.border)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: DarnaColors.surface,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: DarnaColors.textSecondary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.$1,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: DarnaColors.textPrimary,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          t.$2,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: DarnaColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipOval(
                    child: Image.asset(t.$3, width: 28, height: 28, fit: BoxFit.cover),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}