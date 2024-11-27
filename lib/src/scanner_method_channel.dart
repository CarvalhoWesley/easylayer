import 'package:easylayer/src/scanner.dart';
import 'package:flutter/services.dart';

class ScannerMethodChannel implements IScanner {
  final MethodChannel methodChannel;
  final EventChannel eventChannel;

  ScannerMethodChannel(this.methodChannel, this.eventChannel);

  @override
  Future start() {
    return methodChannel.invokeMethod('START_SCANNER');
  }

  @override
  Future<void> stop() async {
    return methodChannel.invokeMethod('STOP_SCANNER');
  }
  
  // Para escutar os resultados do scanner
  Stream<String> get onScan {
    return eventChannel.receiveBroadcastStream().map((value) => value as String);
  }
}
