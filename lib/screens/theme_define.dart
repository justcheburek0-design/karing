import 'package:flutter/material.dart';

class ThemeDefine {
  /// Max Speed VPN primary accent — lime green
  static const kColorPrimary = Color(0xFFA8E63D);

  /// Dark surface / background tones
  static const kColorBgPrimary = Color(0xFF0A0A0D);
  static const kColorBgSecondary = Color(0xFF131410);
  static const kColorSurface = Color(0xFF131410);

  /// Text & icon tones
  static const kColorOnSurface = Color(0xFFE4E3D9);
  static const kColorOnSurfaceVariant = Color(0xFFC7C7BA);

  /// Borders & dividers
  static const kColorOutline = Color(0xFF919285);

  /// Icon / chip background
  static const kColorSurfaceVariant = Color(0xFF46483D);

  /// Legacy aliases — kept for compatibility
  static const kColorBlue = Color(0xFFA8E63D);
  static const kColorGrey = Color(0xFF919285);
  static const kColorGreenBright = Color(0xFFA8E63D);

  static const String kThemeSystem = "system";
  static const String kThemeLight = "light";
  static const String kThemeDark = "dark";

  // Max Speed VPN uses rounded 16 px cards
  static const BorderRadiusGeometry kBorderRadius = BorderRadius.all(
    Radius.circular(16),
  );

  // ── Max Speed VPN Power Button ────────────────────────────────
  static const double kPowerButtonSize = 140.0;
  static const double kPowerButtonIconSize = 56.0;
  static const double kPowerButtonGlowRadius = 30.0;
  static const double kPowerButtonPulseScale = 1.08;
  static const Duration kPowerButtonPulseDuration =
      Duration(milliseconds: 1200);
  static const Color kPowerButtonColorDisconnected = Color(0xFF46483D);
  static const Color kPowerButtonColorConnected = Color(0xFFA8E63D);
  static const Color kPowerButtonGlowColor = Color(0x55A8E63D);

  // ── Max Speed VPN background gradient ─────────────────────────
  static const LinearGradient kHomeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A0A0D), Color(0xFF131410)],
  );
}
