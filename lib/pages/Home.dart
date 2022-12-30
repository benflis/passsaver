import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordsaver/components/emaillist.dart';
import 'package:passwordsaver/components/generalDial.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF038d83),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFd1d4cf),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                Expanded(
                                    child: TextField(
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            DraggableScrollableSheet(
              minChildSize: 0.74,
              initialChildSize: 0.88,
              maxChildSize: 0.88,
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
                              EmailsList(
                            index: index,
                          ),
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
                    pageBuilder: (context, _, __) {
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
