import 'package:flutter/material.dart';

class ListButton extends StatelessWidget {
  final String label;
  final Icon icon;
  final VoidCallback onPressed;

  const ListButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white,
        child: Ink(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 8.0),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
