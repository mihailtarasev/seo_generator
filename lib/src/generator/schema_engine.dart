import 'package:seo_generator/src/model/schema_field.dart';
import 'package:seo_generator/src/model/target.dart';

import '../model/schema.dart';
import '../source/source_resolver.dart';
import '../target/target_registry.dart';
import '../validator/validator.dart';

final class SchemaEngine {
  const SchemaEngine({
    required SourceResolver sourceResolver,
    required Validator validator,
    required TargetRegistry targetRegistry,
  })  : _sourceResolver = sourceResolver,
        _validator = validator,
        _targetRegistry = targetRegistry;

  final SourceResolver _sourceResolver;
  final Validator _validator;
  final TargetRegistry _targetRegistry;

  void execute(Schema schema) {
    for (final field in schema.fields) {
      _executeField(field);
    }
  }

  void _executeField(SchemaField field) {
    final value = _sourceResolver.resolve(field.source);

    _validator.validate(field, value);

    _targetRegistry.write(
      field.target.toWriteRequest(value),
    );
  }
}
