import 'package:flutter/material.dart';

class AtomButton extends StatefulWidget {
  final IconData? icon;
  final String? text;
  final void Function()? onPressed;
  final bool enabled;

  const AtomButton({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  _AtomButtonState createState() => _AtomButtonState();
}

class _AtomButtonState extends State<AtomButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    Color textColor;

    if (_pressed && widget.enabled) {
      backgroundColor = Colors.green;
      borderColor = Colors.red;
      iconColor = Colors.white;
      textColor = Colors.white;
    } else if (!widget.enabled) {
      backgroundColor = Colors.grey[300]!;
      borderColor = Colors.grey[700]!;
      iconColor = borderColor;
      textColor = borderColor;
    } else {
      backgroundColor = Colors.red;
      borderColor = Colors.red;
      iconColor = Colors.white;
      textColor = Colors.white;
    }

    return GestureDetector(
      onTapDown: (_) {
        if (widget.enabled) {
          setState(() {
            _pressed = true;
          });
        }
      },
      onTapUp: (_) {
        if (widget.enabled) {
          setState(() {
            _pressed = false;
          });
          widget.onPressed?.call();
        }
      },
      onTapCancel: () {
        if (widget.enabled) {
          setState(() {
            _pressed = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null)
              Icon(
                widget.icon,
                color: iconColor,
              ),
            if (widget.icon != null && widget.text != null)
              const SizedBox(width: 8.0),
            if (widget.text != null)
              Text(
                widget.text!,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
