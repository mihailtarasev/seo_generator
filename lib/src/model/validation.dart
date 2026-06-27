enum ValueType {
  string,
  integer,
  number,
  boolean,
}

class Validation {
  const Validation({
    this.type,
    this.required = false,
    this.minLength,
    this.maxLength,
    this.pattern,
  });

  final ValueType? type;

  final bool required;

  final int? minLength;

  final int? maxLength;

  final String? pattern;
}
