import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    required this.infoThemeColour,
    required this.infoIcon,
    required this.infoTitle,
    required this.infoValue,
    super.key,
  });

  final Color infoThemeColour;
  final Widget infoIcon;
  final String infoTitle;
  final String infoValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: const Row(),
    );
  }
}
