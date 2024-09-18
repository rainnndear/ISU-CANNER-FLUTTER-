// lib/widgets/animated_menu_item.dart

import 'package:flutter/material.dart';

class AnimatedMenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const AnimatedMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedMenuItemState createState() => _AnimatedMenuItemState();
}

class _AnimatedMenuItemState extends State<AnimatedMenuItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          widget.onTap();
          _controller.reverse();
        });
      },
      child: AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(widget.icon, size: 40),
                title: Text(widget.title),
              ),
            ),
          );
        },
      ),
    );
  }
}
