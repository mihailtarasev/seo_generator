import 'package:seo_generator/src/target/write_request.dart';

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

extension TargetMapper on Target {
  WriteRequest toWriteRequest(Object? value) {
    return WriteRequest(
      type: type,
      selector: selector,
      attribute: attribute,
      value: value,
    );
  }
}