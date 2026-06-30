import 'package:seo_generator/seo_generator.dart';

class OgAlternateModel {
  OgAlternateModel({
    this.siteLocale,
    this.ogAlternate,
  });

  String? siteLocale;
  List<dynamic>? ogAlternate;

  late final Map<String, void Function(dynamic)> _setters = {
    'siteLocale': (v) => siteLocale = v as String,
    'ogAlternate': (v) => ogAlternate = v as List<dynamic>,
  };

  void build(WriteRequest request) {
    _setters[request.selector]?.call(request.value);
  }
}
