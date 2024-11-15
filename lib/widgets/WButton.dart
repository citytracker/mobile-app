import 'package:flutter/material.dart';

class WButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  Color? color;
  final Color fontColor;
  final bool isEnabled;

  WButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color,
      this.fontColor = Colors.white,
      this.icon,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    color = color ?? Colors.blue;

    return SizedBox(
      height: 40,
      child: FilledButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => isEnabled ? color! : Colors.grey)),
          onPressed: isEnabled ? onPressed : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(color: fontColor),
              ),
              if (icon != null)
                const SizedBox(
                    width: 8.0), // Espaçamento entre o texto e o ícone
              if (icon != null) Icon(icon),
            ],
          )),
    );
  }
}
