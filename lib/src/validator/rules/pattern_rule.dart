import '../../model/schema_field.dart';
import '../validation_exception.dart';
import '../validation_rule.dart';

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
        'Field "${field.name}" does not match "$pattern".',
      );
    }
  }
}