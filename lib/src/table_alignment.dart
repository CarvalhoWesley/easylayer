import 'dart:convert';

import 'alignment.dart';

class TableFormat {
  final Alignment headerAlignment;
  final Alignment rowAlignment;
  final int fontSize;

  const TableFormat({
    this.headerAlignment = Alignment.LEFT,
    this.rowAlignment = Alignment.LEFT,
    this.fontSize = 10,
  });

  TableFormat copyWith({
    Alignment? headerAlignment,
    Alignment? rowAlignment,
    int? fontSize,
  }) {
    return TableFormat(
      headerAlignment: headerAlignment ?? this.headerAlignment,
      rowAlignment: rowAlignment ?? this.rowAlignment,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  TableFormat.fromMap(Map<String, dynamic> data)
      : headerAlignment =
            Alignment.tryParse(data['header_alignment']) ?? Alignment.LEFT,
        rowAlignment =
            Alignment.tryParse(data['row_alignment']) ?? Alignment.LEFT,
        fontSize = data['font_size'];

  Map<String, dynamic> toMap() => {
        'header_alignment': headerAlignment.toString(),
        'row_alignment': rowAlignment.toString(),
        'font_size': fontSize,
      };

  @override
  String toString() => jsonEncode(toMap());
}
