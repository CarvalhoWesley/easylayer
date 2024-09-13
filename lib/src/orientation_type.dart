enum OrientationType {
  DEFAULT,
  INVERTED;

  /// Parse [source] as an OrientationType.
  ///
  /// Throws a FormatException if [source] is not valid.
  static OrientationType parse(String source) {
    switch (source) {
      case 'DEFAULT':
        return OrientationType.DEFAULT;
      case 'INVERTED':
        return OrientationType.INVERTED;
      default:
        throw FormatException(source);
    }
  }

  /// Parse [source] as an OrientationType.
  ///
  /// Returns null where a call to [parse] would throw a [FormatException].
  static OrientationType? tryParse(String source) {
    try {
      return parse(source);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case OrientationType.DEFAULT:
        return 'DEFAULT';
      case OrientationType.INVERTED:
        return 'INVERTED';
    }
  }
}
