import 'package:flutter/material.dart';
import 'package:test/model/account.dart';
import 'package:test/pages/detailpage.dart';

Widget listView(List<Account> accounts) {
  return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        //return accountDetailCard(accounts[index]);
        return Card(
          child: ListTile(
            title: Text(accounts[index].name.toString()),
            subtitle: Text(accounts[index].accountnumber.toString()),
            leading: SizedBox(
              width: 100,
              height: 80,
              child: Image.network(accounts[index].entityimageUrl == null
                  ? "https://via.placeholder.com/100x80"
                  : accounts[index].entityimageUrl.toString()),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(accounts[index])));
            },
          ),
        );
      });
}
