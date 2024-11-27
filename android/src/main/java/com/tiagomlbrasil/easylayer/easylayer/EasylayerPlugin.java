package com.tiagomlbrasil.easylayer.easylayer;

import android.app.Activity;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * EasylayerPlugin
 */
public class EasylayerPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Activity activity;
    private GertecPrinter gertecPrinter;
    private GertecScanner gertecScanner; // Adicionado para gerenciar o scanner.

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "easylayer");
        channel.setMethodCallHandler(this);

        this.gertecPrinter = new GertecPrinter(flutterPluginBinding.getApplicationContext());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        try {
            switch (call.method) {
                default:
                    result.notImplemented();

                case "PRINT_TEXT": {
                    gertecPrinter.printText(call, result);
                    break;
                }

                case "PRINT_IMAGE": {
                    gertecPrinter.printImage(call, result);
                    break;
                }

                case "PRINT_HTML": {
                    gertecPrinter.printHtml(call, result);
                    break;
                }

                case "PRINT_TABLE": {
                    gertecPrinter.printTable(call, result);
                    break;
                }

                case "PRINT_BARCODE": {
                    gertecPrinter.printBarcode(call, result);
                    break;
                }

                case "SCROLL_PAPER": {
                    gertecPrinter.scrollPaper(call, result);
                    break;
                }

                case "GET_STATUS": {
                    gertecPrinter.getStatus(call, result);
                    break;
                }

                case "CUT_PAPER": {
                    gertecPrinter.cutPaper(call, result);
                    break;
                }

                case "START_SCANNER":
                    if (gertecScanner != null) {
                        gertecScanner.startScanner(call, result);
                    } else {
                        result.error("SCANNER_UNAVAILABLE", "Scanner is not initialized.", null);
                    }
                    break;

                case "STOP_SCANNER":
                    if (gertecScanner != null) {
                        gertecScanner.stopScanner(call, result);
                    } else {
                        result.error("SCANNER_UNAVAILABLE", "Scanner is not initialized.", null);
                    }
                    break;
            }
        } catch (Exception e) {
            result.error(e.getMessage() == null ? "" : e.getMessage(), null, null);
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    // Métodos de ActivityAware
    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        this.gertecScanner = new GertecScanner(this.activity); // Scanner inicializado.
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.activity = null;
        if (gertecScanner != null) {
            gertecScanner.dispose(); // Dispose scanner corretamente
        }
        this.gertecScanner = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
        this.gertecScanner = new GertecScanner(this.activity); // Scanner re-inicializado.
    }

    @Override
    public void onDetachedFromActivity() {
        this.activity = null;
        if (gertecScanner != null) {
            gertecScanner.dispose(); // Dispose scanner corretamente
        }
        this.gertecScanner = null;
    }
}
