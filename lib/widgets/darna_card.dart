import 'package:flutter/material.dart';
import '../core/theme/darna_colors.dart';

/// Standard Darna white surface card with 1px border, 14px radius, and subtle shadow.
class DarnaCard extends StatelessWidget {
  const DarnaCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius = 14,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DarnaColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: DarnaColors.border),
        boxShadow: DarnaColors.cardShadow,
      ),
      padding: padding,
      child: child,
    );
  }
}
