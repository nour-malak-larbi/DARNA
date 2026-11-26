import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/darna_colors.dart';
import 'darna_status_badge.dart';

/// Bill list row with 40x40 service icon, title, subtitle, status badge, and amount.
class DarnaBillRow extends StatelessWidget {
  const DarnaBillRow({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.amountText,
    required this.status,
    this.onTap,
    this.showDivider = true,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final String amountText;
  final DarnaStatusType status;
  final VoidCallback? onTap;
  final bool showDivider;

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
              child: SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: DarnaColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 5),
                  DarnaStatusBadge(type: status),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              amountText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: DarnaColors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Family member row with default and selected assignee states.
class DarnaFamilyMemberTile extends StatelessWidget {
  const DarnaFamilyMemberTile({
    super.key,
    required this.name,
    required this.subtitle,
    this.avatarAsset,
    this.isSelected = false,
    this.onTap,
  });

  final String name;
  final String subtitle;
  final String? avatarAsset;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: isSelected ? const EdgeInsets.all(10) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isSelected ? DarnaColors.sageTint : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            _MemberAvatar(avatarAsset: avatarAsset, size: 40, name: name),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: DarnaColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: DarnaColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              isSelected
                  ? 'assets/icons/circle_check_selected.svg'
                  : 'assets/icons/chevron_right.svg',
              width: 18,
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}

/// Shared household task row with 22x22 checkbox, strikethrough when completed, and assignee avatar.
class DarnaTaskRow extends StatelessWidget {
  const DarnaTaskRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.onToggle,
    this.assigneeAvatarAsset,
    this.assigneeName = '',
    this.showDivider = true,
  });

  final String title;
  final String subtitle;
  final bool isCompleted;
  final VoidCallback onToggle;
  final String? assigneeAvatarAsset;
  final String assigneeName;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: DarnaColors.border))
              : null,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 140),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isCompleted ? DarnaColors.primary : DarnaColors.surface,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: isCompleted
                      ? DarnaColors.primary
                      : DarnaColors.textSecondary,
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: isCompleted
                  ? SvgPicture.asset(
                      'assets/icons/check_white.svg',
                      width: 15,
                      height: 15,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isCompleted
                              ? DarnaColors.textSecondary
                              : DarnaColors.textPrimary,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: DarnaColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: DarnaColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _MemberAvatar(
              avatarAsset: assigneeAvatarAsset,
              size: 28,
              name: assigneeName,
            ),
          ],
        ),
      ),
    );
  }
}

/// Reminder row with 36x36 sage bell container, title, subtitle, and chevron.
class DarnaReminderRow extends StatelessWidget {
  const DarnaReminderRow({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: DarnaColors.sageTint,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/bell.svg',
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: DarnaColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: DarnaColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SvgPicture.asset(
            'assets/icons/chevron_right.svg',
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({
    required this.avatarAsset,
    required this.size,
    required this.name,
  });

  final String? avatarAsset;
  final double size;
  final String name;

  @override
  Widget build(BuildContext context) {
    if (avatarAsset != null && avatarAsset!.isNotEmpty) {
      return ClipOval(
        child: Image.asset(
          avatarAsset!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }

    final initial = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?';
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: DarnaColors.sageTint,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: size * 0.42,
          fontWeight: FontWeight.w600,
          color: DarnaColors.primary,
        ),
      ),
    );
  }
}
