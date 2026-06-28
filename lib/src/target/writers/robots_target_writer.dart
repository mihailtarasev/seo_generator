import 'package:seo_generator/seo_generator.dart';

final class RobotsTargetWriter implements TargetWriter {
  final StringBuffer buffer = StringBuffer();

  @override
  TargetType get type => TargetType.robots;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void write(WriteRequest request) {
    buffer.writeln(request.value);
  }

  String build() {
    return '''
User-agent: *
Allow: /

Sitemap: ${buffer.toString()}
''';
  }
}
