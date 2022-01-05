import 'package:flutter/material.dart';
import 'package:test/model/account.dart';
import 'package:test/widgets/myaddresscard.dart';
import 'package:test/widgets/myimageview.dart';

class DetailPage extends StatelessWidget {
  final Account _account;

  const DetailPage(
    this._account, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Account Details"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyImageView(
                entitityImage: _account.entityimage,
                imageWidth: 250,
                imageHeight: 250,
              ),
              TextField(
                  controller:
                      TextEditingController(text: _account.name.toString()),
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(
                        Icons.account_balance,
                        color: Colors.blue.shade700,
                      ))),
              TextField(
                controller: TextEditingController(
                    text: _account.accountnumber.toString()),
                enabled: false,
                decoration: InputDecoration(
                    labelText: "Number",
                    prefixIcon: Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Colors.blue.shade700,
                    )),
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone_android_rounded,
                      color: Colors.blue.shade700,
                    ),
                    labelText: "Phone Number"),
                controller:
                    TextEditingController(text: _account.telephone1.toString()),
                enabled: false,
              ),
              TextField(
                  controller: TextEditingController(
                      text: _account.emailaddress1.toString()),
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "E mail Adress",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue.shade700,
                    ),
                  )),
              TextField(
                  controller: TextEditingController(
                      text: _account.websiteurl.toString()),
                  enabled: false,
                  decoration: InputDecoration(
                      labelText: "Web Site",
                      prefixIcon: Icon(
                        Icons.web,
                        color: Colors.blue.shade700,
                      ))),
              TextField(
                  controller: TextEditingController(
                      text: _account.address1Composite.toString()),
                  enabled: false,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      labelText: "Composite Adress",
                      prefixIcon: Icon(
                        Icons.home_filled,
                        color: Colors.blue,
                      ))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: MyAddressCard(
                  city: _account.address1City,
                  stateCode: _account.address1Stateorprovince,
                  countryName: _account.address1Country,
                  mainAxisAlignment: MainAxisAlignment.start,
                  textSize: 18,
                ),
              ),
            ],
          ),
        ));
  }
}
