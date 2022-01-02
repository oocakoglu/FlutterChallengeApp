import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test/apis/apiservices.dart';
import 'package:test/model/account.dart';
import 'package:test/model/filtermodel.dart';
import 'package:test/model/variables.dart';
import 'package:test/widgets/gridview.dart';
import 'package:test/widgets/listview.dart';
import 'package:test/widgets/loadingview.dart';
import 'filterpage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final APIServices _api = APIServices();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final TextEditingController _txtSearch = TextEditingController();
  List<Account> _accounts = <Account>[];
  ScreenView _screenView = ScreenView.sListView;
  DataStatus _dataStatus = DataStatus.dloading;
  FilterModel _filter = FilterModel();

  @override
  void initState() {
    super.initState();
    _loadAccounts(_filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.search, color: Colors.black),
          title: TextField(
              controller: _txtSearch,
              //decoration: const InputDecoration(labelText: "Search"),
              decoration: const InputDecoration(
                labelText: "Search",
                // suffixIcon:
              ),
              onChanged: (value) {
                _searchAccount(value);
              }),
          actions: _appButtons()),
      body: _dataStatus == DataStatus.dloading
          ? loadingView()
          : _screenView == ScreenView.sListView
              ? listView(_accounts)
              : gridView(_accounts),
    );
  }

  Color _getFilterBtnColor() {
    if (_api.getodataFilter(_filter) != "") {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  List<Widget> _appButtons() {
    return <Widget>[
      ElevatedButton.icon(
        icon: Icon(
          Icons.filter_alt_sharp,
          color: _getFilterBtnColor(),
        ),
        label: Text(
          'Filter',
          style: TextStyle(
            fontSize: 10.0,
            color: _getFilterBtnColor(),
          ),
        ),
        onPressed: _openFilter,
      ),
      IconButton(
        padding: const EdgeInsets.only(right: 3.0),
        icon: Icon(Icons.table_chart,
            color: _screenView == ScreenView.sTableView
                ? Colors.black
                : Colors.white),
        onPressed: () => _setScreenView(ScreenView.sTableView),
      ),
      IconButton(
        icon: Icon(
          Icons.view_list,
          color:
              _screenView == ScreenView.sListView ? Colors.black : Colors.white,
        ),
        onPressed: () => _setScreenView(ScreenView.sListView),
      ),
    ];
  }

  void _setScreenView(ScreenView sc) async {
    setState(() {
      _screenView = sc;
    });
  }

  void _searchAccount(String value) {
    //**local Filter
    setState(() {
      _accounts = _api
          .getAccountsFromCache()
          .where((q) =>
              q.name.toString().toUpperCase().startsWith(value.toUpperCase()) ||
              q.accountnumber
                  .toString()
                  .toUpperCase()
                  .startsWith(value.toUpperCase()))
          .toList();
    });
  }

  void _openFilter() async {
    //**Remote Filter
    bool? result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FilterPage(_filter)));

    if (result != null) {
      if (result == true) {
        _storage.read(key: "filter").then((value) {
          if (value != null) {
            if (_filter != FilterModel.fromJson(jsonDecode(value))) {
              _filter = FilterModel.fromJson(jsonDecode(value));
              _loadAccounts(_filter);
            }
          }
        });
      }
    }
  }

  void _loadAccounts(FilterModel myfilter) async {
    setState(() {
      _dataStatus = DataStatus.dloading;
    });

    _api.getAccounts(context, myfilter).then((value) async {
      setState(() {
        _accounts = value;
        _dataStatus = DataStatus.dDone;
      });
    });
  }
}
