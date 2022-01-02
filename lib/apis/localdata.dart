import 'dart:convert';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/services.dart';
import 'package:test/model/country.dart';
import 'package:test/model/cstate.dart';
import 'package:test/model/myconfig.dart';

class LocalData {
  Future<Config> getConfig() async {
    String _configjson = await rootBundle.loadString('assets/myconfig.json');
    return MyConfig.fromJson(jsonDecode(_configjson));
  }

  Future<List<Country>> getAllCountries() async {
    String _jsondata = await rootBundle.loadString('assets/countries.json');
    List<Country> _counties = <Country>[];
    json.decode(_jsondata).forEach((element) {
      try {
        _counties.add(Country.fromJson(element));
      } catch (e) {
        //print(e.toString());
      }
    });
    return _counties;
  }

  Future<List<CState>> getAllStates() async {
    String _jsondata = await rootBundle.loadString('assets/cstates.json');
    List<CState> _cStates = <CState>[];
    json.decode(_jsondata).forEach((element) {
      try {
        _cStates.add(CState.fromJson(element));
      } catch (e) {
        //print(e.toString());
      }
    });
    return _cStates;
  }

  Future<List<CState>> getStatesFromCounty(String countyCode) async {
    List<CState> _cStates = await getAllStates();
    _cStates = _cStates.where((q) => q.countrycode == countyCode).toList();
    _cStates.insert(
        0,
        const CState(
            statecode: 0,
            stateab: "",
            countrycode: "",
            statename: "Select State"));
    return _cStates;
  }

  Future<CState> getStateByCode(String stateCode) async {
    List<CState> _cStates = await getAllStates();
    if (_cStates.where((q) => q.stateab == stateCode).isEmpty == false) {
      return _cStates.where((q) => q.stateab == stateCode).first;
    } else {
      return const CState(
          statecode: -1,
          stateab: "",
          countrycode: "",
          statename: "No Registered State");
    }
  }
}
