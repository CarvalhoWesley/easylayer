import 'dart:convert';

import 'alignment.dart';

class PrintConfig {
  final int width;
  final int height;
  final Alignment alignment;

  const PrintConfig({
    this.width = 0,
    this.height = 0,
    this.alignment = Alignment.LEFT,
  });

  PrintConfig copyWith({
    int? width,
    int? height,
    Alignment? alignment,
  }) {
    return PrintConfig(
      width: width ?? this.width,
      height: height ?? this.height,
      alignment: alignment ?? this.alignment,
    );
  }

  PrintConfig.fromMap(Map<String, dynamic> data)
      : width = data['width'],
        height = data['height'],
        alignment = Alignment.parse(data['alignment']);

  Map<String, dynamic> toMap() => {
        'width': width,
        'height': height,
        'alignment': alignment.toString(),
      };

  @override
  String toString() => jsonEncode(toMap());
}
