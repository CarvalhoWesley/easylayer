enum CutType {
  PAPER_PARTIAL_CUT,
  PAPER_FULL_CUT;

  /// Parse [source] as a CutType.
  ///
  /// Throws a FormatException if [source] is not valid.
  static CutType parse(String source) {
    switch (source) {
      case 'PAPER_PARTIAL_CUT':
        return CutType.PAPER_PARTIAL_CUT;
      case 'PAPER_FULL_CUT':
        return CutType.PAPER_FULL_CUT;
      default:
        throw FormatException(source);
    }
  }

  /// Parse [source] as a CutType.
  ///
  /// Returns null where a call to [parse] would throw a [FormatException].
  static CutType? tryParse(String source) {
    try {
      return parse(source);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case CutType.PAPER_PARTIAL_CUT:
        return 'PAPER_PARTIAL_CUT';
      case CutType.PAPER_FULL_CUT:
        return 'PAPER_FULL_CUT';
    }
  }
}
