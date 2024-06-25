import 'package:flutter/material.dart';

/// {@template restricted_width}
/// A widget that centers its child within itself and restricts the width of the child
/// {@endtemplate}
class RestrictedWidth extends StatelessWidget {
  /// {@macro restricted_width}
  const RestrictedWidth({
    super.key,
    required this.maxWidth,
    required this.child,
  });

  /// Maximum width for the child to be displayed
  final double maxWidth;

  /// Child to be displayed
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
