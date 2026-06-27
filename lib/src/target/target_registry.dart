import 'package:seo_generator/src/model/write_request.dart';

import '../model/target.dart';
import 'target_writer.dart';

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
