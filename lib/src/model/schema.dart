import 'package:seo_generator/src/model/schema_field.dart';

class Schema {
  const Schema({
    required this.fields,
  });

  final List<SchemaField> fields;
}
