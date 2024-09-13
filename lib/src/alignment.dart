enum Alignment {
  LEFT,
  CENTER,
  RIGHT;

  /// Parse [source] as an Alignment.
  ///
  /// Throws a FormatException if [source] is not valid.
  static Alignment parse(String source) {
    switch (source) {
      case 'LEFT':
        return Alignment.LEFT;
      case 'CENTER':
        return Alignment.CENTER;
      case 'RIGHT':
        return Alignment.RIGHT;
      default:
        throw FormatException(source);
    }
  }

  /// Parse [source] as an Alignment.
  ///
  /// Returns null where a call to [parse] would throw a [FormatException].
  static Alignment? tryParse(String source) {
    try {
      return parse(source);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case Alignment.LEFT:
        return 'LEFT';
      case Alignment.CENTER:
        return 'CENTER';
      case Alignment.RIGHT:
        return 'RIGHT';
    }
  }
}
