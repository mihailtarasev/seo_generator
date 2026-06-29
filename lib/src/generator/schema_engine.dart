import 'package:seo_generator/src/model/schema.dart';
import 'package:seo_generator/src/model/schema_field.dart';
import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/source/source_resolver.dart';
import 'package:seo_generator/src/target/target_registry.dart';
import 'package:seo_generator/src/validator/validator.dart';

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
      _buildField(field);
    }
    for (final writer in _targetRegistry.writers) {
      writer.write();
    }
  }

  void _buildField(SchemaField field) {
    final value = _sourceResolver.resolve(field.source);

    _validator.validate(field, value);

    _targetRegistry.build(
      field.target.toWriteRequest(value),
    );
  }
}
