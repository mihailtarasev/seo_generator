import 'package:seo_generator/src/model/target.dart';
import 'package:seo_generator/src/target/write_request.dart';

abstract interface class TargetWriter {
  TargetType get type;

  void write(WriteRequest request);
}
