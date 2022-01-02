class Country {
  final String countyCode;
  final String countryName;

  const Country({required this.countyCode, required this.countryName});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countyCode: json['countyCode'] as String,
      countryName: json['countryName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'countyCode': countyCode,
        'countryName': countryName,
      };
}
