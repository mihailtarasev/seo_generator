import '../../html/html_document.dart';
import '../../model/target.dart';
import '../target_writer.dart';

final class HtmlTargetWriter implements TargetWriter {
  HtmlTargetWriter(this._document);

  final HtmlDocument _document;

  @override
  TargetType get type => TargetType.html;

  @override
  void write(
    Target target,
    Object? value,
  ) {
    _document.write(
      selector: target.selector,
      attribute: target.attribute,
      value: value,
    );
  }
}