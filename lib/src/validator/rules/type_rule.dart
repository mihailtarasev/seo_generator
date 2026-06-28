// ignore_for_file: always_use_package_imports

import 'package:seo_generator/seo_generator.dart';

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
      ValueType.string => value is String,
      ValueType.integer => value is int,
      ValueType.number => value is num,
      ValueType.boolean => value is bool,
    };

    if (!valid) {
      throw ValidationException(
        'Field "${field.source.key}" must be $expectedType.',
      );
    }
  }
}
