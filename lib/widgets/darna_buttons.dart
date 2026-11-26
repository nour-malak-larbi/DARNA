import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/darna_colors.dart';

/// Primary 50px action button with gradient default, pressed, disabled, and loading states.
class DarnaPrimaryButton extends StatefulWidget {
  const DarnaPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;

  @override
  State<DarnaPrimaryButton> createState() => _DarnaPrimaryButtonState();
}

class _DarnaPrimaryButtonState extends State<DarnaPrimaryButton> {
  bool _isPressed = false;

  bool get _effectiveDisabled =>
      widget.isDisabled || widget.onPressed == null;

  @override
  Widget build(BuildContext context) {
    final radius = _effectiveDisabled ? 10.0 : 14.0;
    final textColor =
        _effectiveDisabled ? DarnaColors.textSecondary : Colors.white;

    return GestureDetector(
      onTapDown: _effectiveDisabled || widget.isLoading
          ? null
          : (_) => setState(() => _isPressed = true),
      onTapUp: _effectiveDisabled || widget.isLoading
          ? null
          : (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: _effectiveDisabled || widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: _effectiveDisabled
              ? DarnaColors.disabledSurface
              : (_isPressed ? DarnaColors.primaryPressed : null),
          gradient: !_effectiveDisabled && !_isPressed
              ? DarnaColors.primaryGradient
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isLoading) ...[
              SvgPicture.asset(
                'assets/icons/loader_circle.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Secondary 50px outlined button with default, pressed, and disabled states.
class DarnaSecondaryButton extends StatefulWidget {
  const DarnaSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isDisabled;

  @override
  State<DarnaSecondaryButton> createState() => _DarnaSecondaryButtonState();
}

class _DarnaSecondaryButtonState extends State<DarnaSecondaryButton> {
  bool _isPressed = false;

  bool get _effectiveDisabled =>
      widget.isDisabled || widget.onPressed == null;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _effectiveDisabled
        ? DarnaColors.disabledSurface
        : (_isPressed ? DarnaColors.secondaryPressed : DarnaColors.surface);
    final textColor = _effectiveDisabled
        ? DarnaColors.textSecondary
        : (_isPressed ? Colors.white : DarnaColors.primary);

    return GestureDetector(
      onTapDown:
          _effectiveDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp:
          _effectiveDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: _effectiveDisabled ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: DarnaColors.border),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
