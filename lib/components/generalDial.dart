import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:provider/provider.dart';

class GeneralDial extends StatefulWidget {
  @override
  State<GeneralDial> createState() => _GeneralDialState();
}

class _GeneralDialState extends State<GeneralDial> {
  List<String> items = [
    'icons/yahoo-svgrepo-com.svg',
    'icons/new-logo-gmail-svgrepo-com.svg',
    'icons/github-svgrepo-com.svg',
  ];

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String? email;
  String? password;
  String? picture;
  String dropDownItem = 'icons/yahoo-svgrepo-com.svg';

  @override
  Widget build(BuildContext context) {
    picture = dropDownItem;
    return Container(
      height: 650,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Text(
                    "Information",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'add your email, password, and the domain the email is associated with.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailController,
                            onChanged: (value) {
                              email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 28),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: SvgPicture.asset(
                                  'icons/mail-full-svgrepo-com.svg',
                                  height: 38,
                                  width: 38,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Password',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passController,
                            onChanged: (value) {
                              password = value;
                            },
                            style: TextStyle(fontSize: 28),
                            obscureText:
                                Provider.of<Data>(context).visible == false
                                    ? true
                                    : false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: SvgPicture.asset(
                                    'icons/user-password-svgrepo-com.svg',
                                    height: 38,
                                    width: 38,
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: Provider.of<Data>(context).visible ==
                                            true
                                        ? Icon(
                                            Icons.visibility,
                                            color: Colors.black,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: Colors.black,
                                          ),
                                    onPressed: () {
                                      Provider.of<Data>(context, listen: false)
                                          .changeVisibility();
                                    },
                                  ),
                                )),
                          ),
                        ),
                        Text(
                          'Company',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 70,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              value: dropDownItem,
                              items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: SvgPicture.asset(
                                    value,
                                    height: 38,
                                    width: 38,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropDownItem = value!;
                                  picture = value;
                                });
                              },
                            ),
                          ),
                          // child: TextFormField(
                          //   keyboardType: TextInputType.emailAddress,
                          //   style: TextStyle(fontSize: 28),
                          //   decoration: InputDecoration(
                          //     border:
                          //         OutlineInputBorder(borderSide: BorderSide.none),
                          //     prefixIcon: Padding(
                          //       padding: const EdgeInsets.only(right: 20.0),
                          //       child: SvgPicture.asset(
                          //         'icons/email-files-letter-svgrepo-com.svg',
                          //         height: 38,
                          //         width: 38,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(24),
                                      bottomLeft: Radius.circular(24),
                                      bottomRight: Radius.circular(24)))),
                          onPressed: () {
                            emailController.clear();
                            passController.clear();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Provider.of<Data>(context, listen: false)
                                .setEmail(email);
                            Provider.of<Data>(context, listen: false)
                                .setPass(password);
                            Provider.of<Data>(context, listen: false)
                                .setPic(picture);
                            Provider.of<Data>(context, listen: false).addEmail(
                                Provider.of<Data>(context, listen: false)
                                    .email!,
                                Provider.of<Data>(context, listen: false)
                                    .password!,
                                Provider.of<Data>(context, listen: false)
                                    .picture!);
                            emailController.clear();
                            passController.clear();
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_right_alt_outlined,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(radius: 18, child: Icon(Icons.close))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
