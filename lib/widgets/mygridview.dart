import 'package:flutter/material.dart';
import 'package:test/model/account.dart';
import 'package:test/pages/detailpage.dart';
import 'package:test/widgets/myaddresscard.dart';
import 'package:test/widgets/myimageview.dart';

class MyGridView extends StatelessWidget {
  final List<Account> accounts;
  const MyGridView({Key? key, required this.accounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(accounts[index])));
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MyImageView(
                    entitityImage: accounts[index].entityimage,
                    imageWidth: 150,
                    imageHeight: 150,
                  ),
                  Text(
                    accounts[index].name.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: MyAddressCard(
                      city: accounts[index].address1City,
                      stateCode: accounts[index].address1Stateorprovince,
                      countryName: accounts[index].address1Country,
                      textSize: 12,
                    ),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                //color: Colors.grey[50],
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
