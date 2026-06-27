import 'package:seo_generator/src/html/html_editor.dart';
import 'package:seo_generator/src/model/write_request.dart';
import '../../model/target.dart';
import '../target_writer.dart';

final class HtmlTargetWriter implements TargetWriter {
  HtmlTargetWriter(this._document);

  final HtmlEditor _document;

  @override
  TargetType get type => TargetType.html;

  @override
  void write(WriteRequest target) {
    _document.write(
      selector: target.selector,
      attribute: target.attribute,
      value: target.value,
    );
  }
}
