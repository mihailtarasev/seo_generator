import 'package:html/dom.dart';

extension ElementSetAttribute on Element {
  void setAttribute(String name, String value) {
    attributes[name] = value;
  }
}
