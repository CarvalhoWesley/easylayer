import 'dart:convert';

import 'barcode_type.dart';
import 'size.dart';

class BarcodeFormat {
  final BarcodeType barcodeType;
  final Size? size;
  final int? whiteSpace;

  const BarcodeFormat({
    required this.barcodeType,
    this.size,
    this.whiteSpace,
  });

  BarcodeFormat copyWith({
    BarcodeType? barcodeType,
    Size? size,
    int? whiteSpace,
  }) {
    return BarcodeFormat(
      barcodeType: barcodeType ?? this.barcodeType,
      size: size ?? this.size,
      whiteSpace: whiteSpace ?? this.whiteSpace,
    );
  }

  BarcodeFormat.fromMap(Map<String, dynamic> data)
      : barcodeType = BarcodeType.parse(data['barcode_type']),
        size = Size.tryParse(data['size']),
        whiteSpace = data['white_space'];

  Map<String, dynamic> toMap() => {
        'barcode_type': barcodeType.toString(),
        if (size != null) 'size': size.toString(),
        if (whiteSpace != null) 'white_space': whiteSpace,
      };

  @override
  String toString() => jsonEncode(toMap());
}
