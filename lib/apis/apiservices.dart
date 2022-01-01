import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/model/account.dart';
import 'package:http/http.dart' as http;
import 'package:test/model/azureresponse.dart';
import 'package:test/model/filtermodel.dart';
import 'package:test/model/variables.dart';

class APIServices {
  static const String _webApiUrl =
      "https://org2c9fce96.api.crm4.dynamics.com/api/data/v9.2";

  static Future<Map<String, String>> _getHeaders() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer ' + sharedPreferences.getString("token").toString(),
    };

    return headers;
  }

  static Future<List<Account>> getAccounts(FilterModel filter) async {
    String url = _webApiUrl + "/accounts" + getodataFilter(filter);
    Map<String, String> headers = await _getHeaders();
    List<Account> accounts = <Account>[];
    final response = await http.Client().get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      AzureResponse azureResponse =
          AzureResponse.fromJson(jsonDecode(response.body));
      accounts = azureResponse.value;
    } else if (response.statusCode == 401) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove("token");
    }

    return accounts;
  }
}
