// ignore_for_file: file_names, constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

enum DelayedAnimations {
  SLIDE_FROM_LEFT,
  SLIDE_FROM_RIGHT,
  SLIDE_FROM_TOP,
  SLIDE_FROM_BOTTOM,
  NONE,
}

class DelayedWidget extends StatefulWidget {
  const DelayedWidget({
    Key? key,

    /// The Widget to be animated
    required this.child,

    /// Set the duration of the animation
    this.animationDuration = const Duration(milliseconds: 300),

    /// Set the duration of delay to start animation
    this.delayDuration = Duration.zero,

    /// Set the animation

    /// Set animation enabled/disbled
    this.enabled = true,
  }) : super(key: key);

  final Widget child;
  final Duration delayDuration;
  final Duration animationDuration;
  final bool enabled;

  @override
  _DelayedWidgetState createState() => _DelayedWidgetState();
}

class _DelayedWidgetState extends State<DelayedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isAnimationControllerDisposed = false;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(widget.delayDuration);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

}
