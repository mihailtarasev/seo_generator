import 'package:seo_generator/seo_generator.dart';

final class SitemapTargetWriter implements TargetWriter {
  SitemapTargetWriter();

  final List<String> _urls = [];

  @override
  TargetType get type => TargetType.sitemap;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void write(WriteRequest request) {
    _urls.add(request.value.toString());
  }

  String build() {
    return '''
<?xml version="1.0" encoding="UTF-8"?>
<urlset>
${_urls.map((u) => '<url><loc>$u</loc></url>').join()}
</urlset>
''';
  }
}
