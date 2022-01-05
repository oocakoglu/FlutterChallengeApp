import 'package:flutter/material.dart';
import 'package:test/apis/localdata.dart';
import 'package:test/model/cstate.dart';

enum IconPosition { pFirst, pLast }

class MyAddressCard extends StatelessWidget {
  final LocalData localData = LocalData();
  final String? city;
  final String? stateCode;
  final String? countryName;
  final MainAxisAlignment mainAxisAlignment;
  final double? textSize;
  final IconPosition iconPosition;

  MyAddressCard(
      {Key? key,
      this.city,
      this.stateCode,
      this.countryName,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.textSize,
      this.iconPosition = IconPosition.pFirst})
      : super(key: key);

  Future<String> _getDynamicAdress(
      {String? cityName, String? stateCode, String? countryName}) async {
    String _dynamicAdress = "";
    if (cityName != null) {
      _dynamicAdress = cityName + " - ";
    }

    if (stateCode != null) {
      CState _cstate = await localData.getStateByCode(stateCode.toString());
      if (_cstate.statecode > 0) {
        _dynamicAdress = _dynamicAdress + _cstate.statename;
      }
    }

    if (countryName != null) {
      _dynamicAdress = _dynamicAdress + " / " + countryName;
    }

    return _dynamicAdress;
  }

  Widget _adresText(String adres) {
    return Text(
      adres,
      style: TextStyle(fontSize: textSize),
    );
  }

  Widget _adresIcon(String adres) {
    return Icon(
      Icons.home,
      color: Colors.blue.shade700,
      size: textSize,
      textDirection: TextDirection.ltr,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getDynamicAdress(
        cityName: city,
        stateCode: stateCode,
        countryName: countryName,
      ),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        Widget _mycard;
        if (snapshot.hasData) {
          _mycard = Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              iconPosition == IconPosition.pFirst
                  ? _adresIcon(snapshot.data.toString())
                  : _adresText(snapshot.data.toString()),
              const SizedBox(width: 2),
              iconPosition == IconPosition.pFirst
                  ? _adresText(snapshot.data.toString())
                  : _adresIcon(snapshot.data.toString()),
            ],
          );
        } else {
          _mycard = const Text('...');
        }
        return _mycard;
      },
    );
  }
}
