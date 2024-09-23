import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
      title,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w500
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurple.shade400,
      elevation: 0.0,
      actions: actions, // You can pass action buttons like icons
      leading: leading, // Optionally pass a custom leading widget like a back button or drawer
    );
  }

  // Implement PreferredSizeWidget to define the appBar height
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
