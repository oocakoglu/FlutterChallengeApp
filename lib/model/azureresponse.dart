import 'account.dart';

class AzureResponse {
  final String odataContext;
  final List<Account> value;

  const AzureResponse({required this.odataContext, required this.value});

  factory AzureResponse.fromJson(Map<String, dynamic> json) {
    //**Fill The List
    List<Account> accounts = <Account>[];
    if (json['value'] != null) {
      // List<dynamic> data = json["value"];
      json["value"].forEach((element) {
        try {
          Account a = Account.fromJson(element);
          accounts.add(a);
        } catch (e) {
          e.toString();
        }
      });
    }

    return AzureResponse(
      odataContext: json['@odata.context'] as String,
      value: accounts,
    );
  }
}
