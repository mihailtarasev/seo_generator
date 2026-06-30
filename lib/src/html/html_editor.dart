import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:seo_generator/src/extension/element.dart';

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

  void setScript({
    required String type,
    required String content,
  }) {
    Element? script = _document.querySelector(
      'script[type="$type"]',
    );

    script ??= Element.tag('script')..setAttribute('type', type);

    script.text = content;
  }

  void addHeadElement(Element element) {
    final head = _document.head!;
    head.nodes.add(Text('  '));
    head.append(element);
    head.nodes.add(Text('\n'));
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
