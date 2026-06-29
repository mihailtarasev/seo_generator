import 'package:seo_generator/seo_generator.dart';

class JsonLdModel {
  String? name;
  String? description;
  String? url;
  String? image;
  String? language;

  late final Map<String, void Function(String?)> _setters = {
    'name': (v) => name = v,
    'description': (v) => description = v,
    'url': (v) => url = v,
    'image': (v) => image = v,
    'language': (v) => language = v,
  };

  void build(WriteRequest request) {
    _setters[request.selector]?.call(request.value as String);
  }
}
