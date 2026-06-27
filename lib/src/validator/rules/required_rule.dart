import 'package:seo_generator/src/model/schema_field.dart';
import 'package:seo_generator/src/validator/validation_exception.dart';
import 'package:seo_generator/src/validator/validation_rule.dart';

final class RequiredRule implements ValidationRule {
  @override
  void validate(
    SchemaField field,
    Object? value,
  ) {
    final validation = field.validation;

    if (validation == null) {
      return;
    }

    if (!validation.required) {
      return;
    }

    if (value == null) {
      throw ValidationException(
        'Field "${field.name}" is required.',
      );
    }
  }
}