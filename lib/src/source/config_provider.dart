import 'package:seo_generator/src/model/source.dart';
import 'package:seo_generator/src/source/source_provider.dart';

final class ConfigProvider implements SourceProvider {
  ConfigProvider(this._data);

  final Map<String, Object?> _data;

  @override
  SourceType get type => SourceType.config;

  @override
  Object? read(String key) {
    return _data[key];
  }

  @override
  bool contains(String key) => _data.containsKey(key);
}
