package com.tiagomlbrasil.easylayer.easylayer;

import android.app.Activity;
import br.com.gertec.easylayer.codescanner.CodeScanner;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GertecScanner {
    private Activity activity;
    private CodeScanner codeScanner;

    GertecScanner(Activity activity) {
        this.activity = activity;
        this.codeScanner = CodeScanner.getInstance(this.activity);
    }

    public void startScanner(MethodCall call, MethodChannel.Result result){
        codeScanner.scanCode(this.activity);
    }

    public void stopScanner(MethodCall call, MethodChannel.Result result){
        codeScanner.stopService();
    }

    public void dispose() {
        if (codeScanner != null) {
            codeScanner.stopService(); // Certifique-se de parar o scanner
            codeScanner = null; // Liberar referência
        }
    }

}
