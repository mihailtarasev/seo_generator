import 'package:seo_generator/src/model/schema_field.dart';

abstract interface class ValidationRule {
  void validate(
    SchemaField field,
    Object? value,
  );
}