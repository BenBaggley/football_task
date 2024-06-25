import 'package:flutter/material.dart';

/// {@template loading_indicator}
/// Page that displays a list of ships
/// {@endtemplate}
class LoadingIndicator extends StatelessWidget {
  /// {@macro loading_indicator}
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
