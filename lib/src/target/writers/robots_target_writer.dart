import 'dart:io';

import 'package:seo_generator/seo_generator.dart';

final class RobotsTargetWriter implements TargetWriter {
  RobotsTargetWriter(this.outputDirectory);

  final StringBuffer buffer = StringBuffer();

  final String outputDirectory;

  @override
  TargetType get type => TargetType.robots;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void build(WriteRequest request) {
    buffer.writeln(request.value);
  }

  @override
  void write() async {
    final value = '''
User-agent: *
Allow: /

Sitemap: ${buffer.toString()}
''';

    final robotsFile = File('$outputDirectory/robots.txt');
    await robotsFile.create(recursive: true);
    await robotsFile.writeAsString(value);
  }
}
