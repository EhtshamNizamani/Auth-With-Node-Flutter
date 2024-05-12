import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final VoidCallback? onTap;
  final Color buttonColor;
  final bool isLoading;
  final bool isBorder;
  final double fontSize;
  final double? width;
  final String? isIcon;
  final double? height;
  final FontWeight? fontWeight;
  final double? borderRadius;
  const PrimaryButton(
      {super.key,
      this.textColor,
      this.isBorder = false,
      this.borderRadius,
      this.fontWeight,
      this.width,
      this.height,
      this.isIcon,
      this.fontSize = 13,
      this.isLoading = false,
      this.buttonColor = Colors.lightBlueAccent,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isBorder ? theme.colorScheme.background : buttonColor,
            border: isBorder
                ? Border.all(width: 1, color: textColor ?? buttonColor)
                : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 8)),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: theme.colorScheme.background,
                  ),
                ),
              )
            : Text(text),
      ),
    );
  }
}
