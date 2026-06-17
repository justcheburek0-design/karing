import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karing/screens/theme_define.dart';
import 'package:karing/screens/widgets/constant.dart';
import 'package:vpn_service/state.dart';

/// Animated power button in Max Speed VPN style.
/// Big circular button with glow, pulse animation, and rotation on connect.
class PowerButton extends StatefulWidget {
  final FlutterVpnServiceState state;
  final VoidCallback onPressed;
  final double size;

  const PowerButton({
    super.key,
    required this.state,
    required this.onPressed,
    this.size = kPowerButtonSize,
  });

  @override
  State<PowerButton> createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: kPowerButtonPulseDuration,
    );
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _updateAnimations();
  }

  void _updateAnimations() {
    if (widget.state == FlutterVpnServiceState.connected) {
      _pulseController.repeat();
      _glowController.repeat(reverse: true);
      _rotationController.forward();
    } else if (widget.state == FlutterVpnServiceState.connecting ||
        widget.state == FlutterVpnServiceState.reconnecting) {
      _pulseController.repeat();
      _glowController.stop();
      _rotationController.repeat();
    } else {
      _pulseController.stop();
      _pulseController.reset();
      _glowController.stop();
      _glowController.reset();
      _rotationController.stop();
      _rotationController.reset();
    }
  }

  @override
  void didUpdateWidget(PowerButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) _updateAnimations();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _glowController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Color _getColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (widget.state) {
      case FlutterVpnServiceState.connected:
        return ThemeDefine.kColorPrimary; // lime green
      case FlutterVpnServiceState.connecting:
      case FlutterVpnServiceState.reconnecting:
        return const Color(0xFFFBBF24); // amber
      case FlutterVpnServiceState.error:
        return scheme.error;
      default:
        return ThemeDefine.kColorOutline;
    }
  }

  String _getStatusText(BuildContext context) {
    switch (widget.state) {
      case FlutterVpnServiceState.connected:
        return 'Подключено';
      case FlutterVpnServiceState.connecting:
        return 'Подключение...';
      case FlutterVpnServiceState.reconnecting:
        return 'Переподключение...';
      case FlutterVpnServiceState.disconnecting:
        return 'Отключение...';
      case FlutterVpnServiceState.error:
        return 'Ошибка';
      default:
        return 'Отключено';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(context);
    final isConnected =
        widget.state == FlutterVpnServiceState.connected;
    final isConnecting =
        widget.state == FlutterVpnServiceState.connecting ||
            widget.state == FlutterVpnServiceState.reconnecting;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onPressed();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _pulseController,
          _glowController,
          _rotationController,
        ]),
        builder: (context, child) {
          final pulseScale = isConnected || isConnecting
              ? 1.0 + (_pulseController.value * 0.06)
              : 1.0;
          final glowOpacity = isConnected
              ? 0.2 + (_glowController.value * 0.2)
              : 0.0;

          return Transform.scale(
            scale: pulseScale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Glow ring
                Container(
                  width: widget.size + kPowerButtonGlowRadius * 2,
                  height: widget.size + kPowerButtonGlowRadius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(glowOpacity),
                        blurRadius: kPowerButtonGlowRadius,
                        spreadRadius: glowOpacity * 10,
                      ),
                    ],
                  ),
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    margin: EdgeInsets.all(kPowerButtonGlowRadius),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          color.withOpacity(0.15),
                          color.withOpacity(0.05),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeDefine.kColorSurface,
                        border: Border.all(
                          color: color.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Transform.rotate(
                          angle: _rotationController.value * 2 * math.pi,
                          child: Icon(
                            isConnected
                                ? Icons.power_settings_new
                                : Icons.power_settings_new_outlined,
                            size: kPowerButtonIconSize,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Status text
                Text(
                  _getStatusText(context),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
