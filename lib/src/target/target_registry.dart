import 'package:seo_generator/seo_generator.dart';

final class TargetRegistry {
  TargetRegistry(this._writers);

  final List<TargetWriter> _writers;

  List<TargetWriter> get writers => _writers;

  void build(WriteRequest request) {
    for (final writer in _writers) {
      if (writer.supports(request.type)) {
        writer.build(request);
      }
    }
  }

  void write(WriteRequest request) {
    for (final writer in _writers) {
      if (writer.supports(request.type)) {
        writer.write();
      }
    }
  }
}
