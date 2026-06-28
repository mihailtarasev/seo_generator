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
    'jsonLd': TargetType.jsonLd,
    'sitemap': TargetType.sitemap,
    'robots': TargetType.robots,
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
    final list = jsonDecode(json) as List<dynamic>;
    return fromJson(list);
  }

  Schema fromJson(List<dynamic> json) {
    return Schema(
      fields: json
          .cast<Map<String, dynamic>>()
          .map(_parseField)
          .toList(growable: false),
    );
  }

  SchemaField _parseField(Map<String, dynamic> json) {
    return SchemaField(
      source: _parseSource(json),
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
    final source = json['source'];
    if (source is Map<String, dynamic>) {
      return Source(
        type: _parseSourceType(source['type'] as String),
        key: source['key'] as String,
      );
    }
    if (source is String) {
      return Source(
        type: SourceType.arb,
        key: source,
      );
    }

    throw const FormatException(
      'Property "source" must be a string or an object.',
    );
  }

  Target _parseTarget(Map<String, dynamic> json) {
    final type = _parseTargetType(json);
    dynamic selector = json['selector'];
    selector ??= type.name;
    return Target(
      type: type,
      selector: selector as String,
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

  TargetType _parseTargetType(Map<String, dynamic> json) {
    dynamic value = json['type'];
    value ??= 'html';
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
