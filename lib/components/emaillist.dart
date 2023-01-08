import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:provider/provider.dart';

class EmailsList extends StatelessWidget {
  int index;
  bool origOrFill;
  EmailsList({required this.index, required this.origOrFill});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          ListTile(
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
