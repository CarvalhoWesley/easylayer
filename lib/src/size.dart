enum Size {
  SMALL,
  HALF_PAPER,
  FULL_PAPER;

  /// Parse [source] as a Size.
  ///
  /// Throws a FormatException if [source] is not valid.
  static Size parse(String source) {
    switch (source) {
      case 'SMALL':
        return Size.SMALL;
      case 'HALF_PAPER':
        return Size.HALF_PAPER;
      case 'FULL_PAPER':
        return Size.FULL_PAPER;
      default:
        throw FormatException(source);
    }
  }

  /// Parse [source] as a Size.
  ///
  /// Returns null where a call to [parse] would throw a [FormatException].
  static Size? tryParse(String source) {
    try {
      return parse(source);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case Size.SMALL:
        return 'SMALL';
      case Size.HALF_PAPER:
        return 'HALF_PAPER';
      case Size.FULL_PAPER:
        return 'FULL_PAPER';
    }
  }
}
