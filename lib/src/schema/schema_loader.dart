import 'dart:convert';
import 'dart:io';

import 'package:seo_generator/src/model/schema.dart';
import 'package:seo_generator/src/model/schema_field.dart';
import 'package:seo_generator/src/model/source.dart';
import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/model/validation.dart';

final class SchemaLoader {
  const SchemaLoader();

  static const _sourceTypes = {
    'arb': SourceType.arb,
    'config': SourceType.config,
  };

  static const _targetTypes = {
    'html': TargetType.html,
  };

  static const _valueTypes = {
    'boolean': ValueType.boolean,
    'string': ValueType.string,
    'integer': ValueType.integer,
    'number': ValueType.number,
  };

  Future<Schema> fromFile(String path) async {
    final json = await File(path).readAsString();
    return fromString(json);
  }

  Schema fromString(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return fromJson(map);
  }

  Schema fromJson(Map<String, dynamic> json) {
    final fieldsJson = json['fields'];

    if (fieldsJson is! List) {
      throw const FormatException(
        'Property "fields" must be an array.',
      );
    }

    return Schema(
      fields: fieldsJson
          .cast<Map<String, dynamic>>()
          .map(_parseField)
          .toList(growable: false),
    );
  }

  SchemaField _parseField(Map<String, dynamic> json) {
    return SchemaField(
      name: json['name'] as String,
      source: _parseSource(
        json['source'] as Map<String, dynamic>,
      ),
      target: _parseTarget(
        json['target'] as Map<String, dynamic>,
      ),
      validation: json['validation'] == null
          ? null
          : _parseValidation(
              json['validation'] as Map<String, dynamic>,
            ),
    );
  }

  Source _parseSource(Map<String, dynamic> json) {
    return Source(
      type: _parseSourceType(
        json['type'] as String,
      ),
      key: json['key'] as String,
    );
  }

  Target _parseTarget(Map<String, dynamic> json) {
    return Target(
      type: _parseTargetType(
        json['type'] as String,
      ),
      selector: json['selector'] as String,
      attribute: json['attribute'] as String?,
    );
  }

  Validation _parseValidation(Map<String, dynamic> json) {
    return Validation(
      type: json['type'] == null
          ? null
          : _parseValueType(
              json['type'] as String,
            ),
      required: json['required'] as bool? ?? false,
      minLength: json['minLength'] as int?,
      maxLength: json['maxLength'] as int?,
      pattern: json['pattern'] as String?,
    );
  }

  SourceType _parseSourceType(String value) {
    final type = _sourceTypes[value];
    if (type == null) {
      throw FormatException('Unknown source type "$value".');
    }
    return type;
  }

  TargetType _parseTargetType(String value) {
    final type = _targetTypes[value];
    if (type == null) {
      throw FormatException('Unknown target type "$value".');
    }
    return type;
  }

  ValueType _parseValueType(String value) {
    final type = _valueTypes[value];
    if (type == null) {
      throw FormatException('Unknown value type "$value".');
    }
    return type;
  }
}
