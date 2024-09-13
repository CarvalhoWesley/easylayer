import 'package:flutter/services.dart';

import 'barcode_format.dart';
import 'cut_type.dart';
import 'print_config.dart';
import 'status.dart';
import 'table_alignment.dart';
import 'text_format.dart';

abstract class IPrinter {
  /// Corresponds to either of these methods, depending on the provided parameters:
  ///
  /// ```Java
  /// public int printText(
  ///   int offset,
  ///   TextFormat textFormat,
  ///   @NonNull String text
  /// )
  ///
  /// public int printText(
  ///   TextFormat textFormat,
  ///   @NonNull String text
  /// )
  ///
  /// public int printText(
  ///   @NonNull String text
  /// )
  /// ```
  Future<int> printText({
    int? offset,
    TextFormat? textFormat,
    required String text,
  });

  /// Corresponds to either of these methods, depending on the provided parameters:
  ///
  /// ```Java
  /// public int printImage(
  ///   int offset,
  ///   PrintConfig printConfig,
  ///   @NonNull Bitmap image
  /// )
  ///
  /// public int printImage(
  ///   PrintConfig printConfig,
  ///   @NonNull Bitmap image
  /// )
  ///
  /// public int printImageAutoResize(
  ///   @NonNull Bitmap image
  /// )
  /// ```
  Future<int> printImage({
    int? offset,
    PrintConfig? printConfig,
    required Uint8List image,
  });

  /// Corresponds to either of these methods, depending on the provided parameters:
  ///
  /// ```Java
  /// public int printHtml(
  ///   @NonNull Context context,
  ///   PrintConfig printConfig,
  ///   @NonNull String htmlCode,
  ///   @NonNull Boolean hasAssetsLoading
  /// )
  ///
  /// public int printHtml(
  ///   @NonNull Context context,
  ///   @NonNull String htmlCode
  /// )
  /// ```
  Future<int> printHtml({
    int? offset,
    PrintConfig? printConfig,
    bool? hasAssetsLoading,
    required String htmlCode,
  });

  /// Corresponds to either of these methods, depending on the provided parameters:
  ///
  /// ```Java
  /// public int printTable(
  ///   @NonNull Context context,
  ///   TableFormat tableFormat,
  ///   List<String> header,
  ///   List<List<String>> rows
  /// )
  ///
  /// public int printTable(
  ///   @NonNull Context context,
  ///   List<List<String>> rows
  /// )
  ///
  /// public int printTable(
  ///   @NonNull Context context,
  ///   List<String> header,
  ///   List<List<String>> rows
  /// )
  /// ```
  Future<int> printTable({
    TableFormat? tableFormat,
    List<String>? header,
    required List<List<String>> rows,
  });

  /// Corresponds to:
  ///
  /// ```Java
  /// public int scrollPaper(
  ///   int lines
  /// )
  /// ```
  Future<int> scrollPaper({
    required int lines,
  });

  /// Corresponds to:
  ///
  /// ```Java
  /// public int printBarcode(
  ///   @NonNull BarcodeFormat barcodeFormat,
  ///   @NonNull String data
  /// )
  /// ```
  Future<int> printBarcode({
    required BarcodeFormat barcodeFormat,
    required String data,
  });

  /// Corresponds to:
  ///
  /// ```Java
  /// public Status getStatus()
  /// ```
  Future<Status> getStatus();

  /// Corresponds to:
  ///
  /// ```Java
  /// public int cutPaper(
  ///   CutType cutType
  /// )
  /// ```
  Future<int> cutPaper({
    required CutType cutType,
  });
}
