abstract class IScanner {
  Future start();

  Future<void> stop();

  Stream<String> get onScan;
}
