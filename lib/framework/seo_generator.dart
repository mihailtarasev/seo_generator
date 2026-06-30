import 'dart:convert';
import 'dart:io';

import 'package:seo_generator/seo_generator.dart';
import 'package:seo_generator/src/target/writers/alternate_target_writer.dart';
import 'package:seo_generator/src/target/writers/html_target_writer.dart';
import 'package:seo_generator/src/target/writers/jsonld_target_writer.dart';
import 'package:seo_generator/src/target/writers/og_alternate_target_writer.dart';
import 'package:seo_generator/src/target/writers/robots_target_writer.dart';
import 'package:seo_generator/src/target/writers/sitemap_target_writer.dart';

final class GenerationContext {
  final String schemaPath;
  final String templatePath;
  final String configPath;
  final String localeDirectory;
  final String localeFormat;
  final String outputDirectory;

  const GenerationContext({
    required this.schemaPath,
    required this.templatePath,
    required this.configPath,
    required this.localeDirectory,
    required this.localeFormat,
    required this.outputDirectory,
  });

  Future<void> generate() async {
    final schema = await const SchemaLoader().fromFile(schemaPath);
    final template = await File(templatePath).readAsString();

    final localeFiles = await _loadLocaleFiles(localeFormat);
    final config = await _loadConfig();

    for (final entry in localeFiles.entries) {
      final locale = entry.key;
      final value = entry.value;

      final html = HtmlEditor.fromString(template);

      final engine = SchemaEngine(
        sourceResolver: SourceResolver([
          LocaleProvider(value),
          ConfigProvider(config),
        ]),
        validator: Validator(),
        targetRegistry: TargetRegistry([
          HtmlTargetWriter(html),
          JsonLdTargetWriter(html),
          AlternateTargetWriter(html),
          SitemapTargetWriter(outputDirectory, locale),
          RobotsTargetWriter(outputDirectory),
          OgAlternateTargetWriter(html),
        ]),
      );

      engine.execute(schema);

      final output = File('$outputDirectory/$locale/index.html');
      await output.create(recursive: true);

      final finalHtml = html.toHtml();
      await output.writeAsString(finalHtml);
    }
  }

  Future<Map<String, dynamic>> _loadConfig() async {
    final file = File(configPath);
    final content = await File(file.path).readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return json;
  }

  Future<Map<String, Map<String, dynamic>>> _loadLocaleFiles(
      String localeFormat) async {
    final dir = Directory(localeDirectory);

    final files =
        await dir.list().where((f) => f.path.endsWith(localeFormat)).toList();

    final result = <String, Map<String, dynamic>>{};

    for (final file in files) {
      final name = file.uri.pathSegments.last;
      final locale = name.replaceAll('app_', '').replaceAll(localeFormat, '');

      final content = await File(file.path).readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;

      result[locale] = json;
    }

    return result;
  }
}
