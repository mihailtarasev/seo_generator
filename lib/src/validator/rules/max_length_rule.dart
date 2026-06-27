import '../../model/schema_field.dart';
import '../validation_exception.dart';
import '../validation_rule.dart';

final class MaxLengthRule implements ValidationRule {
  @override
  void validate(
    SchemaField field,
    Object? value,
  ) {
    final validation = field.validation;

    if (validation == null) {
      return;
    }

    final max = validation.maxLength;

    if (max == null) {
      return;
    }

    if (value is! String) {
      return;
    }

    if (value.length > max) {
      throw ValidationException(
        'Field "${field.name}" must contain at no more than $max characters.',
      );
    }
  }
}
