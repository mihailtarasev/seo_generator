import 'package:html/dom.dart';
import 'package:seo_generator/src/html/html_editor.dart';
import 'package:seo_generator/src/model/alternate_model.dart';
import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/target/target_writer.dart';
import 'package:seo_generator/src/target/write_request.dart';

final class AlternateTargetWriter implements TargetWriter {
  AlternateTargetWriter(this._document);

  final HtmlEditor _document;

  final List<AlternateModel> _data = [];

  @override
  TargetType get type => TargetType.alternate;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void build(WriteRequest request) {
    for (final item in request.value as List<dynamic>) {
      _data.add(AlternateModel.fromJson(item as Map<String, dynamic>));
    }
  }

  @override
  void write() {
    for (final item in _data) {
      final element = Element.tag('link')
        ..attributes['rel'] = 'alternate'
        ..attributes['hreflang'] = item.hreflang
        ..attributes['href'] = item.href;

      _document.addHeadElement(element);
    }
  }
}
