import '../../model/schema_field.dart';
import '../validation_exception.dart';
import '../validation_rule.dart';

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
        'Field "${field.name}" must contain at least $min characters.',
      );
    }
  }
}