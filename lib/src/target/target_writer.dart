import 'package:seo_generator/src/model/write_request.dart';

import '../model/target.dart';

abstract interface class TargetWriter {
  TargetType get type;

  void write(WriteRequest request);
}
