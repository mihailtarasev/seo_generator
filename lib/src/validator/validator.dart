import '../model/schema_field.dart';
import 'rules/max_length_rule.dart';
import 'rules/min_length_rule.dart';
import 'rules/pattern_rule.dart';
import 'rules/required_rule.dart';
import 'rules/type_rule.dart';
import 'validation_rule.dart';

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
