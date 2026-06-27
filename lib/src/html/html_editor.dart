import 'package:html/dom.dart';
import 'package:html/parser.dart';

final class HtmlEditor {
  HtmlEditor._(this._document);

  final Document _document;

  final Map<String, Element> _cache = {};

  factory HtmlEditor.fromString(String html) {
    return HtmlEditor._(
      parse(html),
    );
  }

  String toHtml() {
    return _document.outerHtml;
  }

  void write({
    required String selector,
    String? attribute,
    Object? value,
  }) {
    final element = _find(selector);

    final text = value?.toString() ?? '';

    if (attribute == null) {
      element.text = text;
      return;
    }

    element.attributes[attribute] = text;
  }

  Element _find(String selector) {
    final cached = _cache[selector];
    if (cached != null) {
      return cached;
    }

    final element = _document.querySelector(selector);

    if (element != null) {
      _cache[selector] = element;
    } else {
      throw StateError(
        'Element "$selector" not found.',
      );
    }

    return element;
  }
}
