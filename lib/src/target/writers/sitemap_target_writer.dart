import 'dart:io';

import 'package:seo_generator/seo_generator.dart';
import 'package:seo_generator/src/model/sitemap_model.dart';

final class SitemapTargetWriter implements TargetWriter {
  SitemapTargetWriter(this.outputDirectory, this.locale);

  final String outputDirectory;

  final String locale;

  final _model = SitemapModel(url: []);

  @override
  TargetType get type => TargetType.sitemap;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void build(WriteRequest request) {
    _model.build(request);
  }

  @override
  void write() async {
    final value = '''
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
xmlns:xhtml="http://www.w3.org/1999/xhtml">
${_model.url?.map((u) => '''
<url><loc>$u</loc>
${_model.alternate?.map((u) => '''
<xhtml:link
        rel="alternate"
        hreflang="${u.hreflang}"
        href="${u.href}" />
''').join()}
</url>
''').join()}
</urlset>
''';
    final sitemapFile = File('$outputDirectory/sitemap.xml');
    await sitemapFile.create(recursive: true);
    await sitemapFile.writeAsString(value);
  }
}
