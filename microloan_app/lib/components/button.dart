import 'package:flutter/material.dart';
import '../themes.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonType type;
  final double width;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.type = ButtonType.primary,
    this.width = double.infinity,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(context),
          foregroundColor: _getTextColor(context),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: type == ButtonType.outlined
                ? BorderSide(color: Theme.of(context).primaryColor)
                : BorderSide.none,
          ),
          elevation: type == ButtonType.primary ? 2 : 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: _getTextColor(context),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isDisabled) return Theme.of(context).disabledColor;
    return switch (type) {
      ButtonType.primary => Theme.of(context).primaryColor,
      ButtonType.secondary => Theme.of(context).colorScheme.secondary,
      ButtonType.outlined => Colors.transparent,
      ButtonType.danger => Theme.of(context).colorScheme.error,
    };
  }

  Color _getTextColor(BuildContext context) {
    if (isDisabled) return Theme.of(context).colorScheme.onSurface.withOpacity(0.38);
    return switch (type) {
      ButtonType.primary => Theme.of(context).colorScheme.onPrimary,
      ButtonType.secondary => Theme.of(context).colorScheme.onSecondary,
      ButtonType.outlined => Theme.of(context).primaryColor,
      ButtonType.danger => Theme.of(context).colorScheme.onError,
    };
  }
}

enum ButtonType { primary, secondary, outlined, danger }