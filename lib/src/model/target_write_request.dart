final class TargetWriteRequest {
  const TargetWriteRequest({
    required this.selector,
    this.attribute,
    required this.value,
  });

  final String selector;
  final String? attribute;
  final Object? value;
}