import 'package:easylayer/src/scanner_method_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'easylayer_platform_interface.dart';
import 'src/printer_method_channel.dart';

/// An implementation of [EasylayerPlatform] that uses method channels.
class MethodChannelEasylayer extends EasylayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  late final MethodChannel methodChannel;

  @visibleForTesting
  late final EventChannel eventChannel;

  MethodChannelEasylayer() {
    methodChannel = const MethodChannel('easylayer');
    eventChannel = const EventChannel('easylayer/scanner');

    super.printer = PrinterMethodChannel(methodChannel);
    super.scanner = ScannerMethodChannel(methodChannel, eventChannel);
  }
}
