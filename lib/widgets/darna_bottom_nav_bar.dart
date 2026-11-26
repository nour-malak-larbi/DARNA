import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/darna_colors.dart';

enum DarnaNavTab {
  home,
  dashboard,
  family,
  planner,
  profile,
}

/// Five-destination bottom navigation bar matching the Darna Figma UI kit.
class DarnaBottomNavBar extends StatelessWidget {
  const DarnaBottomNavBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    this.showHomeIndicator = true,
  });

  final DarnaNavTab selectedTab;
  final ValueChanged<DarnaNavTab> onTabSelected;
  final bool showHomeIndicator;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(
        color: DarnaColors.surface,
        border: Border(top: BorderSide(color: DarnaColors.border)),
      ),
      padding: EdgeInsets.only(
        top: 10,
        left: 12,
        right: 12,
        bottom: bottomInset > 0 ? bottomInset : 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: DarnaNavTab.values.map((tab) {
              final isSelected = tab == selectedTab;
              final meta = _metaFor(tab);

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTabSelected(tab),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 140),
                        width: 46,
                        height: 27,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? DarnaColors.sageTint
                              : DarnaColors.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          isSelected ? meta.activeIcon : meta.inactiveIcon,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meta.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? DarnaColors.navActive
                                  : DarnaColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (showHomeIndicator) ...[
            const SizedBox(height: 9),
            Container(
              width: 112,
              height: 4,
              decoration: BoxDecoration(
                color: DarnaColors.textPrimary,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ],
      ),
    );
  }

  _NavTabMeta _metaFor(DarnaNavTab tab) {
    switch (tab) {
      case DarnaNavTab.home:
        return const _NavTabMeta(
          label: 'Home',
          activeIcon: 'assets/icons/house_active.svg',
          inactiveIcon: 'assets/icons/house.svg',
        );
      case DarnaNavTab.dashboard:
        return const _NavTabMeta(
          label: 'Dashboard',
          activeIcon: 'assets/icons/chart_active.svg',
          inactiveIcon: 'assets/icons/chart.svg',
        );
      case DarnaNavTab.family:
        return const _NavTabMeta(
          label: 'Family',
          activeIcon: 'assets/icons/users_active.svg',
          inactiveIcon: 'assets/icons/users.svg',
        );
      case DarnaNavTab.planner:
        return const _NavTabMeta(
          label: 'Planner',
          activeIcon: 'assets/icons/calendar_active.svg',
          inactiveIcon: 'assets/icons/calendar.svg',
        );
      case DarnaNavTab.profile:
        return const _NavTabMeta(
          label: 'Profile',
          activeIcon: 'assets/icons/user_active.svg',
          inactiveIcon: 'assets/icons/user.svg',
        );
    }
  }
}

class _NavTabMeta {
  const _NavTabMeta({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  final String label;
  final String activeIcon;
  final String inactiveIcon;
}
