import 'package:flutter/material.dart';

class DMButtonStyle {
  /// Full width, 48px tall.
  static const defaultMinSize = Size.fromHeight(48);

  static final _shape = WidgetStatePropertyAll<OutlinedBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  static ButtonStyle active(
    ColorScheme scheme, {
    Size minimumSize = defaultMinSize,
  }) => ButtonStyle(
    minimumSize: WidgetStatePropertyAll(minimumSize),
    backgroundColor: WidgetStatePropertyAll(scheme.primary),
    foregroundColor: WidgetStatePropertyAll(scheme.onPrimary),
    shape: _shape,
    splashFactory: InkRipple.splashFactory,
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return scheme.onPrimary.withValues(alpha: 0.2);
      }
      if (states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.focused)) {
        return scheme.onPrimary.withValues(alpha: 0.08);
      }
      return null;
    }),
  );

  /// Not clickable: no splash, no highlight, no cursor feedback.
  /// Pair with `onPressed: null` so taps are actually ignored.
  static ButtonStyle deactive(
    ColorScheme scheme, {
    Size minimumSize = defaultMinSize,
  }) => ButtonStyle(
    minimumSize: WidgetStatePropertyAll(minimumSize),
    backgroundColor: WidgetStatePropertyAll(
      scheme.primary.withValues(alpha: 0.5),
    ),
    foregroundColor: WidgetStatePropertyAll(
      scheme.onPrimary.withValues(alpha: 0.7),
    ),
    elevation: const WidgetStatePropertyAll(0),
    shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    shape: _shape,
    splashFactory: NoSplash.splashFactory,
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    enableFeedback: false,
    mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.basic),
  );
}
