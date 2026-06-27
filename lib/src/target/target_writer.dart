import '../model/target.dart';

abstract interface class TargetWriter {
  TargetType get type;

  void write(
    Target target,
    Object? value,
  );
}