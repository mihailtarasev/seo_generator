import '../model/source.dart';

abstract interface class SourceProvider {
  SourceType get type;

  bool contains(String key);

  Object? read(String key);
}