package com.tiagomlbrasil.easylayer.easylayer;

import android.content.Context;

import java.io.ByteArrayInputStream;
import java.util.Map;
import java.util.List;
import androidx.appcompat.app.AppCompatActivity;
import br.com.gertec.easylayer.codescanner.CodeScanner;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GertecScanner extends AppCompatActivity {
    private final Context context;
    private CodeScanner codeScanner;
    public final MethodChannel.MethodCallHandler handler;

    GertecScanner(Context context) {
        this.context = context;
        this.codeScanner = CodeScanner.getInstance(this.context);
        this.handler = this::_handler;
    }

    private void _handler(MethodCall call, MethodChannel.Result result) {
        try {
            switch (call.method) {
                default:
                    result.notImplemented();

                case "START_SCANNER": {
                    codeScanner.scanCode(this);
                    break;
                }

                case "STOP_SCANNER": {
                    codeScanner.stopService();
                    break;
                }
            }
        } catch (PrinterException e) {
            result.error(e.getMessage() == null ? "" : e.getMessage(), null, null);
        }
    }

    public void dispose() {
        codeScanner.stopService();
    }
}
