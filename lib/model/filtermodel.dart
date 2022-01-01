class FilterModel {
  final String? countryCode;
  final String? stateCode;
  final String? name;
  final String? accountnumber;

  FilterModel(
      {this.countryCode, this.stateCode, this.name, this.accountnumber});

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      countryCode: json['countryCode'] as String?,
      stateCode: json['stateCode'] as String?,
      name: json['name'] as String?,
      accountnumber: json['accountnumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'countryCode': countryCode,
        'stateCode': stateCode,
        'name': name,
        'accountnumber': accountnumber
      };
}
