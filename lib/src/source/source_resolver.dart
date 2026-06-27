import 'package:seo_generator/src/model/source.dart';
import 'package:seo_generator/src/source/source_provider.dart';

final class SourceResolver {
  SourceResolver(
    Iterable<SourceProvider> providers,
  ) : _providers = {
          for (final provider in providers) provider.type: provider,
        };

  final Map<SourceType, SourceProvider> _providers;

  Object? resolve(Source source) {
    final provider = _providers[source.type];

    if (provider == null) {
      throw StateError(
        'No provider registered for ${source.type}.',
      );
    }

    return provider.read(source.key);
  }
}
