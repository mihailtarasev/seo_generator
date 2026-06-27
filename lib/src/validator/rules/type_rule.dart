import '../../model/schema_field.dart';
import '../validation_exception.dart';
import '../validation_rule.dart';

final class TypeRule implements ValidationRule {
  @override
  void validate(
    SchemaField field,
    Object? value,
  ) {
    final validation = field.validation;

    if (validation == null) {
      return;
    }

    final expectedType = validation.type;

    if (expectedType == null) {
      return;
    }

    final valid = switch (expectedType) {
      'string' => value is String,
      'integer' => value is int,
      'number' => value is num,
      'boolean' => value is bool,
      _ => true,
    };

    if (!valid) {
      throw ValidationException(
        'Field "${field.name}" must be $expectedType.',
      );
    }
  }
}