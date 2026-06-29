import 'package:seo_generator/src/html/html_editor.dart';
import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/target/target_writer.dart';
import 'package:seo_generator/src/target/write_request.dart';

final class HtmlTargetWriter implements TargetWriter {
  HtmlTargetWriter(this._document);

  final HtmlEditor _document;

  final Map<String, dynamic> _data = {};

  @override
  TargetType get type => TargetType.html;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void build(WriteRequest request) {
    _data[request.selector] = request;
  }

  @override
  void write() {
    for (final entries in _data.entries) {
      _writeSelector(entries.key, entries.value);
    }
  }

  void _writeSelector(String selector, dynamic request) {
    (request as WriteRequest);
    _document.write(
      selector: selector,
      attribute: request.attribute,
      value: request.value,
    );
  }
}
