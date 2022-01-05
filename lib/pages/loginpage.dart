import 'package:aad_oauth/aad_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test/apis/localdata.dart';
import 'package:test/widgets/myloadingview.dart';
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
    _isLoading = false;
    localData.getConfig().then((value) {
      _oauth = AadOAuth(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightBlueAccent,
        child: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment.bottomRight,
              heightFactor: 0.5,
              widthFactor: 0.5,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(200.0)),
                color: Color.fromRGBO(255, 255, 255, 0.4),
                child: SizedBox(
                  width: 500,
                  height: 500,
                ),
              ),
            ),
            _isLoading ? const MyLoadingView() : _loginCenter()
            //_loginCenter()
          ],
        ),
      ),
    );
  }

  Widget _loginCenter() {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Material(
                elevation: 10.0,
                borderRadius: const BorderRadius.all(Radius.circular(150.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/AzureLogo.png",
                    width: 180,
                    height: 180,
                  ),
                )),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: _signIn,
                style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ))),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isLoading = true;
    });

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
