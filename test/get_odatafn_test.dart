import 'package:flutter_test/flutter_test.dart';
import 'package:test/apis/apiservices.dart';
import 'package:test/model/filtermodel.dart';

void main() {
  test("getODATA function test", () async {
    //ARRANGE
    FilterModel filterModel = FilterModel(countryCode: "U.S.");

    //ACT,
    APIServices _api = APIServices();
    String oDataFilter = _api.getodataFilter(filterModel);

    //ASSERTION
    expect(oDataFilter != "", true);
  });
}
