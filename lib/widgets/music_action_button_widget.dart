import 'package:flutter/material.dart';

class MusicActionButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onPressed;

  const MusicActionButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () {},
      icon: icon,
      style: IconButton.styleFrom(minimumSize: Size(32, 32), iconSize: 32),
    );
  }
}
