import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/model/filtermodel.dart';
import 'package:test/pages/filterpage.dart';

void main() {
  group('Sample Widget Test', () {
    testWidgets('Fill Model in FilterPage', (tester) async {
      FilterModel _filterModel =
          FilterModel(name: "Sample Name", accountnumber: "Sample Account No");

      await tester.pumpWidget(MaterialApp(
        home: FilterPage(_filterModel),
      ));

      expect(find.text('Sample Name'), findsOneWidget);
      expect(find.text('Sample Account No'), findsOneWidget);
      //await tester.pumpAndSettle(const Duration(seconds: 13));
    });
  });
}
