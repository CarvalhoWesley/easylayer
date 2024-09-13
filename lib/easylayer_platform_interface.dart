import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'easylayer.dart';
import 'easylayer_method_channel.dart';

abstract class EasylayerPlatform extends PlatformInterface {
  /// Constructs a EasylayerPlatform.
  EasylayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static EasylayerPlatform _instance = MethodChannelEasylayer();

  /// The default instance of [EasylayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelEasylayer].
  static EasylayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EasylayerPlatform] when
  /// they register themselves.
  static set instance(EasylayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  late final IPrinter printer;
}
