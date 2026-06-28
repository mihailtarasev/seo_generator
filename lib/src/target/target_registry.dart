import 'package:seo_generator/seo_generator.dart';

final class TargetRegistry {
  TargetRegistry(this._writers);

  final List<TargetWriter> _writers;

  void write(WriteRequest request) {
    for (final writer in _writers) {
      if (writer.supports(request.type)) {
        writer.write(request);
      }
    }
  }
}