import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/darna_colors.dart';
import 'darna_buttons.dart';
import 'darna_card.dart';

enum DarnaAlertType {
  success,
  warning,
  info,
}

/// Inline contextual alert banner (Success, Warning, Info).
class DarnaAlertBanner extends StatelessWidget {
  const DarnaAlertBanner({
    super.key,
    required this.type,
    required this.title,
    required this.description,
  });

  final DarnaAlertType type;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(type);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            style.iconPath,
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: style.titleColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: DarnaColors.textPrimary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _AlertStyle _styleFor(DarnaAlertType type) {
    switch (type) {
      case DarnaAlertType.success:
        return const _AlertStyle(
          backgroundColor: DarnaColors.successBackground,
          titleColor: DarnaColors.successForeground,
          iconPath: 'assets/icons/circle_check_success.svg',
        );
      case DarnaAlertType.warning:
        return const _AlertStyle(
          backgroundColor: DarnaColors.warningBackground,
          titleColor: DarnaColors.warningForeground,
          iconPath: 'assets/icons/circle_alert_warning.svg',
        );
      case DarnaAlertType.info:
        return const _AlertStyle(
          backgroundColor: DarnaColors.infoBackground,
          titleColor: DarnaColors.infoForeground,
          iconPath: 'assets/icons/info.svg',
        );
    }
  }
}

class _AlertStyle {
  const _AlertStyle({
    required this.backgroundColor,
    required this.titleColor,
    required this.iconPath,
  });

  final Color backgroundColor;
  final Color titleColor;
  final String iconPath;
}

/// Confirmation dialog card with title, body, primary and secondary actions.
class DarnaConfirmationDialog extends StatelessWidget {
  const DarnaConfirmationDialog({
    super.key,
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    this.isLoading = false,
  });

  final String title;
  final String description;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DarnaCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: DarnaColors.textPrimary,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: DarnaColors.textSecondary,
                ),
          ),
          const SizedBox(height: 12),
          DarnaPrimaryButton(
            label: primaryLabel,
            onPressed: onPrimaryPressed,
            isLoading: isLoading,
          ),
          const SizedBox(height: 12),
          DarnaSecondaryButton(
            label: secondaryLabel,
            onPressed: onSecondaryPressed,
          ),
        ],
      ),
    );
  }
}
