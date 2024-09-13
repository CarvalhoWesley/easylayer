import 'dart:convert';

import 'alignment.dart';

class TextFormat {
  final bool bold;
  final bool italic;
  final bool underscore;
  final int fontSize;
  final int lineSpacing;
  final Alignment alignment;

  const TextFormat({
    this.bold = false,
    this.italic = false,
    this.underscore = false,
    this.fontSize = 20,
    this.lineSpacing = 0,
    this.alignment = Alignment.LEFT,
  }) : assert(fontSize > 0, 'Invalid font size.');

  TextFormat copyWith({
    bool? bold,
    bool? italic,
    bool? underscore,
    int? fontSize,
    int? lineSpacing,
    Alignment? alignment,
  }) {
    return TextFormat(
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
      underscore: underscore ?? this.underscore,
      fontSize: fontSize ?? this.fontSize,
      lineSpacing: lineSpacing ?? this.lineSpacing,
      alignment: alignment ?? this.alignment,
    );
  }

  TextFormat.fromMap(Map<String, dynamic> data)
      : bold = data['bold'],
        italic = data['italic'],
        underscore = data['underscore'],
        fontSize = data['font_size'],
        lineSpacing = data['line_spacing'],
        alignment = Alignment.parse(data['alignment']);

  Map<String, dynamic> toMap() => {
        'bold': bold,
        'italic': italic,
        'underscore': underscore,
        'font_size': fontSize,
        'line_spacing': lineSpacing,
        'alignment': alignment.toString(),
      };

  @override
  String toString() => jsonEncode(toMap());
}
