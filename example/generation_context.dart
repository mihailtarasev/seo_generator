import 'dart:convert';
import 'dart:io';

import 'package:seo_generator/seo_generator.dart';
import 'package:seo_generator/src/target/writers/html_target_writer.dart';

final class GenerationContext {
  final String schemaPath;
  final String templatePath;
  final String arbDirectory;
  final String outputDirectory;

  const GenerationContext({
    required this.schemaPath,
    required this.templatePath,
    required this.arbDirectory,
    required this.outputDirectory,
  });

  Future<void> generate() async {
    final schema = await const SchemaLoader().fromFile(schemaPath);
    final template = await File(templatePath).readAsString();

    final arbFiles = await _loadArbFiles();

    for (final entry in arbFiles.entries) {
      final locale = entry.key;
      final arb = entry.value;

      final html = HtmlEditor.fromString(template);

      final engine = SchemaEngine(
        sourceResolver: SourceResolver([
          ArbProvider(arb),
        ]),
        validator: Validator(),
        targetRegistry: TargetRegistry([
          HtmlTargetWriter(html),
        ]),
      );

      engine.execute(schema);

      final output = File('$outputDirectory/$locale/index.html');
      await output.create(recursive: true);

      await output.writeAsString(html.toHtml());
    }
  }

  Future<Map<String, Map<String, dynamic>>> _loadArbFiles() async {
    final dir = Directory(arbDirectory);

    final files = await dir
        .list()
        .where((f) => f.path.endsWith('.arb'))
        .toList();

    final result = <String, Map<String, dynamic>>{};

    for (final file in files) {
      final name = file.uri.pathSegments.last;
      final locale = name.replaceAll('app_', '').replaceAll('.arb', '');

      final content = await File(file.path).readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;

      result[locale] = json;
    }

    return result;
  }
}