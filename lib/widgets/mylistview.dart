import 'package:flutter/material.dart';
import 'package:test/model/account.dart';
import 'package:test/pages/detailpage.dart';
import 'package:test/widgets/myaddresscard.dart';
import 'package:test/widgets/myimageview.dart';

class MyListView extends StatelessWidget {
  final List<Account> accounts;
  const MyListView({Key? key, required this.accounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  accounts[index].name.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.blue.shade700,
                          size: 16.0,
                        ),
                        Text(accounts[index].accountnumber.toString()),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_android_rounded,
                          color: Colors.blue.shade700,
                          size: 16.0,
                        ),
                        Text(accounts[index].telephone1.toString()),
                      ],
                    ),
                    const SizedBox(height: 3),
                    MyAddressCard(
                      city: accounts[index].address1City,
                      stateCode: accounts[index].address1Stateorprovince,
                      countryName: accounts[index].address1Country,
                      mainAxisAlignment: MainAxisAlignment.end,
                      iconPosition: IconPosition.pLast,
                      textSize: 13,
                    ),
                  ],
                ),
              ),
              leading: SizedBox(
                  width: 100,
                  height: 100,
                  child: MyImageView(
                    entitityImage: accounts[index].entityimage,
                    imageWidth: 100,
                    imageHeight: 100,
                  )),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPage(accounts[index])));
              },
            ),
          );
        });
  }
}
