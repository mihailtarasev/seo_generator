import 'package:seo_generator/src/model/target.dart';

final class WriteRequest {
  const WriteRequest({
    required this.type,
    required this.selector,
    this.attribute,
    required this.value,
  });

  final TargetType type;
  final String selector;
  final String? attribute;
  final Object? value;
}
