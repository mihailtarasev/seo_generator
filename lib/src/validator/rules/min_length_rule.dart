import 'package:seo_generator/src/model/schema_field.dart';
import 'package:seo_generator/src/validator/validation_exception.dart';
import 'package:seo_generator/src/validator/validation_rule.dart';

final class MinLengthRule implements ValidationRule {
  @override
  void validate(
    SchemaField field,
    Object? value,
  ) {
    final validation = field.validation;

    if (validation == null) {
      return;
    }

    final min = validation.minLength;

    if (min == null) {
      return;
    }

    if (value is! String) {
      return;
    }

    if (value.length < min) {
      throw ValidationException(
        'Field "${field.source.key}" must contain at least $min characters.',
      );
    }
  }
}