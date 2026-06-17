import 'package:flutter/material.dart';
import 'package:karing/screens/theme_define.dart';

class ThemeDataLight {
  // ── Max Speed VPN light palette ─────────────────────────────
  static const Color mainColor = Color(0xFFF5F5EF); // card / surface bg
  static const Color mainBgColor = Color(0xFFEDEDE6); // scaffold bg

  static ThemeData theme(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: ThemeDefine.kColorPrimary,
      brightness: Brightness.light,
      primary: ThemeDefine.kColorPrimary,
      onPrimary: const Color(0xFF0A0A0D),
      primaryContainer: const Color(0xFFD4F58E),
      onPrimaryContainer: const Color(0xFF1A2E00),
      secondary: const Color(0xFF5A6145),
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFDDE6C3),
      surface: mainBgColor,
      onSurface: const Color(0xFF1A1C16),
      surfaceContainerHighest: mainColor,
      surfaceContainerHigh: mainColor,
      surfaceContainer: mainColor,
      surfaceContainerLow: mainColor,
      surfaceContainerLowest: Colors.white,
      outline: const Color(0xFF7A7B6E),
      outlineVariant: const Color(0xFFBFC0B0),
      error: const Color(0xFFD32F2F),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      platform: TargetPlatform.iOS,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: mainColor.withValues(alpha: 0.5),
        filled: true,
        labelStyle: const TextStyle(color: Color(0xFF5A6145)),
        floatingLabelStyle: TextStyle(color: ThemeDefine.kColorPrimary),
        helperStyle: const TextStyle(color: Color(0xFF5A6145)),
        hintStyle: const TextStyle(color: Color(0xFF5A6145)),
        errorStyle: const TextStyle(color: Color(0xFFD32F2F)),
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF7A7B6E)),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeDefine.kColorPrimary, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      listTileTheme: const ListTileThemeData(dense: true),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.focused)) {
              return ThemeDefine.kColorPrimary.withValues(alpha: 0.8);
            }
            if (states.contains(WidgetState.selected)) {
              return ThemeDefine.kColorPrimary.withValues(alpha: 0.6);
            }
            return ThemeDefine.kColorPrimary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,
          ) {
            return const Color(0xFF0A0A0D);
          }),
          shape: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            );
          }),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          return Colors.white;
        }),
        checkColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          return ThemeDefine.kColorPrimary;
        }),
        overlayColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          return const Color(0xFF7A7B6E);
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeDefine.kColorPrimary,
        strokeWidth: 2,
      ),
    );
  }
}
