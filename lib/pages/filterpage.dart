import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/apis/localdata.dart';
import 'package:test/model/country.dart';
import 'package:test/model/cstate.dart';
import 'package:test/model/filtermodel.dart';

class FilterPage extends StatefulWidget {
  final FilterModel fm;
  const FilterPage(
    this.fm, {
    Key? key,
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtAccountNumber = TextEditingController();
  String _selectedCState = "";
  String _selectedCounty = "";
  List<CState> _cstates = <CState>[];
  List<Country> _counties = <Country>[];

  @override
  void initState() {
    super.initState();
    _cstates = LocalData.getAllStates();
    _counties = LocalData.getAllCountries();
    _loadFilterData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Paramters"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DropdownButton(
              value: _selectedCounty,
              hint: const Text("Select Country"),
              isExpanded: true,
              items: _counties.map((item) {
                return DropdownMenuItem(
                  child: Text(item.countryName),
                  value: item.countyCode,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCounty = value.toString();
                  if (value != "") {
                    _selectedCState = "";
                    _cstates = LocalData.getStatesFromCounty(value.toString());
                  }
                });
              },
            ),
            DropdownButton(
              value: _selectedCState,
              hint: const Text("Select State"),
              isExpanded: true,
              items: _cstates.map((item) {
                return DropdownMenuItem(
                  child: Text(item.statename),
                  value: item.stateab.toString(),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCState = value.toString();
                });
              },
            ),
            TextField(
                controller: _txtName,
                decoration: const InputDecoration(labelText: "Name")),
            TextField(
                controller: _txtAccountNumber,
                decoration: const InputDecoration(labelText: "Account Number")),
            _bottomButtons()
          ],
        ),
      ),
    );
  }

  Widget _bottomButtons() {
    return Row(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 15, top: 5),
              child: ElevatedButton.icon(
                  onPressed: _removeFilter,
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text("Cancel Filtr"))),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 15, top: 5),
              child: ElevatedButton.icon(
                  onPressed: _applyFilter,
                  icon: const Icon(Icons.filter_alt_sharp),
                  label: const Text("Apply Filter"))),
        ),
      ],
    );
  }

  void _loadFilterData() {
    FilterModel filterModel = widget.fm;
    if ((filterModel.stateCode != null) && (filterModel.stateCode != "")) {
      _selectedCState = filterModel.stateCode.toString();
    }

    if ((filterModel.countryCode != null) && (filterModel.countryCode != "")) {
      _selectedCounty = filterModel.countryCode.toString();
    }

    if ((filterModel.name != null) && (filterModel.name != "")) {
      _txtName.text = filterModel.name.toString();
    }

    if ((filterModel.accountnumber != null) &&
        (filterModel.accountnumber != "")) {
      _txtAccountNumber.text = filterModel.accountnumber.toString();
    }
  }

  void _applyFilter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    FilterModel filter = FilterModel(
        countryCode: _selectedCounty,
        stateCode: _selectedCState,
        name: _txtName.text,
        accountnumber: _txtAccountNumber.text);

    String sfilter = jsonEncode(filter);
    sharedPreferences.setString("filter", sfilter);
    Navigator.pop(context, true);
  }

  void _removeFilter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    FilterModel filter = FilterModel();
    String sfilter = jsonEncode(filter);
    sharedPreferences.setString("filter", sfilter);
    Navigator.pop(context, true);
  }
}
