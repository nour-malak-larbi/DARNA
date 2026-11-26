import 'package:flutter/material.dart';
import '../core/theme/darna_colors.dart';
import 'darna_card.dart';

/// 7px pill progress bar with sage track and deep teal fill.
class DarnaProgressBar extends StatelessWidget {
  const DarnaProgressBar({
    super.key,
    required this.progress,
  });

  /// Value clamped between 0.0 and 1.0.
  final double progress;

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 7,
        width: double.infinity,
        color: DarnaColors.sageTint,
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: clamped,
          child: Container(
            height: 7,
            decoration: BoxDecoration(
              color: DarnaColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}

/// Financial allocation summary card with title, amount, progress bar, and footer.
class DarnaFinancialSummaryCard extends StatelessWidget {
  const DarnaFinancialSummaryCard({
    super.key,
    required this.title,
    required this.amountText,
    required this.progress,
    required this.footerText,
  });

  final String title;
  final String amountText;
  final double progress;
  final String footerText;

  @override
  Widget build(BuildContext context) {
    return DarnaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: DarnaColors.textSecondary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            amountText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: DarnaColors.textSecondary,
                  height: 1.2,
                ),
          ),
          const SizedBox(height: 12),
          DarnaProgressBar(progress: progress),
          const SizedBox(height: 12),
          Text(
            footerText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: DarnaColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
