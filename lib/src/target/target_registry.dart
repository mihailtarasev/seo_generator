import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/target/target_writer.dart';
import 'package:seo_generator/src/target/write_request.dart';

final class TargetRegistry {
  TargetRegistry(
    Iterable<TargetWriter> writers,
  ) : _writers = {
          for (final writer in writers) writer.type: writer,
        };

  final Map<TargetType, TargetWriter> _writers;

  void write(WriteRequest request) {
    final writer = _writers[request.type];

    if (writer == null) {
      throw StateError(
        'No writer registered for ${request.type.name}.',
      );
    }

    writer.write(request);
  }
}
