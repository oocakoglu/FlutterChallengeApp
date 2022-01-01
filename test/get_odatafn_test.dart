import 'package:flutter_test/flutter_test.dart';
import 'package:test/model/filtermodel.dart';
import 'package:test/model/variables.dart';

void main() {
  test("getODATA function test", () async {
    //ARRANGE
    FilterModel filterModel = FilterModel(countryCode: "U.S.");

    //ACT,
    String oDataFilter = getodataFilter(filterModel);

    //ASSERTION
    expect(oDataFilter != "", true);
  });
}
