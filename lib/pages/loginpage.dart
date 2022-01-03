import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test/apis/localdata.dart';
import 'mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final LocalData localData = LocalData();
  late AadOAuth _oauth;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    localData.getConfig().then((value) {
      _oauth = AadOAuth(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              // ignore: prefer_const_literals_to_create_immutables
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  _headerSection(),
                  _buttonSection(),
                ],
              ),
      ),
    );
  }

  Container _buttonSection() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 40.0,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        margin: const EdgeInsets.only(top: 15.0),
        child: ElevatedButton(
          key: const Key('loginbtn'),
          child: const Text("Enter", style: TextStyle(color: Colors.white70)),
          onPressed: _signIn,
        ));
  }

  Container _headerSection() {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: const Text("Login Microsoft Azure Account",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 30.0,
              fontWeight: FontWeight.bold)),
    );
  }

  void _signIn() async {
    await _oauth.login();
    await _oauth.getAccessToken().then((value) {
      if (value != null) {
        String _token = value.toString();

        _storage.write(key: 'token', value: _token).then((value) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const MainPage()),
              (Route<dynamic> route) => false);
          _isLoading = false;
        });
      }
    });
  }
}
