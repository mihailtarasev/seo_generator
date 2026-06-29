import 'dart:convert';
import 'dart:io';

import 'package:seo_generator/seo_generator.dart';
import 'package:seo_generator/src/target/writers/html_target_writer.dart';
import 'package:seo_generator/src/target/writers/jsonld_target_writer.dart';
import 'package:seo_generator/src/target/writers/robots_target_writer.dart';
import 'package:seo_generator/src/target/writers/sitemap_target_writer.dart';

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
      final jsonld = JsonLdTargetWriter();
      final sitemap = SitemapTargetWriter();
      final robots = RobotsTargetWriter();

      final engine = SchemaEngine(
        sourceResolver: SourceResolver([
          ArbProvider(arb),
        ]),
        validator: Validator(),
        targetRegistry: TargetRegistry([
          HtmlTargetWriter(html),
          jsonld,
          sitemap,
          robots,
        ]),
      );

      engine.execute(schema);

      final output = File('$outputDirectory/$locale/index.html');
      await output.create(recursive: true);

      final toHtml = html.toHtml();
      final jsonldToHtml = jsonld.build();
      final finalHtml = toHtml.replaceFirst('</head>', jsonldToHtml);

      await output.writeAsString(finalHtml);

      // Sitemap
      final sitemapFile = File('$outputDirectory/$locale/sitemap.xml');
      await sitemapFile.create(recursive: true);
      await sitemapFile.writeAsString(sitemap.build());

      // Robots
      final robotsFile = File('$outputDirectory/robots.txt');
      await robotsFile.create(recursive: true);
      await robotsFile.writeAsString(robots.build());
    }
  }

  Future<Map<String, Map<String, dynamic>>> _loadArbFiles() async {
    final dir = Directory(arbDirectory);

    final files =
        await dir.list().where((f) => f.path.endsWith('.arb')).toList();

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
