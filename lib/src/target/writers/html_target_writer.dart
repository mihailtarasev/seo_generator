import 'package:seo_generator/src/html/html_editor.dart';
import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/target/target_writer.dart';
import 'package:seo_generator/src/target/write_request.dart';

final class HtmlTargetWriter implements TargetWriter {
  HtmlTargetWriter(this._document);

  final HtmlEditor _document;

  @override
  TargetType get type => TargetType.html;

  @override
  bool supports(TargetType type) => this.type == type;

  @override
  void write(WriteRequest target) {
    _document.write(
      selector: target.selector,
      attribute: target.attribute,
      value: target.value,
    );
  }
}
