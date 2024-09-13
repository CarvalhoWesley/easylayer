import 'package:easylayer/easylayer.dart';
import 'package:flutter/material.dart' hide Size, Alignment;
import 'package:flutter/services.dart' hide Size;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final printer = Easylayer.printer;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyLayer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF027DFD),
          brightness: Brightness.light,
          primary: const Color(0xFF027DFD),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            // printText
            // printImage
            // printHtml
            // printTable
            // printBarcode
            // scrollPaper
            // cutPaper
            // getStatus
            // <comprehensive example>
            children: [
              Button(
                iconData: Icons.receipt_outlined,
                title: 'Imprimir texto (printText)',
                body: 'Imprime uma mensagem de texto pré-definida.',
                onTap: () async {
                  await printer.printText(
                    text: 'Está é uma mensagem de texto pré-definida!',
                  );
                },
              ),
              Button(
                iconData: Icons.image_outlined,
                title: 'Imprimir imagem (printImage)',
                body: 'Imprime uma imagem pré-definida.',
                onTap: () async {
                  final byteData = await rootBundle.load(
                    'assets/images/nico.jpg',
                  );

                  final image = byteData.buffer.asUint8List();

                  await printer.printImage(
                    image: image,
                  );
                },
              ),
              Button(
                iconData: Icons.html_outlined,
                title: 'Imprimir HTML (printHtml)',
                body: 'Imprime um conteúdo HTML pré-definido.',
                onTap: () async {
                  const htmlCode = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quick Test Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        #output {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>

    <h1>Test Page</h1>

    <label for="inputText">Enter something:</label>
    <input type="text" id="inputText" placeholder="Type here...">
    <button onclick="displayText()">Submit</button>

    <div id="output"></div>

    <script>
        function displayText() {
            var input = document.getElementById("inputText").value;
            document.getElementById("output").innerText = input ? "You entered: " + input : "Please enter something!";
        }
    </script>

</body>
</html>
''';
                  await printer.printHtml(
                    htmlCode: htmlCode,
                  );
                },
              ),
              Button(
                iconData: Icons.table_rows_outlined,
                title: 'Imprimir tabela (printTable)',
                body: 'Imprime uma tabela pré-definida.',
                onTap: () async {
                  await printer.printTable(
                    header: [
                      'Show',
                      'Airing Period',
                      'IMDb Rating',
                      'Rotten Tomatoes',
                      'Letterboxd'
                    ],
                    rows: [
                      [
                        'Breaking Bad',
                        '2008-2013',
                        '9.5 IMDb',
                        '96% RT',
                        '4.6 LB'
                      ],
                      [
                        'The Sopranos',
                        '1999-2007',
                        '9.2 IMDb',
                        '92% RT',
                        '4.5 LB'
                      ],
                      [
                        'Better Call Saul',
                        '2015-2022',
                        '8.9 IMDb',
                        '98% RT',
                        '4.4 LB'
                      ],
                      [
                        'Stranger Things',
                        '2016-',
                        '8.7 IMDb',
                        '91% RT',
                        '4.3 LB'
                      ],
                    ],
                  );
                },
              ),
              Button(
                iconData: Icons.move_down_outlined,
                title: 'Rolar o papel de impressão (scrollPaper)',
                body: 'Rola em uma linha o papel de impressão.',
                onTap: () async {
                  await printer.scrollPaper(
                    lines: 1,
                  );
                },
              ),
              Button(
                iconData: Icons.cut_outlined,
                title: 'Cortar o papel de impressão',
                body: 'Realiza o corte do papel de impressão.',
                onTap: () async {
                  await printer.cutPaper(
                    cutType: CutType.PAPER_FULL_CUT,
                  );
                },
              ),
              Builder(builder: (context) {
                return Button(
                  iconData: Icons.settings_outlined,
                  title: 'Ver status',
                  body: 'Exibe o status atual da impressora',
                  onTap: () async {
                    final status = await printer.getStatus();

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            status.toString(),
                          ),
                        ),
                      );
                    }
                  },
                );
              }),
              Button(
                iconData: Icons.receipt_long_outlined,
                title: 'Imprimir exemplo',
                body:
                    'Imprime um extenso exemplo das funcionalidades da biblioteca/impressora.',
                onTap: () async {
                  await printer.printText(
                    text: 'Este é um texto simples.',
                  );

                  await printer.printText(
                    offset: 20,
                    textFormat: const TextFormat(),
                    text: 'Este é um texto simples com offset de 20.',
                  );

                  await printer.printText(
                    text: 'Este é um texto em negrito.',
                    textFormat: const TextFormat(
                      bold: true,
                    ),
                  );

                  await printer.printText(
                    text: 'Este é um texto em itálico.',
                    textFormat: const TextFormat(
                      italic: true,
                    ),
                  );

                  await printer.printText(
                    text: 'Este é um texto com underline.',
                    textFormat: const TextFormat(
                      underscore: true,
                    ),
                  );

                  await printer.printText(
                    text:
                        'Este é um texto com em negrito e itálico com underline.',
                    textFormat: const TextFormat(
                      bold: true,
                      italic: true,
                      underscore: true,
                    ),
                  );

                  await printer.printText(
                    text: 'Este é um texto pequeno alinhado à esquerda.',
                    textFormat: const TextFormat(
                      fontSize: 16,
                      alignment: Alignment.LEFT,
                    ),
                  );

                  await printer.printText(
                    text: 'Este é um texto médio alinhado ao centro.',
                    textFormat: const TextFormat(
                      fontSize: 20,
                      alignment: Alignment.CENTER,
                    ),
                  );

                  await printer.printText(
                    text: 'Este é um texto grande alinhado à direita.',
                    textFormat: const TextFormat(
                      fontSize: 24,
                      alignment: Alignment.RIGHT,
                    ),
                  );

                  //

                  await printer.scrollPaper(lines: 3);

                  //

                  final byteData = await rootBundle.load(
                    'assets/images/nico.jpg',
                  );

                  final image = byteData.buffer.asUint8List();

                  await printer.printImage(
                    image: image,
                  );

                  await printer.printImage(
                    printConfig: const PrintConfig(
                      width: 200,
                      height: 200,
                    ),
                    image: image,
                  );

                  await printer.printImage(
                    offset: 50,
                    printConfig: const PrintConfig(
                      width: 200,
                      height: 200,
                    ),
                    image: image,
                  );

                  //

                  await printer.scrollPaper(lines: 3);

                  //

                  const htmlCode = '''
<!DOCTYPE html>
<html>
<head>
    <title>Test Page</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>This is a test page.</p>
</body>
</html>''';

                  await printer.printHtml(
                    htmlCode: htmlCode,
                  );

                  await printer.printHtml(
                    printConfig: const PrintConfig(
                      width: 200,
                      height: 200,
                    ),
                    hasAssetsLoading: false,
                    htmlCode: htmlCode,
                  );

                  await printer.printHtml(
                    offset: 50,
                    printConfig: const PrintConfig(
                      width: 200,
                      height: 200,
                    ),
                    hasAssetsLoading: false,
                    htmlCode: htmlCode,
                  );

                  //

                  await printer.scrollPaper(lines: 3);

                  //

                  final header = <String>[
                    'Show',
                    'Airing Period',
                    'IMDb Rating',
                    'Rotten Tomatoes',
                    'Letterboxd'
                  ];

                  final rows = [
                    [
                      'Breaking Bad',
                      '2008-2013',
                      '9.5 IMDb',
                      '96% RT',
                      '4.6 LB'
                    ],
                    [
                      'The Sopranos',
                      '1999-2007',
                      '9.2 IMDb',
                      '92% RT',
                      '4.5 LB'
                    ],
                    [
                      'Better Call Saul',
                      '2015-2022',
                      '8.9 IMDb',
                      '98% RT',
                      '4.4 LB'
                    ],
                    [
                      'Stranger Things',
                      '2016-',
                      '8.7 IMDb',
                      '91% RT',
                      '4.3 LB'
                    ],
                  ];

                  await printer.printTable(
                    rows: rows,
                  );

                  await printer.printTable(
                    header: header,
                    rows: rows,
                  );

                  await printer.printTable(
                    tableFormat: const TableFormat(
                      headerAlignment: Alignment.CENTER,
                      rowAlignment: Alignment.RIGHT,
                      fontSize: 8,
                    ),
                    header: header,
                    rows: rows,
                  );

                  //

                  await printer.scrollPaper(lines: 3);

                  const lipsum =
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

                  await printer.printText(
                    text: 'QR_CODE',
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.QR_CODE,
                    ),
                    data: lipsum,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.QR_CODE,
                      size: Size.SMALL,
                    ),
                    data: lipsum,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.QR_CODE,
                      size: Size.HALF_PAPER,
                    ),
                    data: lipsum,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.QR_CODE,
                      size: Size.FULL_PAPER,
                    ),
                    data: lipsum,
                  );

                  //

                  await printer.scrollPaper(lines: 1);

                  //

                  const ean8 = '12345678';

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.EAN_8,
                    ),
                    data: ean8,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.EAN_8,
                      size: Size.SMALL,
                    ),
                    data: ean8,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.EAN_8,
                      size: Size.HALF_PAPER,
                    ),
                    data: ean8,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.EAN_8,
                      size: Size.FULL_PAPER,
                    ),
                    data: ean8,
                  );

                  //

                  await printer.scrollPaper(lines: 1);

                  //

                  const ean13 = '7891000315507';

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.EAN_13,
                    ),
                    data: ean13,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.EAN_13,
                      size: Size.SMALL,
                    ),
                    data: ean13,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.EAN_13,
                      size: Size.HALF_PAPER,
                    ),
                    data: ean13,
                  );

                  await printer.printBarcode(
                    barcodeFormat: const BarcodeFormat(
                      barcodeType: BarcodeType.EAN_13,
                      size: Size.FULL_PAPER,
                    ),
                    data: ean13,
                  );

                  //

                  await printer.scrollPaper(lines: 1);

                  await printer.cutPaper(cutType: CutType.PAPER_FULL_CUT);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final IconData? iconData;
  final String title;
  final String? body;
  final void Function()? onTap;
  final double spacer;

  const Button({
    super.key,
    this.iconData,
    required this.title,
    this.body,
    this.onTap,
    this.spacer = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(spacer),
        child: Row(
          children: [
            if (iconData != null) ...[
              Icon(
                iconData,
              ),
              SizedBox(width: spacer),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (body is String) ...[
                    Text(
                      body!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
