import 'package:flutter/material.dart';
import 'package:test/model/account.dart';
import 'package:test/pages/detailpage.dart';

Widget gridView(List<Account> accounts) {
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
                  Image.network(accounts[index].entityimageUrl == null
                      ? "https://via.placeholder.com/150x120"
                      : accounts[index].entityimageUrl.toString()),
                  Text(
                    accounts[index].name.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        accounts[index].accountnumber.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        accounts[index].statecode.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle, color: Colors.grey[500])),
        ),
      );
    },
  );
}
