class AlternateModel {
  AlternateModel({
    required this.hreflang,
    required this.href,
  });

  String hreflang;
  String href;

  factory AlternateModel.fromJson(Map<String, dynamic> json) {
    return AlternateModel(
      hreflang: json['hreflang'] as String,
      href: json['href'] as String,
    );
  }
}
