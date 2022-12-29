import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:passwordsaver/components/emaillist.dart';
import 'package:passwordsaver/model/data.dart';

import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF038d83),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'icons/menu-svgrepo-com.svg',
                                height: 24,
                                width: 24,
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  CircleAvatar(
                                    radius: 23,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            DraggableScrollableSheet(
              minChildSize: 0.13,
              initialChildSize: 0.70,
              maxChildSize: 0.80,
              builder: (context, scrollController) {
                scrollController.addListener((() {
                  if (scrollController.initialScrollOffset == 0.1) {}
                }));
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 150, left: 150),
                        child: Divider(
                          thickness: 4,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: Provider.of<Data>(context).getCount(),
                          controller: scrollController,
                          itemBuilder: (BuildContext context, int index) =>
                              EmailsList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 10,
              left: 30,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: 'Add Entry',
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return GeneralDial();
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.white70,
                    //     offset: Offset(-5, -5),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    //   BoxShadow(
                    //     color: Colors.white10,
                    //     offset: Offset(5, 5),
                    //     blurRadius: 15,
                    //     spreadRadius: 1,
                    //   ),
                    // ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add new entry",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  // child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           selectedIndex = 0;
                  //         });
                  //       },
                  //       child: BottomNavItem(
                  //         pic: 'icons/home-svgrepo-com.svg',
                  //         selectedIndex: selectedIndex,
                  //         index: 0,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           selectedIndex = 1;
                  //         });
                  //       },
                  //       child: BottomNavItem(
                  //         pic: 'icons/home-svgrepo-com.svg',
                  //         selectedIndex: selectedIndex,
                  //         index: 1,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           selectedIndex = 2;
                  //         });
                  //       },
                  //       child: BottomNavItem(
                  //         pic: 'icons/home-svgrepo-com.svg',
                  //         selectedIndex: selectedIndex,
                  //         index: 2,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           selectedIndex = 3;
                  //         });
                  //       },
                  //       child: BottomNavItem(
                  //         pic: 'icons/home-svgrepo-com.svg',
                  //         selectedIndex: selectedIndex,
                  //         index: 3,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GeneralDial extends StatefulWidget {
  @override
  State<GeneralDial> createState() => _GeneralDialState();
}

class _GeneralDialState extends State<GeneralDial> {
  List<String> items = [
    'icons/yahoo-svgrepo-com.svg',
    'icons/new-logo-gmail-svgrepo-com.svg',
    'icons/github-svgrepo-com.svg'
  ];

  String dropDownItem = 'icons/yahoo-svgrepo-com.svg';

  @override
  Widget build(BuildContext context) {
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
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 28),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: SvgPicture.asset(
                                  'icons/mail-svgrepo-com.svg',
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
                            onPressed: () {},
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 28,
                            )),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(24),
                                        bottomLeft: Radius.circular(24),
                                        bottomRight: Radius.circular(24)))),
                            onPressed: () {},
                            child: Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 28,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 0,
                right: 1,
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
