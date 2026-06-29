import 'dart:io';

import 'package:seo_generator/seo_generator.dart';

final class SitemapTargetWriter implements TargetWriter {
  SitemapTargetWriter(this.outputDirectory, this.locale);

  final String outputDirectory;

  final String locale;

  final List<String> _urls = [];

  @override
  TargetType get type => TargetType.sitemap;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void build(WriteRequest request) {
    _urls.add(request.value.toString());
  }

  @override
  void write() async {
    final value = '''
<?xml version="1.0" encoding="UTF-8"?>
<urlset>
${_urls.map((u) => '<url><loc>$u</loc></url>').join()}
</urlset>
''';
    final sitemapFile = File('$outputDirectory/$locale/sitemap.xml');
    await sitemapFile.create(recursive: true);
    await sitemapFile.writeAsString(value);
  }
}
