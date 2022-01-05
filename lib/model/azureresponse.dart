import 'account.dart';

class AzureResponse {
  String? odataContext;
  late List<Account> value;

  AzureResponse({required this.odataContext, required this.value});

  AzureResponse.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <Account>[];
      json['value'].forEach((v) {
        value.add(Account.fromJson(v));
        //value!.add(Account.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@odata.context'] = odataContext;
    data['value'] = value.map((v) => v.toJson()).toList();
    return data;
  }
}
