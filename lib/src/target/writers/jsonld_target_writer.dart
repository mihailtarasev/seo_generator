import 'dart:convert';

import 'package:seo_generator/seo_generator.dart';
import 'package:seo_generator/src/model/jsonld_model.dart';

final class JsonLdTargetWriter implements TargetWriter {
  JsonLdTargetWriter(this._document);

  final HtmlEditor _document;

  final _model = JsonLdModel();

  @override
  TargetType get type => TargetType.jsonLd;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void build(WriteRequest request) {
    _model.build(request);
  }

  @override
  void write() {
    final content = '''
<script type="application/ld+json">
{
  "@context":"https://schema.org",
  "@type":"SoftwareApplication",
  "name":${jsonEncode(_model.name)},
  "description":${jsonEncode(_model.description)},
  "url": ${jsonEncode(_model.url)},
  "image": ${jsonEncode(_model.image)},
  "applicationCategory":"GameApplication",
  "operatingSystem":"Android, iOS",
  "inLanguage": ${jsonEncode(_model.language)},
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "USD"
  }
}
</script>
</head>
''';
    _document.setScript(type: 'application/ld+json', content: content);
  }
}
