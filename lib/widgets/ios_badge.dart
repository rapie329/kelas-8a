import 'package:flutter/cupertino.dart';

enum IosBadgeType { blue, green, orange, red, gray, purple }

class IosBadge extends StatelessWidget {
  final String text;
  final IosBadgeType type;
  final IconData? icon;

  const IosBadge({
    super.key,
    required this.text,
    this.type = IosBadgeType.blue,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (type) {
      case IosBadgeType.blue:
        bg = const Color(0x1F007AFF);
        fg = const Color(0xFF007AFF);
        break;
      case IosBadgeType.green:
        bg = const Color(0x1F34C759);
        fg = const Color(0xFF34C759);
        break;
      case IosBadgeType.orange:
        bg = const Color(0x1FFF9500);
        fg = const Color(0xFFFF9500);
        break;
      case IosBadgeType.red:
        bg = const Color(0x1FFF3B30);
        fg = const Color(0xFFFF3B30);
        break;
      case IosBadgeType.purple:
        bg = const Color(0x1F5856D6);
        fg = const Color(0xFF5856D6);
        break;
      case IosBadgeType.gray:
        bg = const Color(0x1A8E8E93);
        fg = const Color(0xFF8E8E93);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: fg,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
