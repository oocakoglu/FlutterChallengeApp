import 'package:flutter/material.dart';
import 'package:test/apis/apiservices.dart';
import 'package:test/model/account.dart';
import 'package:test/model/filtermodel.dart';
import 'package:test/widgets/mygridview.dart';
import 'package:test/widgets/mylistview.dart';
import 'package:test/widgets/myloadingview.dart';
import 'filterpage.dart';

enum ScreenView { sListView, sTableView }
enum DataStatus { dloading, dDone }

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final APIServices _api = APIServices();
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
          ? const MyLoadingView()
          : _screenView == ScreenView.sListView
              ? MyListView(accounts: _accounts)
              : MyGridView(accounts: _accounts),
    );
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

  Color _getFilterBtnColor() {
    if (_api.getodataFilter(_filter) != "") {
      return Colors.black;
    } else {
      return Colors.white;
    }
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
    final _result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FilterPage(_filter)));

    if (_result != null) {
      _filter = _result as FilterModel;
      _loadAccounts(_filter);
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
