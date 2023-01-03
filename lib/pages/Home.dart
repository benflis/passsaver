import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:passwordsaver/components/emaillist.dart';
import 'package:passwordsaver/components/generalDial.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:passwordsaver/model/item.dart';

import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

final _fireStore = FirebaseFirestore.instance;

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;

  late RiveAnimationController _btnanimation;

  Artboard? _riveArtboard;
  SMIInput<bool>? isOpen;
  StateMachineController? _controller;

  // void togglePlay() {
  //   setState(() {
  //     _menuanimation.isActive = !_menuanimation.isActive;
  //   });
  // }

  // bool get isPlaying => _menuanimation.isActive;
  // SMIInput<bool>? input;
  // Artboard? artboard;

  // initializeArtboard() async {
  //   final data = await rootBundle.load('assets/menu_button.riv');
  //   final file = RiveFile.import(data);
  //   final artboard = file.mainArtboard;
  //   SMIInput<bool>? input;

  //   final controller =
  //       StateMachineController.fromArtboard(artboard, 'State Machine');
  //   if (controller != null) {
  //     artboard.addController(controller);
  //     input = controller.findInput<bool>('isOpen');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _btnanimation = OneShotAnimation('active', autoplay: false);

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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 139, 62, 153),
      drawer: Drawer(),
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
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      _scaffoldKey.currentState!.openDrawer();

                                      isOpen!.value
                                          ? isOpen!.value = false
                                          : isOpen!.value = true;
                                    },
                                  );
                                },
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
                                  ),
                                ),
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
