import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Buttons extends StatelessWidget {
  final double width;
  final VoidCallback? onPressed;
  final IconData? icon; // ✅ Use Icon instead of SVG
  final String ddName;
  final bool isEnabled;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const Buttons({
    Key? key,
    required this.ddName,
    required this.width,
    this.icon,
    this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    final Color btnColor = isEnabled
        ? (backgroundColor ?? Colors.blue)
        : Colors.grey.shade400;

    final Color txtColor = textColor ?? Colors.white;

    return ElevatedButton(
      onPressed: (isEnabled && !isLoading) ? onPressed : null,

      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, 50),
        backgroundColor: btnColor,
        disabledBackgroundColor: Colors.grey.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 2,
      ),

      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: txtColor),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: txtColor),
                  const SizedBox(width: 8),
                ],
                AutoSizeText(
                  ddName,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'FontMain',

                    fontWeight: FontWeight.w600,
                    fontSize: 14 * textScale,
                    color: txtColor,
                  ),
                ),
              ],
            ),
    );
  }
}
