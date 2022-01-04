import 'package:flutter_test/flutter_test.dart';
import 'package:test/apis/apiservices.dart';
import 'package:test/model/filtermodel.dart';

void main() {
  test("getODATA function test Country", () async {
    //ARRANGE
    FilterModel filterModel = FilterModel(countryCode: "U.S.");

    //ACT,
    APIServices _api = APIServices();
    String oDataFilter = _api.getodataFilter(filterModel);

    //ASSERTION
    expect(oDataFilter != "", true);
    expect(
        oDataFilter == "?\$filter=true  and address1_country eq 'U.S.'", true);
  });

  test("getODATA function test General", () async {
    //ARRANGE
    FilterModel filterModel =
        FilterModel(stateCode: "WA", name: "City", accountnumber: "ABC");

    //ACT,
    APIServices _api = APIServices();
    String oDataFilter = _api.getodataFilter(filterModel);

    //ASSERTION
    expect(oDataFilter != "", true);
    expect(
        oDataFilter ==
            "?\$filter=true  and address1_stateorprovince eq 'WA' and contains(name, 'City') and contains(accountnumber, 'ABC')",
        true);
  });
}
