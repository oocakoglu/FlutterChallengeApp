import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/model/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AadOAuth _oauth = AadOAuth(config);
  String _token = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await _oauth.login();
    await _oauth.getAccessToken().then((value) {
      if (value != null) {
        _token = value.toString();
        sharedPreferences.setString("token", _token);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const MainPage()),
            (Route<dynamic> route) => false);

        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}
