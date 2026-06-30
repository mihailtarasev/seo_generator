import 'package:seo_generator/src/model/source.dart';
import 'package:seo_generator/src/source/source_provider.dart';

final class SourceResolver {
  SourceResolver(
    Iterable<SourceProvider> providers,
  ) : _providers = {
          for (final provider in providers) provider.type: provider,
        };

  final Map<SourceType, SourceProvider> _providers;

  Object? resolve2(Source source) {
    final provider = _providers[source.type];

    if (provider == null) {
      throw StateError(
        'No provider registered for ${source.type}.',
      );
    }

    return provider.read(source.key);
  }

  Object? resolve(String source) {
    final separator = source.indexOf('.');

    // По умолчанию — ARB
    if (separator == -1) {
      return _providers[SourceType.arb]?.read(source);
    }

    final type = switch (source.substring(0, separator)) {
      'config' => SourceType.config,
      'arb' => SourceType.arb,
      _ => throw UnsupportedError('Unknown source: $source'),
    };

    final key = source.substring(separator + 1);

    return _providers[type]?.read(key);
  }
}
