class CState {
  final int statecode;
  final String stateab;
  final String countrycode;
  final String statename;

  const CState(
      {required this.statecode,
      required this.stateab,
      required this.countrycode,
      required this.statename});

  // const CState.f(
  //     this.statecode, this.stateab, this.countrycode, this.statename);

  factory CState.fromJson(Map<String, dynamic> json) {
    return CState(
      statecode: json['statecode'] as int,
      stateab: json['stateab'] as String,
      countrycode: json['countrycode'] as String,
      statename: json['statename'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'statecode': statecode,
        'stateab': stateab,
        'countrycode': countrycode,
        'statename': statename,
      };
}
