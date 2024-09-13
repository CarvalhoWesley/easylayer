import 'package:easylayer/easylayer.dart';
import 'package:easylayer/easylayer_platform_interface.dart';

export 'src/alignment.dart';
export 'src/barcode_format.dart';
export 'src/barcode_type.dart';
export 'src/cut_type.dart';
export 'src/orientation_type.dart';
export 'src/print_config.dart';
export 'src/printer.dart';
export 'src/size.dart';
export 'src/status.dart';
export 'src/table_alignment.dart';
export 'src/text_format.dart';

class Easylayer {
  static IPrinter printer = EasylayerPlatform.instance.printer;
}
