import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:karing/app/utils/platform_utils.dart';

import 'num.dart';

import 'package:flutter/material.dart';

const helperPort = 47890;
const maxTextScale = 1.4;
const minTextScale = 0.8;
final baseInfoEdgeInsets = EdgeInsets.symmetric(
  vertical: 16.ap,
  horizontal: 16.ap,
);

final defaultTextScaleFactor =
    WidgetsBinding.instance.platformDispatcher.textScaleFactor;
const httpTimeoutDuration = Duration(milliseconds: 5000);
const moreDuration = Duration(milliseconds: 100);
const animateDuration = Duration(milliseconds: 100);
const midDuration = Duration(milliseconds: 200);
const commonDuration = Duration(milliseconds: 300);
const defaultUpdateDuration = Duration(days: 1);
final double kHeaderHeight = PlatformUtils.isPC()
    ? !Platform.isMacOS
          ? 40
          : 28
    : 0;

const maxMobileWidth = 600;
const maxLaptopWidth = 840;

final commonFilter = ImageFilter.blur(
  sigmaX: 5,
  sigmaY: 5,
  tileMode: TileMode.mirror,
);

const defaultPrimaryColor = 0XFFD8C0C3;

// Max Speed VPN glass card style constants
const double kGlassCardRadius = 18.0;
const double kGlassCardPadding = 16.0;
const double kGlassCardBorderWidth = 1.0;
final Color kGlassCardBaseColor = const Color(0xFF131410);
const double kGlassCardOpacity = 0.7;
const double kGlassCardBorderOpacity = 0.08;
const double kGlassCardHoverOpacity = 0.85;
const double kGlassIconCircleOpacity = 0.15;
final EdgeInsets kGlassCardEdgeInsets = EdgeInsets.all(kGlassCardPadding);
final BorderRadius kGlassCardBorderRadius = BorderRadius.circular(kGlassCardRadius);

// Max Speed VPN power button constants
const double kPowerButtonSize = 180.0;
const double kPowerButtonIconSize = 72.0;
const double kPowerButtonGlowBlur = 30.0;
const double kPowerButtonGlowRadius = 30.0;
const double kPowerButtonPulseScale = 1.15;
const Duration kPowerButtonPulseDuration = Duration(milliseconds: 1200);

double getWidgetHeight(num lines) {
  if (lines == 0) {
    return 50;
  }
  if (lines <= 1) {
    return max(lines * 78 + (lines - 1) * 16, 0).ap;
  }
  final oneLine = getWidgetHeight(1);
  return oneLine + (lines - 1) * 32;
}
