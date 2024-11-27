import 'dart:developer';

import 'package:easylayer/src/scanner.dart';
import 'package:flutter/services.dart';

class ScannerMethodChannel implements IScanner {
  final MethodChannel methodChannel;

  const ScannerMethodChannel(
    this.methodChannel,
  );

  @override
  Future start() async {
    final requestId = await methodChannel.invokeMethod('START_SCANNER');
    log('requestId: $requestId');
  }

  @override
  Future stop() async {
    final requestId = await methodChannel.invokeMethod('STOP_SCANNER');
    log('requestId: $requestId');
  }
}
