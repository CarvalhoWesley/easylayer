import 'package:flutter/services.dart';

import '../easylayer.dart';

class PrinterMethodChannel implements IPrinter {
  final MethodChannel methodChannel;

  const PrinterMethodChannel(
    this.methodChannel,
  );

  @override
  Future<int> printText({
    int? offset,
    TextFormat? textFormat,
    required String text,
  }) async {
    if (offset != null && textFormat == null) {
      throw ArgumentError(
          'If "offset" is not null, "textFormat" cannot be null.');
    }

    final requestId = await methodChannel.invokeMethod<int>(
      'PRINT_TEXT',
      {
        if (offset != null) 'offset': offset,
        if (textFormat != null) 'text_format': textFormat.toMap(),
        'text': text,
      },
    );

    return requestId!;
  }

  @override
  Future<int> printImage({
    int? offset,
    PrintConfig? printConfig,
    required Uint8List image,
  }) async {
    if (offset != null && printConfig == null) {
      throw ArgumentError(
          'If "offset" is not null, "printConfig" cannot be null.');
    }

    final requestId = await methodChannel.invokeMethod<int>(
      'PRINT_IMAGE',
      {
        if (offset != null) 'offset': offset,
        if (printConfig != null) 'print_config': printConfig.toMap(),
        'image': image,
      },
    );

    return requestId!;
  }

  @override
  Future<int> printHtml({
    int? offset,
    PrintConfig? printConfig,
    bool? hasAssetsLoading,
    required String htmlCode,
  }) async {
    if ((printConfig == null) != (hasAssetsLoading == null)) {
      throw ArgumentError(
          'Both "printConfig" and "hasAssetsLoaded" must be provided or ommited at the same time.');
    }

    final requestId = await methodChannel.invokeMethod<int>(
      'PRINT_HTML',
      {
        if (offset != null) 'offset': offset,
        if (printConfig != null) 'print_config': printConfig.toMap(),
        if (hasAssetsLoading != null) 'has_assets_loading': hasAssetsLoading,
        'html_code': htmlCode,
      },
    );

    return requestId!;
  }

  @override
  Future<int> printTable({
    TableFormat? tableFormat,
    List<String>? header,
    required List<List<String>> rows,
  }) async {
    final requestId = await methodChannel.invokeMethod<int>(
      'PRINT_TABLE',
      {
        if (tableFormat != null) 'table_format': tableFormat.toMap(),
        if (header != null) 'header': header,
        'rows': rows,
      },
    );

    return requestId!;
  }

  @override
  Future<int> scrollPaper({
    required int lines,
  }) async {
    final requestId = await methodChannel.invokeMethod<int>(
      'SCROLL_PAPER',
      {
        'lines': lines,
      },
    );

    return requestId!;
  }

  @override
  Future<int> printBarcode({
    required BarcodeFormat barcodeFormat,
    required String data,
  }) async {
    final requestId = await methodChannel.invokeMethod<int>(
      'PRINT_BARCODE',
      {
        'barcode_format': barcodeFormat.toMap(),
        'data': data,
      },
    );

    return requestId!;
  }

  @override
  Future<Status> getStatus() async {
    final statusRaw = await methodChannel.invokeMethod<String>(
      'GET_STATUS',
    );

    return Status.parse(statusRaw!);
  }

  @override
  Future<int> cutPaper({
    required CutType cutType,
  }) async {
    final requestId = await methodChannel.invokeMethod<int>(
      'CUT_PAPER',
      {
        'cut_type': cutType.toString(),
      },
    );

    return requestId!;
  }
}
