import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:provider/provider.dart';

class EmailsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        title: Text(Provider.of<Data>(context).emaillist[0].email),
        subtitle: Text(Provider.of<Data>(context).emaillist[0].password),
        leading: SvgPicture.asset(
          Provider.of<Data>(context).emaillist[0].picture,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}
