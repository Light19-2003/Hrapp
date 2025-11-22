import 'package:flutter/material.dart';

/// A highly customizable tile widget for consistent list items throughout the app.
///
/// Features:
/// - Customizable colors, spacing, and borders
/// - Built-in touch feedback
/// - Responsive design
/// - Accessibility support
/// - Theme integration
class CommonTile extends StatelessWidget {
  /// Creates a CommonTile widget
  const CommonTile({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    this.onTap,
    this.trailingIcon,
    this.backgroundColor,
    this.titleStyle,
    this.subtitleStyle,
    this.borderRadius = 12.0,
    this.elevation = 0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showBorder = false,
    this.borderColor,
    this.iconBackgroundColor,
    this.highlightColor,
    this.splashColor,
    this.height,
    this.width,
    this.titleMaxLines = 1,
    this.subtitleMaxLines = 1,
    this.overflow = TextOverflow.ellipsis,
  });

  final String title;
  final String subtitle;
  final Icon icon;
  final VoidCallback? onTap;
  final Widget? trailingIcon;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool showBorder;
  final Color? borderColor;
  final Color? iconBackgroundColor;
  final Color? highlightColor;
  final Color? splashColor;
  final double? height;
  final double? width;
  final int titleMaxLines;
  final int subtitleMaxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final defaultBackgroundColor =
        isDarkMode ? theme.colorScheme.surfaceVariant : Colors.white;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: height ?? 72,
        minWidth: width ?? double.infinity,
      ),
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor ?? defaultBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: elevation > 0
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: elevation * 2,
                    offset: Offset(0, elevation),
                  )
                ]
              : null,
          border: showBorder
              ? Border.all(
                  color: borderColor ?? theme.dividerColor,
                  width: 1.0,
                )
              : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onTap,
            highlightColor: highlightColor ?? theme.highlightColor,
            splashColor: splashColor ?? theme.splashColor,
            child: Container(
              padding: padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLeadingIcon(context),
                  const SizedBox(width: 16),
                  _buildTextContent(context),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    trailingIcon!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: iconBackgroundColor ??
            (icon.color?.withOpacity(0.1) ??
                theme.primaryColor.withOpacity(0.1)),
        shape: BoxShape.circle,
      ),
      child: IconTheme.merge(
        data: IconThemeData(
          size: 24,
          color: icon.color ?? theme.primaryColor,
        ),
        child: icon,
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTitleStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.onSurface,
    );

    final defaultSubtitleStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? defaultTitleStyle,
            maxLines: titleMaxLines,
            overflow: overflow,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: subtitleStyle ?? defaultSubtitleStyle,
            maxLines: subtitleMaxLines,
            overflow: overflow,
          ),
        ],
      ),
    );
  }
}
