import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:provider/provider.dart';

class EmailsList extends StatelessWidget {
  int index;
  EmailsList({required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Text(Provider.of<Data>(context).emaillist[index].email),
            subtitle: Provider.of<Data>(context).visible == true
                ? Text(
                    Provider.of<Data>(context).emaillist[index].password,
                  )
                : null,
            leading: SvgPicture.asset(
              Provider.of<Data>(context).emaillist[index].picture,
              height: 40,
              width: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Divider(
              thickness: 2,
              height: 2,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
