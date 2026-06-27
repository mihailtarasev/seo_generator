enum TargetType {
  html,
}

class Target {
  const Target({
    required this.type,
    required this.selector,
    this.attribute,
  });

  final TargetType type;

  final String selector;

  final String? attribute;
}