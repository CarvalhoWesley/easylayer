package com.tiagomlbrasil.easylayer.easylayer;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.EventChannel;

public class GertecScanner {
    private Activity activity;
    private CodeScanner codeScanner;

    public interface Callback {
        void onCodeScanned(String value);
    }

    GertecScanner(Activity activity) {
        this.activity = activity;
        this.codeScanner = CodeScanner.getInstance(this.activity);
    }

    // Método para registrar o EventSink
    public void setEventSink(EventChannel.EventSink eventSink) {
        codeScanner.setEventSink(eventSink);
    }

    public void startScanner(){
        codeScanner.scanCode(this.activity);
    }

    public void stopScanner(){
        codeScanner.stopService();
    }

    public void dispose() {
        if (codeScanner != null) {
            codeScanner.stopService(); // Certifique-se de parar o scanner
        }
    }

}
