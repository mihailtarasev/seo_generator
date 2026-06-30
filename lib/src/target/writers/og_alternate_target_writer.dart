import 'package:html/dom.dart';
import 'package:seo_generator/src/html/html_editor.dart';
import 'package:seo_generator/src/model/og_alternate_model.dart';
import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/target/target_writer.dart';
import 'package:seo_generator/src/target/write_request.dart';

final class OgAlternateTargetWriter implements TargetWriter {
  OgAlternateTargetWriter(this._document);

  final HtmlEditor _document;

  final _model = OgAlternateModel();

  @override
  TargetType get type => TargetType.ogAlternate;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void build(WriteRequest request) {
    _model.build(request);
  }

  @override
  void write() {
    for (final item in _model.ogAlternate as List<dynamic>) {
      (item as String);
      if (item != _model.siteLocale) _writeElement(item);
    }
  }

  void _writeElement(String item) {
    final element = Element.tag('meta')
      ..attributes['property'] = 'og:locale:alternate'
      ..attributes['content'] = item;

    _document.addHeadElement(element);
  }
}
