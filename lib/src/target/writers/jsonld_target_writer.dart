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
    print(request.selector);
    print(request.value);
    _data[request.selector] = request.value;
  }

  String build() {
    return '''
<script type="application/ld+json">
  "@context":"https://schema.org",
  "@type":"SoftwareApplication",
  "name":${jsonEncode(_data['name'])},
  "applicationCategory":"GameApplication",
  "operatingSystem":"Android, iOS",
  "description":"A self-improvement RPG that helps users overcome passions and bad habits through gamification."

</script>
</head>
''';
  }
}
