import 'source.dart';
import 'target.dart';
import 'validation.dart';

class SchemaField {
  const SchemaField({
    required this.name,
    required this.source,
    required this.target,
    this.validation,
  });

  final String name;

  final Source source;

  final Target target;

  final Validation? validation;
}
