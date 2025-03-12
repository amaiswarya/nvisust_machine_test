import 'package:flutter/material.dart';
import 'package:nvisust_test/src/core/utils/styles/app_colors.dart';
import 'package:nvisust_test/src/core/utils/styles/text_styles.dart';

enum ButtonTypes { primary, secondary, icon, inActive }

class ButtonWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final String text;
  final String? icon;
  final Color color;
  final bool isLoading;
  final double? width;

  const ButtonWidget.primary({
    required this.onTap,
    required this.text,
    this.icon,
    this.isLoading = false,
    this.color = AppColors.primary,
    super.key,
    this.width,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scale;
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => _tapDown(false),
      onTapDown: (_) => _tapDown(false),
      onTapCancel: _tapUp,
      onTap: () {
        _tapDown(true);
      },
      child: ScaleTransition(
        scale: _scale,
        child: Container(
            width: widget.width,
            margin: EdgeInsets.all(6),
            height: 45,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: widget.isLoading
                ? SizedBox.square(
                    dimension: 25,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Text(
                    widget.text,
                    style: TextStyles.white_16_500,
                  )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    showDefaultAnimation();
  }

  void showDefaultAnimation() {
    _scale = Tween<double>(begin: 1, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _tapDown(bool autoAnimate) {
    if (autoAnimate) {
      _controller.forward().whenComplete(_tapUp);
    } else {
      _controller.forward();
    }
  }

  void _tapUp() {
    _controller.reverse().whenComplete(() {
      widget.onTap!();
    });
  }
}
