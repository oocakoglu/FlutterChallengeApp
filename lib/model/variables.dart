import 'package:aad_oauth/model/config.dart';

import 'filtermodel.dart';

enum ScreenView { sListView, sTableView }
enum DataStatus { dloading, dDone }

final Config config = Config(
    tenant: "0fcd2810-9edc-41c4-be92-6c6d78468e7a",
    clientId: "c316ac1a-5759-41f5-9906-715a86552865",
    // scope: "api://c316ac1a-5759-41f5-9906-715a86552865/TestScope",
    scope: "https://org2c9fce96.api.crm4.dynamics.com/user_impersonation",
    tokenIdentifier: "omer",
    clientSecret: "60c7Q~t1HSMTv~2QakY.gmQLo6BFnbUiCdr7k",
    redirectUri: "https://oauth.pstmn.io/v1/callback");

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
