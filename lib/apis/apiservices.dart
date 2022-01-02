import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test/model/account.dart';
import 'package:http/http.dart' as http;
import 'package:test/model/azureresponse.dart';
import 'package:test/model/filtermodel.dart';
import 'package:test/pages/loginpage.dart';

class APIServices {
  final String _webApiUrl =
      "https://org2c9fce96.api.crm4.dynamics.com/api/data/v9.2";
  final _storage = const FlutterSecureStorage();
  List<Account> _accountsCache = <Account>[];
  String? _token;

  Map<String, String> _getHeaders(String mytoken) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + mytoken,
    };
    return headers;
  }

  Future<List<Account>> getAccounts(
      BuildContext context, FilterModel filter) async {
    List<Account> _accounts = <Account>[];

    //**Token Control */
    if (_token == null) {
      _token = await _storage.read(key: "token");
      if (_token == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage()),
            (Route<dynamic> route) => false);
        return _accounts;
      }
    }

    String _url = _webApiUrl + "/accounts" + getodataFilter(filter);
    final _response = await http.Client()
        .get(Uri.parse(_url), headers: _getHeaders(_token.toString()));

    if (_response.statusCode == 200) {
      AzureResponse _ar = AzureResponse.fromJson(jsonDecode(_response.body));
      _accounts = _ar.value;
      _accountsCache = _accounts;
    } else if (_response.statusCode == 401) {
      //**Token Expired */
      _token = null;
      _storage.delete(key: "token");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
    return _accounts;
  }

  List<Account> getAccountsFromCache() {
    return _accountsCache;
  }

  String getodataFilter(FilterModel filterModel) {
    String filter = "";
    if ((filterModel.stateCode != null) && (filterModel.stateCode != "")) {
      filter = filter +
          " and address1_stateorprovince eq '" +
          filterModel.stateCode.toString() +
          "'";
    } else if ((filterModel.countryCode != null) &&
        (filterModel.countryCode != "")) {
      filter = filter +
          " and address1_country eq '" +
          filterModel.countryCode.toString() +
          "'";
    }

    if ((filterModel.name != null) && (filterModel.name != "")) {
      //filter = filter + " and name eq '" + filterModel.name.toString() + "'";
      filter =
          filter + " and contains(name, '" + filterModel.name.toString() + "')";
    }

    if ((filterModel.accountnumber != null) &&
        (filterModel.accountnumber != "")) {
      // filter = filter + " and accountnumber eq " +
      //     filterModel.accountnumber.toString();
      filter = filter +
          " and contains(accountnumber, '" +
          filterModel.accountnumber.toString() +
          "')";
    }

    if (filter != "") {
      filter = "?\$filter=true " + filter;
    }
    return filter;
  }
}
