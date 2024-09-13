package com.tiagomlbrasil.easylayer.easylayer;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import java.io.ByteArrayInputStream;
import java.util.Map;
import java.util.List;

import br.com.gertec.easylayer.printer.Alignment;
import br.com.gertec.easylayer.printer.BarcodeFormat;
import br.com.gertec.easylayer.printer.BarcodeType;
import br.com.gertec.easylayer.printer.CutType;
import br.com.gertec.easylayer.printer.PrintConfig;
import br.com.gertec.easylayer.printer.Printer;
import br.com.gertec.easylayer.printer.PrinterError;
import br.com.gertec.easylayer.printer.PrinterException;
import br.com.gertec.easylayer.printer.TableFormat;
import br.com.gertec.easylayer.printer.TextFormat;

import br.com.gertec.easylayer.utils.Status;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GertecPrinter implements Printer.Listener {
    private final Context context;
    private final Printer printer;
    public final MethodChannel.MethodCallHandler handler;

    GertecPrinter(Context context) {
        this.context = context;
        this.printer = Printer.getInstance(context, this);
        this.handler = this::_handler;
    }

    private void _handler(MethodCall call, MethodChannel.Result result) {
        try {
            switch (call.method) {
                default:
                    result.notImplemented();

                case "PRINT_TEXT": {
                    // Parse arguments.

                    // offset

                    Integer offset = call.argument("offset");

                    // textFormat

                    TextFormat textFormat = null;

                    Map<String, Object> textFormatMap = call.argument("text_format");

                    if (textFormatMap != null) {
                        textFormat = new TextFormat();

                        // textFormat.bold

                        Object bold = textFormatMap.get("bold");

                        if (bold instanceof Boolean) {
                            textFormat.setBold((Boolean) bold);
                        }

                        // textFormat.italic

                        Object italic = textFormatMap.get("italic");

                        if (italic instanceof Boolean) {
                            textFormat.setItalic((Boolean) italic);
                        }

                        // textFormat.underscore

                        Object underscore = textFormatMap.get("underscore");

                        if (underscore instanceof Boolean) {
                            textFormat.setUnderscore((Boolean) underscore);
                        }

                        // textFormat.fontSize

                        Object fontSize = textFormatMap.get("font_size");

                        if (fontSize instanceof Integer) {
                            textFormat.setFontSize((Integer) fontSize);
                        }

                        // textFormat.lineSpacing

                        Object lineSpacing = textFormatMap.get("line_spacing");

                        if (lineSpacing instanceof Integer) {
                            textFormat.setLineSpacing((Integer) lineSpacing);
                        }

                        // textFormat.alignment

                        Alignment alignment = null;

                        Object alignmentRaw = textFormatMap.get("alignment");

                        if (alignmentRaw instanceof String) {
                            switch ((String) alignmentRaw) {
                                case "LEFT":
                                    alignment = Alignment.LEFT;
                                    break;
                                case "CENTER":
                                    alignment = Alignment.CENTER;
                                    break;
                                case "RIGHT":
                                    alignment = Alignment.RIGHT;
                                    break;
                                default:
                                    throw new IllegalArgumentException("Invalid alignment: " + alignmentRaw);
                            }
                        }

                        if (alignment != null) {
                            textFormat.setAlignment(alignment);
                        }
                    }

                    // text

                    String text = call.argument("text");

                    if (text == null) {
                        throw new IllegalArgumentException("Text cannot be null.");
                    }

                    // Call corresponding method based on arguments.

                    int requestId;

                    if (textFormat != null) {
                        if (offset != null) {
                            requestId = printer.printText(offset, textFormat, text);
                        } else {
                            requestId = printer.printText(textFormat, text);
                        }
                    } else {
                        requestId = printer.printText(text);
                    }

                    result.success(requestId);
                    break;
                }

                case "PRINT_IMAGE": {
                    // Parse arguments.

                    // offset

                    Integer offset = call.argument("offset");

                    // printConfig

                    PrintConfig printConfig = null;

                    Map<String, Object> printConfigMap = call.argument("print_config");

                    if (printConfigMap != null) {
                        printConfig = new PrintConfig();

                        // printConfig.width

                        Object width = printConfigMap.get("width");

                        if (width instanceof Integer) {
                            printConfig.setWidth((Integer) width);
                        }

                        // printConfig.height

                        Object height = printConfigMap.get("height");

                        if (height instanceof Integer) {
                            printConfig.setHeight((Integer) height);
                        }

                        // printConfig.alignment

                        Alignment alignment = null;

                        Object alignmentRaw = printConfigMap.get("alignment");

                        if (alignmentRaw instanceof String) {
                            switch ((String) alignmentRaw) {
                                case "LEFT":
                                    alignment = Alignment.LEFT;
                                    break;
                                case "CENTER":
                                    alignment = Alignment.CENTER;
                                    break;
                                case "RIGHT":
                                    alignment = Alignment.RIGHT;
                                    break;
                                default:
                                    throw new IllegalArgumentException("Invalid alignment: " + alignmentRaw);
                            }
                        }

                        if (alignment != null) {
                            printConfig.setAlignment(alignment);
                        }
                    }

                    // image

                    byte[] imageRaw = call.argument("image");

                    if (imageRaw == null) {
                        throw new IllegalArgumentException("Image cannot be null.");
                    }

                    ByteArrayInputStream inputStream = new ByteArrayInputStream(imageRaw);
                    Bitmap image = BitmapFactory.decodeStream(inputStream);

                    // Call corresponding method based on arguments.

                    int requestId;

                    if (printConfig != null) {
                        if (offset != null) {
                            requestId = printer.printImage(offset, printConfig, image);
                        } else {
                            requestId = printer.printImage(printConfig, image);
                        }
                    } else {
                        requestId = printer.printImageAutoResize(image);
                    }

                    result.success(requestId);
                    break;
                }


                case "PRINT_HTML": {
                    // Parse arguments.

                    // printConfig

                    PrintConfig printConfig = null;

                    Map<String, Object> printConfigMap = call.argument("print_config");

                    if (printConfigMap != null) {
                        printConfig = new PrintConfig();

                        // printConfig.width

                        Object width = printConfigMap.get("width");

                        if (width instanceof Integer) {
                            printConfig.setWidth((Integer) width);
                        }

                        // printConfig.height

                        Object height = printConfigMap.get("height");

                        if (height instanceof Integer) {
                            printConfig.setHeight((Integer) height);
                        }

                        // printConfig.alignment

                        Alignment alignment = null;

                        Object alignmentRaw = printConfigMap.get("alignment");

                        if (alignmentRaw instanceof String) {
                            switch ((String) alignmentRaw) {
                                case "LEFT":
                                    alignment = Alignment.LEFT;
                                    break;
                                case "CENTER":
                                    alignment = Alignment.CENTER;
                                    break;
                                case "RIGHT":
                                    alignment = Alignment.RIGHT;
                                    break;
                                default:
                                    throw new IllegalArgumentException("Invalid alignment: " + alignmentRaw);
                            }
                        }

                        if (alignment != null) {
                            printConfig.setAlignment(alignment);
                        }
                    }

                    // hasAssetsLoading

                    Boolean hasAssetsLoading = call.argument("has_assets_loading");

                    // htmlCode

                    String htmlCode = call.argument("html_code");

                    if (htmlCode == null) {
                        throw new IllegalArgumentException("Html code cannot be null.");
                    }

                    // Call corresponding method based on arguments.

                    int requestId;

                    if (printConfig != null && hasAssetsLoading != null) {
                        requestId = printer.printHtml(context, printConfig, htmlCode, hasAssetsLoading);
                    } else {
                        requestId = printer.printHtml(context, htmlCode);
                    }

                    result.success(requestId);
                    break;
                }

                case "PRINT_TABLE": {
                    // Parse arguments.

                    TableFormat tableFormat = null;

                    Map<String, Object> tableFormatMap = call.argument("table_format");

                    if (tableFormatMap != null) {
                        tableFormat = new TableFormat();

                        // tableFormat.headerAlignment

                        Alignment headerAlignment = null;

                        Object headerAlignmentRaw = tableFormatMap.get("header_alignment");

                        if (headerAlignmentRaw instanceof String) {
                            switch ((String) headerAlignmentRaw) {
                                case "LEFT":
                                    headerAlignment = Alignment.LEFT;
                                    break;
                                case "CENTER":
                                    headerAlignment = Alignment.CENTER;
                                    break;
                                case "RIGHT":
                                    headerAlignment = Alignment.RIGHT;
                                    break;
                                default:
                                    throw new IllegalArgumentException("Invalid header alignment: " + headerAlignment);
                            }
                        }

                        if (headerAlignment != null) {
                            tableFormat.setHeaderAlignment(headerAlignment);
                        }

                        // tableFormat.rowAlignment

                        Alignment rowAlignment = null;

                        Object rowAlignmentRaw = tableFormatMap.get("row_alignment");

                        if (rowAlignmentRaw instanceof String) {
                            switch ((String) rowAlignmentRaw) {
                                case "LEFT":
                                    rowAlignment = Alignment.LEFT;
                                    break;
                                case "CENTER":
                                    rowAlignment = Alignment.CENTER;
                                    break;
                                case "RIGHT":
                                    rowAlignment = Alignment.RIGHT;
                                    break;
                                default:
                                    throw new IllegalArgumentException("Invalid row alignment: " + rowAlignmentRaw);
                            }
                        }

                        if (rowAlignment != null) {
                            tableFormat.setRowAlignment(rowAlignment);
                        }

                        // tableFormat.fontSize

                        Object fontSize = tableFormatMap.get("font_size");

                        if (fontSize instanceof Integer) {
                            tableFormat.setFontSize((Integer) fontSize);
                        }
                    }

                    // header

                    List<String> header = call.argument("header");

                    // rows

                    List<List<String>> rows = call.argument("rows");

                    // Call corresponding method based on arguments.

                    int requestId;

                    if (header != null) {
                        if (tableFormat != null) {
                            requestId = printer.printTable(context, tableFormat, header, rows);
                        } else {
                            requestId = printer.printTable(context, header, rows);
                        }
                    } else {
                        requestId = printer.printTable(context, rows);
                    }

                    result.success(requestId);
                    break;
                }

                case "SCROLL_PAPER": {
                    // Parse arguments.

                    Integer lines = call.argument("lines");

                    if (lines == null) {
                        throw new IllegalArgumentException("Lines cannot be null.");
                    }

                    // Call corresponding method based on arguments.

                    int requestId;

                    requestId = printer.scrollPaper(lines);

                    result.success(requestId);
                    break;
                }

                case "PRINT_BARCODE": {
                    // Parse arguments.

                    // barcodeFormat

                    Map<String, Object> barcodeFormatMap = call.argument("barcode_format");

                    if (barcodeFormatMap == null) {
                        throw new IllegalArgumentException("Barcode format cannot be null.");
                    }

                    // barcodeFormat.barcodeType

                    BarcodeType barcodeType = null;

                    Object barcodeTypeRaw = barcodeFormatMap.get("barcode_type");

                    if (barcodeTypeRaw instanceof String) {
                        switch ((String) barcodeTypeRaw) {
                            case "AZTEC":
                                barcodeType = BarcodeType.AZTEC;
                                break;
                            case "CODABAR":
                                barcodeType = BarcodeType.CODABAR;
                                break;
                            case "CODE_39":
                                barcodeType = BarcodeType.CODE_39;
                                break;
                            case "CODE_93":
                                barcodeType = BarcodeType.CODE_93;
                                break;
                            case "CODE_128":
                                barcodeType = BarcodeType.CODE_128;
                                break;
                            case "DATA_MATRIX":
                                barcodeType = BarcodeType.DATA_MATRIX;
                                break;
                            case "EAN_8":
                                barcodeType = BarcodeType.EAN_8;
                                break;
                            case "EAN_13":
                                barcodeType = BarcodeType.EAN_13;
                                break;
                            case "ITF":
                                barcodeType = BarcodeType.ITF;
                                break;
                            case "MAXICODE":
                                barcodeType = BarcodeType.MAXICODE;
                                break;
                            case "PDF_417":
                                barcodeType = BarcodeType.PDF_417;
                                break;
                            case "QR_CODE":
                                barcodeType = BarcodeType.QR_CODE;
                                break;
                            case "RSS_14":
                                barcodeType = BarcodeType.RSS_14;
                                break;
                            case "RSS_EXPANDED":
                                barcodeType = BarcodeType.RSS_EXPANDED;
                                break;
                            case "UPC_A":
                                barcodeType = BarcodeType.UPC_A;
                                break;
                            case "UPC_E":
                                barcodeType = BarcodeType.UPC_E;
                                break;
                            case "UPC_EAN_EXTENSION":
                                barcodeType = BarcodeType.UPC_EAN_EXTENSION;
                                break;
                            default:
                                throw new IllegalArgumentException("Barcode type cannot be null.");
                        }
                    }


                    // barcodeFormat.size

                    BarcodeFormat.Size size = null;

                    Object sizeRaw = barcodeFormatMap.get("size");

                    if (sizeRaw instanceof String) {
                        switch ((String) sizeRaw) {
                            case "SMALL":
                                size = BarcodeFormat.Size.SMALL;
                                break;
                            case "HALF_PAPER":
                                size = BarcodeFormat.Size.HALF_PAPER;
                                break;
                            case "FULL_PAPER":
                                size = BarcodeFormat.Size.FULL_PAPER;
                                break;
                            default:
                                break;
                        }
                    }

                    // barcodeFormat.whiteSpace

                    Integer whiteSpace = null;

                    Object whiteSpaceRaw = barcodeFormatMap.get("white_space");

                    if (whiteSpaceRaw instanceof Integer) {
                        whiteSpace = (Integer) whiteSpaceRaw;
                    }

                    //

                    BarcodeFormat barcodeFormat = null;

                    if (size != null) {
                        if (whiteSpace != null) {
                            barcodeFormat = new BarcodeFormat(barcodeType, size, whiteSpace);
                        } else {
                            barcodeFormat = new BarcodeFormat(barcodeType, size);
                        }
                    } else {
                        barcodeFormat = new BarcodeFormat(barcodeType);
                    }

                    //

                    String data = call.argument("data");

                    if (data == null) {
                        throw new IllegalArgumentException("Data cannot be null.");
                    }

                    // Call corresponding method based on arguments.

                    int requestId;

                    requestId = printer.printBarcode(barcodeFormat, data);

                    result.success(requestId);
                    break;
                }

                case "GET_STATUS": {
                    // Call corresponding method based on arguments.

                    Status status = printer.getStatus();

                    result.success(status.toString());
                    break;
                }

                case "CUT_PAPER": {
                    // Parse arguments.
                    String cutTypeRaw = call.argument("cut_type");

                    if (cutTypeRaw == null) {
                        throw new IllegalArgumentException("Cut type cannot be null.");
                    }

                    CutType cutType;

                    switch (cutTypeRaw) {
                        case "PAPER_PARTIAL_CUT":
                            cutType = CutType.PAPER_PARTIAL_CUT;
                            break;
                        case "PAPER_FULL_CUT":
                            cutType = CutType.PAPER_FULL_CUT;
                            break;
                        default:
                            throw new IllegalArgumentException("Invalid cut type: " + cutTypeRaw);
                    }

                    // Call corresponding method based on arguments.

                    int requestId;

                    requestId = printer.cutPaper(cutType);

                    result.success(requestId);
                    break;
                }
            }
        } catch (PrinterException e) {
            result.error(e.getMessage() == null ? "" : e.getMessage(), null, null);
        }
    }


    @Override
    public void onPrinterError(PrinterError printerError) {
        // TODO: Implement
    }

    @Override
    public void onPrinterSuccessful(int i) {
        // TODO: Implement
    }
}
