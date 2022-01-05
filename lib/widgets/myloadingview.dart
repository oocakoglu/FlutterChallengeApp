import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoadingView extends StatelessWidget {
  const MyLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitCircle(
      color: Colors.black,
      size: 80.0,
    );
  }
}
