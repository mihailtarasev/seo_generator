import 'package:seo_generator/src/model/schema_field.dart';
import 'package:seo_generator/src/validator/rules/max_length_rule.dart';
import 'package:seo_generator/src/validator/rules/min_length_rule.dart';
import 'package:seo_generator/src/validator/rules/pattern_rule.dart';
import 'package:seo_generator/src/validator/rules/required_rule.dart';
import 'package:seo_generator/src/validator/rules/type_rule.dart';
import 'package:seo_generator/src/validator/validation_rule.dart';

final class Validator {
  Validator()
      : _rules = [
          RequiredRule(),
          TypeRule(),
          MinLengthRule(),
          MaxLengthRule(),
          PatternRule(),
        ];

  final List<ValidationRule> _rules;

  void validate(
    SchemaField field,
    Object? value,
  ) {
    for (final rule in _rules) {
      rule.validate(field, value);
    }
  }
}
