
import 'package:flutter/material.dart';
import 'package:patroleum_dashboard/core/app_colors.dart';

enum ButtonType { outlined, toggle, iconArrow, flat, text, rounded, icon}

@immutable
class ButtonBuilder extends StatelessWidget {
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final String label;
  final bool? isActive;
  Color? backgroundColor;
  final double? fontSize;
  // final Color _baseColor = Colors.primaryColor;
  final AlignmentGeometry? alignment;
  final FontWeight? fontWeight;
  final double borderRadius;
  final Widget? icon;

  ButtonBuilder({
    super.key,
    this.onPressed,
    required this.buttonType,
    this.foregroundColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    required this.label,
    this.isActive,
    this.backgroundColor = AppColors.complementaryColor,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.alignment,
    this.borderRadius = 10.0,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    createStyle();

    OutlinedBorder? shape = buttonType == ButtonType.rounded ? const StadiumBorder() : RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return buttonType == ButtonType.outlined || buttonType == ButtonType.toggle
        ? OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          textStyle: TextStyle(fontSize:14, fontWeight: fontWeight, color: foregroundColor),
          foregroundColor: foregroundColor,
          side: BorderSide(
              width: 2,
              color: buttonType == ButtonType.outlined ? AppColors.yellowColor  : Colors.purple),
          padding: padding,
          shape: shape),
      child: _buildLabel(context),
    ) : buttonType == ButtonType.icon ? TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize:14, fontWeight: fontWeight, ),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: padding,
            shape: shape,
            alignment: alignment
        ),
        icon: icon!,
        label: _buildLabel(context))
        : TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          textStyle: TextStyle(fontSize: 14, fontWeight: fontWeight, ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          shape: shape,
          alignment: alignment,
        ),
        child: buttonType == ButtonType.iconArrow
            ? _buildLabelWithArrow(context)
            : _buildLabel(context));
  }

  Widget _buildLabelWithArrow(BuildContext context) {
    return Row(
      children: [
        _buildLabel(context),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 17.0,
        )
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: fontSize ?? 12, fontWeight: fontWeight),
    );
  }

  void createStyle() {
    switch (buttonType) {
      case ButtonType.flat:
        backgroundColor = onPressed != null ? backgroundColor : const Color.fromRGBO(211, 216, 226, 1);
        break;
      case ButtonType.text:
        foregroundColor = Colors.purple;
        break;
      case ButtonType.iconArrow:
        foregroundColor = Colors.purple;
        break;
      case ButtonType.outlined:
      //foregroundColor = _baseColor;
        break;
      case ButtonType.toggle:
        foregroundColor = isActive! ? Colors.white : Colors.purple;
        backgroundColor = isActive! ? Colors.purple : Colors.white;
        break;
      case ButtonType.rounded:
        backgroundColor = backgroundColor;
        break;
      case ButtonType.icon:
        backgroundColor = onPressed != null ? backgroundColor : const Color.fromRGBO(211, 216, 226, 1);
        break;
    }
  }
}