import 'package:seo_generator/src/model/schema_field.dart';
import 'package:seo_generator/src/validator/validation_exception.dart';
import 'package:seo_generator/src/validator/validation_rule.dart';

final class PatternRule implements ValidationRule {
  @override
  void validate(
    SchemaField field,
    Object? value,
  ) {
    final validation = field.validation;

    if (validation == null) {
      return;
    }

    final pattern = validation.pattern;

    if (pattern == null) {
      return;
    }

    if (value is! String) {
      return;
    }

    if (!RegExp(pattern).hasMatch(value)) {
      throw ValidationException(
        'Field "${field.source.key}" does not match "$pattern".',
      );
    }
  }
}