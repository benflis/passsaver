import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:passwordsaver/components/emaillist.dart';
import 'package:passwordsaver/components/generalDial.dart';
import 'package:passwordsaver/main.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:passwordsaver/model/item.dart';

import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

final _fireStore = FirebaseFirestore.instance;

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  late RiveAnimationController _btnanimation;

  Artboard? _riveArtboard;
  SMIInput<bool>? isOpen;
  StateMachineController? _controller;

  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    _btnanimation = OneShotAnimation('active', autoplay: false);

    controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 500),
    );

    final curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation =
        Tween<Offset>(begin: Offset.zero, end: Offset(6, 0)).animate(curve);

    rootBundle.load('assets/menu_button.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final riveArtboard = file.mainArtboard;
        if (riveArtboard != null) {
          var controller = StateMachineController.fromArtboard(
              riveArtboard, 'State Machine');

          _controller = controller;

          if (_controller != null) {
            riveArtboard.addController(_controller!);
            isOpen = controller!.findInput('isOpen');
            _controller!.isActive = false;
            isOpen!.value = true;
          }
        }
        setState(
          () {
            _riveArtboard = riveArtboard;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      onDrawerChanged: (isOpened) {
        setState(() {
          if (isOpened) {
            isOpen!.value = false;
            controller.forward();
          } else {
            isOpen!.value = true;
            controller.reverse();
          }
        });
      },
      drawer: Drawer(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/3386851.jpg'), fit: BoxFit.cover),
          ),
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
                                Hero(
                                  tag: 'open',
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          if (isOpen!.value == true) {
                                            isOpen!.value = false;
                                            _scaffoldKey.currentState!
                                                .openDrawer();
                                          } else {
                                            isOpen!.value = true;
                                            _scaffoldKey.currentState!
                                                .closeDrawer();
                                          }
                                        },
                                      );
                                    },
                                    child: SlideTransition(
                                      position: animation,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: _riveArtboard == null
                                            ? const SizedBox()
                                            : Rive(
                                                artboard: _riveArtboard!,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF0c8cff),
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              height: 100,
                              child: ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Category(
                                  index: index,
                                ),
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
                minChildSize: 0.5,
                initialChildSize: 0.88,
                maxChildSize: 0.88,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 222, 225, 226),
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
                        StreamOfEmails(
                          scrollController: scrollController,
                        )
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 10,
                left: 40,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _btnanimation.isActive = true;
                        Future.delayed(
                          Duration(milliseconds: 1000),
                          () {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'Add Entry',
                              pageBuilder: (context, _, __) {
                                return GeneralDial();
                              },
                            );
                          },
                        );
                      },

                      child: Container(
                        height: 64,
                        width: 236,
                        child: Stack(
                          children: [
                            RiveAnimation.asset(
                              'assets/button.riv',
                              controllers: [_btnanimation],
                            ),
                            Positioned.fill(
                              top: 8,
                              child: Center(
                                child: Text(
                                  'Add New Entry',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // child: Container(
                      //   alignment: Alignment.center,
                      //   height: 60,
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Colors.black,
                      //     // boxShadow: [
                      //     //   BoxShadow(
                      //     //     color: Colors.white70,
                      //     //     offset: Offset(-5, -5),
                      //     //     blurRadius: 15,
                      //     //     spreadRadius: 1,
                      //     //   ),
                      //     //   BoxShadow(
                      //     //     color: Colors.white10,
                      //     //     offset: Offset(5, 5),
                      //     //     blurRadius: 15,
                      //     //     spreadRadius: 1,
                      //     //   ),
                      //     // ],
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         Icons.add,
                      //         color: Colors.white,
                      //         size: 40,
                      //       ),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       Text(
                      //         "Add new entry",
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 25,
                      //             fontWeight: FontWeight.w900),
                      //       ),
                      //     ],
                      //   ),

                      //   // child: Row(
                      //   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   //   children: [
                      //   //     GestureDetector(
                      //   //       onTap: () {
                      //   //         setState(() {
                      //   //           selectedIndex = 0;
                      //   //         });
                      //   //       },
                      //   //       child: BottomNavItem(
                      //   //         pic: 'icons/home-svgrepo-com.svg',
                      //   //         selectedIndex: selectedIndex,
                      //   //         index: 0,
                      //   //       ),
                      //   //     ),
                      //   //     GestureDetector(
                      //   //       onTap: () {
                      //   //         setState(() {
                      //   //           selectedIndex = 1;
                      //   //         });
                      //   //       },
                      //   //       child: BottomNavItem(
                      //   //         pic: 'icons/home-svgrepo-com.svg',
                      //   //         selectedIndex: selectedIndex,
                      //   //         index: 1,
                      //   //       ),
                      //   //     ),
                      //   //     GestureDetector(
                      //   //       onTap: () {
                      //   //         setState(() {
                      //   //           selectedIndex = 2;
                      //   //         });
                      //   //       },
                      //   //       child: BottomNavItem(
                      //   //         pic: 'icons/home-svgrepo-com.svg',
                      //   //         selectedIndex: selectedIndex,
                      //   //         index: 2,
                      //   //       ),
                      //   //     ),
                      //   //     GestureDetector(
                      //   //       onTap: () {
                      //   //         setState(() {
                      //   //           selectedIndex = 3;
                      //   //         });
                      //   //       },
                      //   //       child: BottomNavItem(
                      //   //         pic: 'icons/home-svgrepo-com.svg',
                      //   //         selectedIndex: selectedIndex,
                      //   //         index: 3,
                      //   //       ),
                      //   //     ),
                      //   //   ],
                      //   // ),
                      // ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Provider.of<Data>(context).visible == true
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  Category({required this.index});

  int index;

  List items = [
    ['GitHub', 'icons/github-svgrepo-com.svg'],
    ['Yahoo', 'icons/yahoo-svgrepo-com.svg'],
    ['Gmail', 'icons/new-logo-gmail-svgrepo-com.svg'],
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              items[index][1],
              height: 42,
              width: 42,
            ),
            Text(items[index][0])
          ],
        ),
      ),
    );
  }
}

class StreamOfEmails extends StatelessWidget {
  ScrollController scrollController;
  StreamOfEmails({required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs;
        final List<ItemEmail> list = [];
        for (var M in messages) {
          final messageEmail = M['Email'];
          final messagePassword = M['Password'];
          final messagePicture = M['Picture'];

          list.add(
            ItemEmail(
                email: messageEmail,
                password: messagePassword,
                picture: messagePicture),
          );
        }
        Provider.of<Data>(context).addEmails(list);

        return Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: Provider.of<Data>(context).getCount(),
            itemBuilder: (BuildContext context, int index) => EmailsList(
              index: index,
            ),
          ),
        );
      },
      stream: _fireStore
          .collection('Information')
          .orderBy('Time', descending: true)
          .snapshots(),
    );
  }
}
