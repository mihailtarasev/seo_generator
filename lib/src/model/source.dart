enum SourceType {
  locale,
  config,
}

class Source {
  const Source({
    required this.type,
    required this.key,
  });

  final SourceType type;

  final String key;
}
