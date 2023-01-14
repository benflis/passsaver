import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:passwordsaver/components/emaillist.dart';
import 'package:passwordsaver/components/generalDial.dart';

import 'package:passwordsaver/model/data.dart';
import 'package:passwordsaver/model/item.dart';

import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

int selectedIndex = 0;
TextEditingController Search = TextEditingController();

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

final _fireStore = FirebaseFirestore.instance;

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late RiveAnimationController _btnanimation;

  Artboard? _riveArtboard;
  SMIInput<bool>? isOpen;
  StateMachineController? _controller;

  late AnimationController controller;
  late Animation<Offset> animation;

  ScrollController scroller = ScrollController();

  bool active = false;
  List items = [
    ['GitHub', 'icons/Github.svg'],
    ['Yahoo', 'icons/Yahoo.svg'],
    ['Gmail', 'icons/Gmail.svg'],
    ['Spotify', 'icons/Spotify.svg'],
    ['Facebook', 'icons/Facebook.svg'],
    ['Reset', 'icons/Reset.svg'],
  ];

  void selectedCategory() {
    var result;
    switch (selectedIndex) {
      case 0:
        {
          result = Provider.of<Data>(context, listen: false)
              .emaillist
              .where((element) {
            return element.picture.contains('Github');
          }).toList();

          Provider.of<Data>(context, listen: false).addSearch(result);
          print(Provider.of<Data>(context, listen: false).filteredList.length);
        }
        break;

      case 1:
        {
          result = Provider.of<Data>(context, listen: false)
              .emaillist
              .where((element) {
            return element.picture.contains('Yahoo');
          }).toList();

          Provider.of<Data>(context, listen: false).addSearch(result);
          print(Provider.of<Data>(context, listen: false).filteredList.length);
        }
        break;
      case 2:
        {
          result = Provider.of<Data>(context, listen: false)
              .emaillist
              .where((element) {
            return element.picture.contains('Gmail');
          }).toList();

          Provider.of<Data>(context, listen: false).addSearch(result);
        }
        break;
      case 3:
        {
          result = Provider.of<Data>(context, listen: false)
              .emaillist
              .where((element) {
            return element.picture.contains('Spotify');
          }).toList();

          Provider.of<Data>(context, listen: false).addSearch(result);
        }
        break;
      case 4:
        {
          result = Provider.of<Data>(context, listen: false)
              .emaillist
              .where((element) {
            return element.picture.contains('Facebook');
          }).toList();

          Provider.of<Data>(context, listen: false).addSearch(result);
        }
        break;
      case 5:
        {
          setState(() {
            active = false;
          });

          Provider.of<Data>(context, listen: false).emptySearch();
        }
        break;
    }
  }

  void search(String query) {
    var result;
    if (query.isEmpty) {
      result = Provider.of<Data>(context, listen: false).emaillist;
    } else {
      result =
          Provider.of<Data>(context, listen: false).emaillist.where((element) {
        return element.email.contains(query);
      }).toList();
    }

    Provider.of<Data>(context, listen: false).addSearch(result);
  }

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
                          SizedBox(
                            height: 90,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 10, horizontal: 20),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Hero(
                          //         tag: 'open',
                          //         child: GestureDetector(
                          //           onTap: () {
                          //             setState(
                          //               () {
                          //                 if (isOpen!.value == true) {
                          //                   isOpen!.value = false;
                          //                   _scaffoldKey.currentState!
                          //                       .openDrawer();
                          //                 } else {
                          //                   isOpen!.value = true;
                          //                   _scaffoldKey.currentState!
                          //                       .closeDrawer();
                          //                 }
                          //               },
                          //             );
                          //           },
                          //           child: SlideTransition(
                          //             position: animation,
                          //             child: Container(
                          //               height: 50,
                          //               width: 50,
                          //               child: _riveArtboard == null
                          //                   ? const SizedBox()
                          //                   : Rive(
                          //                       artboard: _riveArtboard!,
                          //                     ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          SearchBox(
                            onChanged: ((p0) => search(p0)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              height: 100,
                              child: ListView.builder(
                                controller: scroller,
                                itemCount: items.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Category(
                                  index: index,
                                  items: items,
                                  active: active,
                                  selectedindex: selectedIndex,
                                  onTap: () {
                                    setState(
                                      () {
                                        selectedIndex = index;
                                        active = true;

                                        if (selectedIndex == items.length - 1) {
                                          active = false;
                                          scroller.animateTo(0,
                                              duration:
                                                  Duration(milliseconds: 600),
                                              curve: Curves.fastOutSlowIn);
                                        }
                                        selectedCategory();
                                      },
                                    );
                                  },
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
                    padding: EdgeInsets.only(bottom: 80),
                    margin: EdgeInsets.only(top: 20),
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
                          active: active,
                        )
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _btnanimation.isActive = true;
                    Future.delayed(
                      Duration(milliseconds: 760),
                      () {
                        customGeneralGialog(context);
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Object?> customGeneralGialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 400),
      transitionBuilder: (_, animation, __, child) {
        Tween<Offset> tween;
        tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      barrierLabel: 'Add Entry',
      pageBuilder: (context, animation, __) {
        return GeneralDial();
      },
    );
  }
}

class SearchBox extends StatelessWidget {
  void Function(String)? onChanged;
  SearchBox({required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 19, horizontal: 18),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: onChanged,
                controller: Search,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'icons/Search.svg',
                      height: 18,
                      width: 18,
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 216, 218, 221),
                ),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'X',
                  style: TextStyle(color: Color(0xFF959eab)),
                )),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  Category(
      {required this.index,
      required this.selectedindex,
      required this.onTap,
      required this.active,
      required this.items});

  int index;
  int selectedindex;
  void Function()? onTap;
  bool active;

  List items;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 130,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: selectedindex == index && active
                ? Color(0xFF4e8dff)
                : Colors.white,
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
      ),
    );
  }
}

class StreamOfEmails extends StatelessWidget {
  ScrollController scrollController;
  bool active;
  StreamOfEmails({required this.scrollController, required this.active});
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
          child: (Search.text.isEmpty &&
                  Provider.of<Data>(context).filteredList.length == 0 &&
                  active == false)
              ? ListView.builder(
                  controller: scrollController,
                  itemCount: Provider.of<Data>(context).getCountOriginalList(),
                  itemBuilder: (BuildContext context, int index) => EmailsList(
                    origOrFill: true,
                    index: index,
                  ),
                )
              : ListView.builder(
                  controller: scrollController,
                  itemCount: Provider.of<Data>(context).getCountFilteredList(),
                  itemBuilder: (BuildContext context, int index) => EmailsList(
                    origOrFill: false,
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
