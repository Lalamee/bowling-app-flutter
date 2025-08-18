import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;

  const AdaptiveText(this.text, {Key? key, this.style, this.maxLines = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      alignment: Alignment.centerLeft,
      fit: BoxFit.scaleDown,
      child: Text(text, style: style, maxLines: maxLines, overflow: TextOverflow.visible),
    );
  }
}
