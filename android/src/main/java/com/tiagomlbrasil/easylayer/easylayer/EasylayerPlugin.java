package com.tiagomlbrasil.easylayer.easylayer;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** EasylayerPlugin */
public class EasylayerPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private GertecPrinter gertecPrinter;
  private GertecScanner gertecScanner;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "easylayer");
    channel.setMethodCallHandler(this);

    this.gertecPrinter = new GertecPrinter(flutterPluginBinding.getApplicationContext());
    this.gertecScanner = new GertecScanner(flutterPluginBinding.getApplicationContext());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    this.gertecPrinter.handler.onMethodCall(call, result);
    this.gertecScanner.handler.onMethodCall(call, result);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
     if (gertecScanner != null) {
        gertecScanner.dispose();
    }
  }
}
