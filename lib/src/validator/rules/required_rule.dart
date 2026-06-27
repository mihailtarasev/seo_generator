import '../../model/schema_field.dart';
import '../validation_exception.dart';
import '../validation_rule.dart';

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