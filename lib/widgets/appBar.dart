import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonActive;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButtonActive = true,
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
      backgroundColor: Colors.deepPurple.shade600,
      elevation: 0.0,
      leading: isBackButtonActive? BackButton(
        color: Colors.white,
        style: const ButtonStyle(
          iconSize: WidgetStatePropertyAll(30),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ): const SizedBox.shrink(),
    );
  }

  // Implement PreferredSizeWidget to define the appBar height
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
