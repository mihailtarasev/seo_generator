import '../model/schema_field.dart';

abstract interface class ValidationRule {
  void validate(
    SchemaField field,
    Object? value,
  );
}