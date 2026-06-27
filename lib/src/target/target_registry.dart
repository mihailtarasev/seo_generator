import '../model/target.dart';
import 'target_writer.dart';

final class TargetRegistry {
  TargetRegistry(
    Iterable<TargetWriter> writers,
  ) : _writers = {
          for (final writer in writers)
            writer.type: writer,
        };

  final Map<TargetType, TargetWriter> _writers;

  void write(
    Target target,
    Object? value,
  ) {
    final writer = _writers[target.type];

    if (writer == null) {
      throw StateError(
        'No writer registered for ${target.type.name}.',
      );
    }

    writer.write(target, value);
  }
}