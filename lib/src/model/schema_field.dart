import 'package:seo_generator/src/model/source.dart';
import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/model/validation.dart';

class SchemaField {
  const SchemaField({
    required this.source,
    required this.target,
    this.validation,
  });

  final Source source;

  final Target target;

  final Validation? validation;
}
