import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackArrowActive;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackArrowActive = true,
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
      leading: isBackArrowActive? IconButton(
        icon: SvgPicture.asset(
          'assets/icons/left-arrow.svg',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 20,
          height: 20,
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
