import 'package:flutter/material.dart';
import 'package:karing/screens/theme_define.dart';

class ThemeDataDark {
  // ── Max Speed VPN dark palette ──────────────────────────────
  static const Color mainColor = Color(0xFF131410); // surface / card bg
  static const Color mainBgColor = Color(0xFF0A0A0D); // scaffold bg

  static ThemeData theme(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: ThemeDefine.kColorPrimary,
      brightness: Brightness.dark,
      primary: ThemeDefine.kColorPrimary,
      onPrimary: const Color(0xFF0A0A0D),
      primaryContainer: ThemeDefine.kColorSurfaceVariant,
      onPrimaryContainer: ThemeDefine.kColorOnSurface,
      secondary: ThemeDefine.kColorOnSurfaceVariant,
      onSecondary: ThemeDefine.kColorOnSurface,
      secondaryContainer: ThemeDefine.kColorSurfaceVariant,
      surface: mainBgColor,
      onSurface: ThemeDefine.kColorOnSurface,
      surfaceContainerHighest: mainColor,
      surfaceContainerHigh: mainColor,
      surfaceContainer: mainColor,
      surfaceContainerLow: mainColor,
      surfaceContainerLowest: const Color(0xFF060608),
      outline: ThemeDefine.kColorOutline,
      outlineVariant: ThemeDefine.kColorSurfaceVariant,
      error: const Color(0xFFFF7043),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      platform: TargetPlatform.iOS,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        color: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: mainColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: mainColor.withValues(alpha: 0.5),
        filled: true,
        labelStyle: TextStyle(color: ThemeDefine.kColorOnSurfaceVariant),
        floatingLabelStyle: TextStyle(color: ThemeDefine.kColorPrimary),
        helperStyle: TextStyle(color: ThemeDefine.kColorOnSurfaceVariant),
        hintStyle: TextStyle(color: ThemeDefine.kColorOnSurfaceVariant),
        errorStyle: const TextStyle(color: Color(0xFFFF7043)),
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeDefine.kColorOutline),
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
          return mainColor;
        }),
        checkColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          return ThemeDefine.kColorPrimary;
        }),
        overlayColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          return ThemeDefine.kColorOutline;
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeDefine.kColorPrimary,
        strokeWidth: 2,
      ),
    );
  }
}
