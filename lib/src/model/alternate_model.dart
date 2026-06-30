import 'package:seo_generator/seo_generator.dart';

class AlternateModel {
  String? hreflang;
  String? href;

  late final Map<String, void Function(String?)> _setters = {
    'hreflang': (v) => hreflang = v,
    'href': (v) => href = v,
  };

  void build(WriteRequest request) {
    _setters[request.selector]?.call(request.value as String);
  }
}
