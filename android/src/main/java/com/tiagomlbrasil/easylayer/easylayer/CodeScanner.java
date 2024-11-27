//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package com.tiagomlbrasil.easylayer.easylayer;

import android.app.Activity;
import android.os.Build;
import android.os.Looper;
import android.os.Handler;
import android.os.RemoteException;
import androidx.annotation.NonNull;

import br.com.gertec.easylayer.codescanner.ScanConfig;
import br.com.gertec.easylayer.printer.DeviceServiceManager;
import com.topwise.cloudpos.aidl.camera.AidlCameraScanCode;
import com.topwise.cloudpos.aidl.camera.AidlDecodeCallBack;
import com.topwise.cloudpos.aidl.camera.DecodeMode;
import com.topwise.cloudpos.aidl.camera.DecodeParameter;
import com.topwise.cloudpos.aidl.system.AidlSystem;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.EventChannel;

public class CodeScanner {
    public static final String QR_CODE = "QR_CODE";
    public static final String AZTEC = "AZTEC";
    public static final String DATA_MATRIX = "DATA_MATRIX";
    public static final String MAXICODE = "MAXICODE";
    public static final String PDF_417 = "PDF_417";
    public static final String CODABAR = "CODABAR";
    public static final String CODE_39 = "CODE_39";
    public static final String CODE_93 = "CODE_93";
    public static final String CODE_128 = "CODE_128";
    public static final String EAN_8 = "EAN_8";
    public static final String EAN_13 = "EAN_13";
    public static final String ITF = "ITF";
    public static final String RSS_14 = "RSS_14";
    public static final String RSS_EXPANDED = "RSS_EXPANDED";
    public static final String UPC_A = "UPC_A";
    public static final String UPC_E = "UPC_E";
    public static final String UPC_EAN_EXTENSION = "UPC_EAN_EXTENSION";
    public static final String ALL_CODE_TYPES = null;
    public static final Collection<String> SCAN_1D = Arrays.asList("UPC_A", "UPC_E", "EAN_8", "EAN_13", "RSS_14", "CODE_39", "CODE_93", "CODE_128", "ITF", "RSS_14", "RSS_EXPANDED", "CODABAR");
    public static final Collection<String> SCAN_2D = Arrays.asList("AZTEC", "QR_CODE", "DATA_MATRIX", "MAXICODE", "PDF_417");
    
    private ScanConfig scanConfig;
    private static AidlCameraScanCode mDecodeManager;
    private AidlSystem sytem;
    public static final int ON = 1;
    public static final int OFF = 0;
    private Collection<String> codeTypes;
    private static CodeScanner INSTANCE = null;
    private EventChannel.EventSink eventSink; // EventSink para enviar eventos ao Flutter

    public static CodeScanner getInstance(Activity activity) {
        if (INSTANCE == null && Build.MANUFACTURER.equals("Gertec")) {
            INSTANCE = new CodeScanner(activity);
        }

        return INSTANCE;
    }

    private CodeScanner(Activity activity) {
        mDecodeManager = DeviceServiceManager.getInstance(activity).getCameraManager();
        this.clearBufferCodeBar();
    }

    // Método para registrar o EventSink
    public void setEventSink(EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
    }

    public void scanCode(@NonNull Activity activity) {
        mDecodeManager = DeviceServiceManager.getInstance(activity).getCameraManager();
        this.clearBufferCodeBar();
        this.codeTypes.add((String) null);
        this.startCodeScanner(activity);
    }

    public void scanCode(@NonNull Activity activity, @NonNull String type) {
        mDecodeManager = DeviceServiceManager.getInstance(activity).getCameraManager();
        this.clearBufferCodeBar();
        this.codeTypes.add(type);
        this.startCodeScanner(activity);
    }

    public void scanCode(@NonNull Activity activity, Collection<String> types) {
        mDecodeManager = DeviceServiceManager.getInstance(activity).getCameraManager();
        this.clearBufferCodeBar();
        this.codeTypes = types;
        this.startCodeScanner(activity);
    }

    public void scanCode(@NonNull Activity activity, @NonNull ScanConfig scanConfig, @NonNull String type) {
        mDecodeManager = DeviceServiceManager.getInstance(activity).getCameraManager();
        this.clearBufferCodeBar();
        this.codeTypes.add(type);
        this.scanConfig = scanConfig;
        this.startCodeScanner(activity);
    }

    public void scanCode(@NonNull Activity activity, @NonNull ScanConfig scanConfig, @NonNull Collection<String> types) {
        mDecodeManager = DeviceServiceManager.getInstance(activity).getCameraManager();
        this.clearBufferCodeBar();
        this.codeTypes = types;
        this.scanConfig = scanConfig;
        this.startCodeScanner(activity);
    }

    public void stopService() {
        try {
            mDecodeManager.stopDecode();
        } catch (RemoteException var2) {
            RemoteException e = var2;
            throw new RuntimeException(e);
        }
    }

    private void startCodeScanner(final Activity activity) {
        try {
            ArrayList<String> codeType = new ArrayList();
            codeType.add("QRCODE");
            DecodeParameter decodeParameter = new DecodeParameter();
            decodeParameter.setDecodeMode(DecodeMode.MODE_CONTINUE_SCAN_CODE).setDecodeIntervalTime(1000).setFlashLightTimeout(5500).setNoSupportCodeTypeList(codeType).setAutoDetect(1);
            
            mDecodeManager.startDecode(decodeParameter, new AidlDecodeCallBack.Stub() {
                public void onResult(String s) throws RemoteException {
                    if (s != null) {
                        // Envia o código escaneado para o Flutter na thread principal
                        new Handler(Looper.getMainLooper()).post(new Runnable() {
                            @Override
                            public void run() {
                                if (eventSink != null) {
                                    eventSink.success(s); // Envia o resultado de volta para o Flutter
                                }
                            }
                        });
                    }

                }

                public void onError(int i) throws RemoteException {
                    // Envia o erro para o Flutter na thread principal
                    new Handler(Looper.getMainLooper()).post(new Runnable() {
                        @Override
                        public void run() {
                            if (eventSink != null) {
                                eventSink.error("SCAN_ERROR", "Scanning failed", null); // Envia erro ao Flutter
                            }
                        }
                    });
                }
            });
        } catch (RemoteException var4) {
            RemoteException e = var4;
            e.printStackTrace();
            // Envia o erro na thread principal
            new Handler(Looper.getMainLooper()).post(new Runnable() {
                @Override
                public void run() {
                    if (eventSink != null) {
                        eventSink.error("SCAN_ERROR", "An error occurred while scanning", null);
                    }
                }
            });
        }

    }

    private void clearBufferCodeBar() {
        this.codeTypes = new ArrayList();
        this.scanConfig = new ScanConfig();
    }
}
