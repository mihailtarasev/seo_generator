import 'dart:convert';

import 'package:seo_generator/seo_generator.dart';

final class JsonLdTargetWriter implements TargetWriter {
  JsonLdTargetWriter();

  final Map<String, dynamic> _data = {};

  @override
  TargetType get type => TargetType.jsonLd;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void write(WriteRequest request) {
    _data[request.selector] = request.value;
  }

  String build() {
    return '''
<script type="application/ld+json">
{
  "@context":"https://schema.org",
  "@type":"SoftwareApplication",
  "name":${jsonEncode(_data['seoJsonLdName'])},
  "description":${jsonEncode(_data['seoJsonLdDescription'])}
  "url": ${jsonEncode(_data['seoJsonLdUrl'])},
  "image": ${jsonEncode(_data['seoJsonLdImage'])},
  "applicationCategory":"GameApplication",
  "operatingSystem":"Android, iOS",
  "inLanguage": ${jsonEncode(_data['seoJsonLdLanguage'])},
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "USD"
  }
}
</script>
</head>
''';
  }
}
