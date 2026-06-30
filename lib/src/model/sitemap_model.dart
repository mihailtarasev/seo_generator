import 'package:seo_generator/seo_generator.dart';
import 'package:seo_generator/src/model/alternate_model.dart';

class SitemapModel {
  SitemapModel({
    this.url,
    this.alternate,
  });

  List<dynamic>? url;
  List<AlternateModel>? alternate;

  late final Map<String, void Function(dynamic)> _setters = {
    'url': (v) => url?.add(v),
    'alternate': (v) => alternate = (v as List<dynamic>).map((e) {
          (e as Map<String, dynamic>);
          return AlternateModel(
            href: e['href'] as String,
            hreflang: e['hreflang'] as String,
          );
        }).toList(),
  };

  void build(WriteRequest request) {
    _setters[request.selector]?.call(request.value);
  }
}
