import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:provider/provider.dart';

class EmailsList extends StatelessWidget {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('Information');

  int index;
  bool origOrFill;
  EmailsList({required this.index, required this.origOrFill});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        margin: EdgeInsets.only(bottom: 3),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25), topLeft: Radius.circular(25)),
            color: Colors.white),
        child: ListTile(
          onTap: () {
            Provider.of<Data>(context).changeVisibility();
          },
          title: origOrFill
              ? Text(Provider.of<Data>(context).emaillist[index].email)
              : Text(Provider.of<Data>(context).filteredList[index].email),
          subtitle: Provider.of<Data>(context).visible == true
              ? (origOrFill
                  ? Text(
                      Provider.of<Data>(context).emaillist[index].password,
                    )
                  : Text(
                      Provider.of<Data>(context).filteredList[index].password,
                    ))
              : null,
          leading: origOrFill
              ? SvgPicture.asset(
                  Provider.of<Data>(context).emaillist[index].picture,
                  height: 40,
                  width: 40,
                )
              : SvgPicture.asset(
                  Provider.of<Data>(context).filteredList[index].picture,
                  height: 40,
                  width: 40,
                ),
        ),
      ),
    );
  }
}
