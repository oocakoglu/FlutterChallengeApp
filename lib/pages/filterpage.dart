import 'package:flutter/material.dart';
import 'package:test/apis/localdata.dart';
import 'package:test/model/country.dart';
import 'package:test/model/cstate.dart';
import 'package:test/model/filtermodel.dart';

class FilterPage extends StatefulWidget {
  final FilterModel filtrModel;
  const FilterPage(
    this.filtrModel, {
    Key? key,
  }) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final LocalData localData = LocalData();
  final TextEditingController _txtName = TextEditingController();
  final TextEditingController _txtAccountNumber = TextEditingController();
  String _selectedCState = "";
  String _selectedCounty = "";
  List<CState> _cstates = <CState>[];
  List<Country> _counties = <Country>[];

  @override
  void initState() {
    super.initState();
    localData.getAllCountries().then((value) => setState(() {
          _counties = value;
        }));
    localData.getAllStates().then((value) => setState(() {
          _cstates = value;
        }));
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
              key: const Key("cmbCountry"),
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
                    setState(() {
                      _selectedCState = "";
                      localData
                          .getStatesFromCounty(value.toString())
                          .then((svalue) => _cstates = svalue);
                    });
                  }
                });
              },
            ),
            DropdownButton(
              key: const Key("cmbState"),
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
                key: const Key("txtName"),
                controller: _txtName,
                decoration: const InputDecoration(labelText: "Name")),
            TextField(
                key: const Key("txtAccountNumber"),
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
                  key: const Key("btnCancelFilter"),
                  onPressed: _removeFilter,
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text("Clear Filtr"))),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 15, top: 5),
              child: ElevatedButton.icon(
                  key: const Key("btnApplyFilter"),
                  onPressed: _applyFilter,
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  icon: const Icon(Icons.filter_alt_sharp),
                  label: const Text("Apply Filter"))),
        ),
      ],
    );
  }

  void _loadFilterData() {
    FilterModel filterModel = widget.filtrModel;
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
    FilterModel filter = FilterModel(
        countryCode: _selectedCounty,
        stateCode: _selectedCState,
        name: _txtName.text,
        accountnumber: _txtAccountNumber.text);

    Navigator.pop(context, filter);
  }

  void _removeFilter() async {
    FilterModel filter = FilterModel();
    Navigator.pop(context, filter);
  }
}
