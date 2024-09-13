enum BarcodeType {
  AZTEC(0),
  CODABAR(1),
  CODE_39(2),
  CODE_93(3),
  CODE_128(4),
  DATA_MATRIX(5),
  EAN_8(6),
  EAN_13(7),
  ITF(8),
  MAXICODE(9),
  PDF_417(10),
  QR_CODE(11),
  RSS_14(12),
  RSS_EXPANDED(13),
  UPC_A(14),
  UPC_E(15),
  UPC_EAN_EXTENSION(16);

  final int value;

  const BarcodeType(this.value);

  /// Parse [source] as a BarcodeType.
  ///
  /// Throws a FormatException if [source] is not valid.
  static BarcodeType parse(String source) {
    switch (source) {
      case 'AZTEC':
        return BarcodeType.AZTEC;
      case 'CODABAR':
        return BarcodeType.CODABAR;
      case 'CODE_39':
        return BarcodeType.CODE_39;
      case 'CODE_93':
        return BarcodeType.CODE_93;
      case 'CODE_128':
        return BarcodeType.CODE_128;
      case 'DATA_MATRIX':
        return BarcodeType.DATA_MATRIX;
      case 'EAN_8':
        return BarcodeType.EAN_8;
      case 'EAN_13':
        return BarcodeType.EAN_13;
      case 'ITF':
        return BarcodeType.ITF;
      case 'MAXICODE':
        return BarcodeType.MAXICODE;
      case 'PDF_417':
        return BarcodeType.PDF_417;
      case 'QR_CODE':
        return BarcodeType.QR_CODE;
      case 'RSS_14':
        return BarcodeType.RSS_14;
      case 'RSS_EXPANDED':
        return BarcodeType.RSS_EXPANDED;
      case 'UPC_A':
        return BarcodeType.UPC_A;
      case 'UPC_E':
        return BarcodeType.UPC_E;
      case 'UPC_EAN_EXTENSION':
        return BarcodeType.UPC_EAN_EXTENSION;
      default:
        throw FormatException(source);
    }
  }

  /// Parse [source] as a BarcodeType.
  ///
  /// Returns null where a call to [parse] would throw a [FormatException].
  static BarcodeType? tryParse(String source) {
    try {
      return parse(source);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case BarcodeType.AZTEC:
        return 'AZTEC';
      case BarcodeType.CODABAR:
        return 'CODABAR';
      case BarcodeType.CODE_39:
        return 'CODE_39';
      case BarcodeType.CODE_93:
        return 'CODE_93';
      case BarcodeType.CODE_128:
        return 'CODE_128';
      case BarcodeType.DATA_MATRIX:
        return 'DATA_MATRIX';
      case BarcodeType.EAN_8:
        return 'EAN_8';
      case BarcodeType.EAN_13:
        return 'EAN_13';
      case BarcodeType.ITF:
        return 'ITF';
      case BarcodeType.MAXICODE:
        return 'MAXICODE';
      case BarcodeType.PDF_417:
        return 'PDF_417';
      case BarcodeType.QR_CODE:
        return 'QR_CODE';
      case BarcodeType.RSS_14:
        return 'RSS_14';
      case BarcodeType.RSS_EXPANDED:
        return 'RSS_EXPANDED';
      case BarcodeType.UPC_A:
        return 'UPC_A';
      case BarcodeType.UPC_E:
        return 'UPC_E';
      case BarcodeType.UPC_EAN_EXTENSION:
        return 'UPC_EAN_EXTENSION';
    }
  }
}
