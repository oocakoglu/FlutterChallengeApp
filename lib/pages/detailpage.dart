import 'package:flutter/material.dart';
import 'package:test/apis/localdata.dart';
import 'package:test/model/account.dart';
import 'package:test/model/cstate.dart';

class DetailPage extends StatefulWidget {
  final Account _account;
  const DetailPage(
    this._account, {
    Key? key,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Account _a = widget._account;
    CState _cState = LocalData.getState(_a.address1Stateorprovince.toString());

    return Scaffold(
        appBar: AppBar(
          title: const Text("Account Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(_a.entityimageUrl == null
                  ? "https://via.placeholder.com/150x120"
                  : _a.entityimageUrl.toString()),
              TextField(
                  controller: TextEditingController(text: _a.name.toString()),
                  enabled: false,
                  decoration: const InputDecoration(labelText: "Name")),
              TextField(
                  controller:
                      TextEditingController(text: _a.accountnumber.toString()),
                  enabled: false,
                  decoration: const InputDecoration(labelText: "Number")),
              TextField(
                  controller: TextEditingController(
                      text: _a.address1Country.toString()),
                  enabled: false,
                  decoration: const InputDecoration(labelText: "Country")),
              TextField(
                  controller: TextEditingController(text: _cState.statename),
                  enabled: false,
                  decoration: const InputDecoration(labelText: "State")),
              TextField(
                  controller:
                      TextEditingController(text: _a.emailaddress1.toString()),
                  enabled: false,
                  decoration:
                      const InputDecoration(labelText: "E mail Adress")),
              TextField(
                  controller:
                      TextEditingController(text: _a.websiteurl.toString()),
                  enabled: false,
                  decoration: const InputDecoration(labelText: "Web Site")),
              TextField(
                  controller: TextEditingController(
                      text: _a.address1Composite.toString()),
                  enabled: false,
                  decoration:
                      const InputDecoration(labelText: "Composite Adress")),
            ],
          ),
        ));
  }
}
