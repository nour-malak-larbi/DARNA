import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/darna_colors.dart';

/// Styled 50px Darna text input supporting default, focus, error, and password states.
class DarnaTextField extends StatefulWidget {
  const DarnaTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.focusNode,
    this.errorText,
    this.isPassword = false,
    this.suffixIconPath,
    this.keyboardType,
    this.onChanged,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? errorText;
  final bool isPassword;
  final String? suffixIconPath;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  State<DarnaTextField> createState() => _DarnaTextFieldState();
}

class _DarnaTextFieldState extends State<DarnaTextField> {
  late FocusNode _focusNode;
  bool _ownsFocusNode = false;
  bool _obscureText = false;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    }
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() => _isFocused = _focusNode.hasFocus);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final borderColor = hasError
        ? DarnaColors.errorForeground
        : (_isFocused ? DarnaColors.primary : DarnaColors.border);
    final borderWidth = _isFocused && !hasError ? 2.0 : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: DarnaColors.textPrimary,
              ),
        ),
        const SizedBox(height: 7),
        Container(
          constraints: const BoxConstraints(minHeight: 50),
          decoration: BoxDecoration(
            color: DarnaColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: _obscureText,
                  keyboardType: widget.keyboardType,
                  onChanged: widget.onChanged,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: DarnaColors.textPrimary,
                      ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: DarnaColors.textSecondary,
                        ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                ),
              ),
              if (widget.isPassword) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => _obscureText = !_obscureText),
                  child: _obscureText
                      ? SvgPicture.asset(
                          'assets/icons/eye_off.svg',
                          width: 18,
                          height: 18,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          size: 18,
                          color: DarnaColors.textSecondary,
                        ),
                ),
              ] else if (widget.suffixIconPath != null) ...[
                const SizedBox(width: 8),
                SvgPicture.asset(
                  widget.suffixIconPath!,
                  width: 18,
                  height: 18,
                ),
              ],
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: SvgPicture.asset(
                  'assets/icons/circle_alert_error.svg',
                  width: 16,
                  height: 16,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: DarnaColors.errorForeground,
                      ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Preference row with title, subtitle, and a 42x26 pill toggle switch.
class DarnaPreferenceSwitch extends StatelessWidget {
  const DarnaPreferenceSwitch({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: DarnaColors.textPrimary,
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
        const SizedBox(width: 14),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 42,
            height: 26,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: value ? DarnaColors.navActive : DarnaColors.disabledSurface,
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
