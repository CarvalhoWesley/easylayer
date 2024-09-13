enum Status {
  OK,
  OVERHEAT,
  OUT_OF_PAPER,
  UNKNOWN_ERROR;

  /// Parse [source] as a Status.
  ///
  /// Throws a FormatException if [source] is not valid.
  static Status parse(String source) {
    switch (source) {
      case 'OK':
        return Status.OK;
      case 'OVERHEAT':
        return Status.OVERHEAT;
      case 'OUT_OF_PAPER':
        return Status.OUT_OF_PAPER;
      case 'UNKNOWN_ERROR':
        return Status.UNKNOWN_ERROR;
      default:
        throw FormatException(source);
    }
  }

  /// Parse [source] as a Status.
  ///
  /// Returns null where a call to [parse] would throw a [FormatException].
  static Status? tryParse(String source) {
    try {
      return parse(source);
    } on FormatException catch (_) {
      return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case Status.OK:
        return 'OK';
      case Status.OVERHEAT:
        return 'OVERHEAT';
      case Status.OUT_OF_PAPER:
        return 'OUT_OF_PAPER';
      case Status.UNKNOWN_ERROR:
        return 'UNKNOWN_ERROR';
    }
  }
}
