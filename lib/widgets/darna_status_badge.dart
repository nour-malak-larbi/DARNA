import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/darna_colors.dart';

enum DarnaStatusType {
  upcoming,
  paidRecorded,
  overdue,
  review,
  manual,
}

/// Compact pill status badge matching the five Figma status variants.
class DarnaStatusBadge extends StatelessWidget {
  const DarnaStatusBadge({
    super.key,
    required this.type,
    this.labelOverride,
  });

  final DarnaStatusType type;
  final String? labelOverride;

  @override
  Widget build(BuildContext context) {
    final config = _configFor(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            config.iconPath,
            width: 12,
            height: 12,
          ),
          const SizedBox(width: 4),
          Text(
            labelOverride ?? config.defaultLabel,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: config.foregroundColor,
                  height: 1.1,
                ),
          ),
        ],
      ),
    );
  }

  _StatusStyleConfig _configFor(DarnaStatusType type) {
    switch (type) {
      case DarnaStatusType.upcoming:
        return const _StatusStyleConfig(
          defaultLabel: 'Upcoming',
          iconPath: 'assets/icons/clock_3.svg',
          backgroundColor: DarnaColors.sageTint,
          foregroundColor: DarnaColors.primary,
        );
      case DarnaStatusType.paidRecorded:
        return const _StatusStyleConfig(
          defaultLabel: 'Paid · recorded',
          iconPath: 'assets/icons/check_green.svg',
          backgroundColor: DarnaColors.successBackground,
          foregroundColor: DarnaColors.successForeground,
        );
      case DarnaStatusType.overdue:
        return const _StatusStyleConfig(
          defaultLabel: 'Overdue',
          iconPath: 'assets/icons/circle_alert_error.svg',
          backgroundColor: DarnaColors.errorBackground,
          foregroundColor: DarnaColors.errorForeground,
        );
      case DarnaStatusType.review:
        return const _StatusStyleConfig(
          defaultLabel: 'Review',
          iconPath: 'assets/icons/circle_alert_review.svg',
          backgroundColor: DarnaColors.warningBackground,
          foregroundColor: DarnaColors.warningForeground,
        );
      case DarnaStatusType.manual:
        return const _StatusStyleConfig(
          defaultLabel: 'Manual',
          iconPath: 'assets/icons/info.svg',
          backgroundColor: DarnaColors.infoBackground,
          foregroundColor: DarnaColors.infoForeground,
        );
    }
  }
}

class _StatusStyleConfig {
  const _StatusStyleConfig({
    required this.defaultLabel,
    required this.iconPath,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String defaultLabel;
  final String iconPath;
  final Color backgroundColor;
  final Color foregroundColor;
}
