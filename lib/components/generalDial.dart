import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordsaver/model/data.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class GeneralDial extends StatefulWidget {
  @override
  State<GeneralDial> createState() => _GeneralDialState();
}

class _GeneralDialState extends State<GeneralDial>
    with SingleTickerProviderStateMixin {
  late RiveAnimationController _btnanimation;
  List<String> items = [
    'icons/Yahoo.svg',
    'icons/Gmail.svg',
    'icons/Github.svg',
    'icons/Spotify.svg',
    'icons/Facebook.svg',
  ];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String? email;
  String? password;
  String? picture;
  String dropDownItem = 'icons/Yahoo.svg';
  final _fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _btnanimation = OneShotAnimation('active', autoplay: false);
  }

  @override
  Widget build(BuildContext context) {
    picture = dropDownItem;
    return Stack(
      children: [
        Container(
          height: 650,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          padding: EdgeInsets.only(top: 30, right: 20, left: 20),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 206, 213, 216),
              borderRadius: BorderRadius.circular(25)),
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
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Email(),
                            SizedBox(
                              height: 20,
                            ),
                            Password(),
                            SizedBox(
                              height: 20,
                            ),
                            Company(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                onPressed: () {
                                  emailController.clear();
                                  passController.clear();
                                },
                                child: SvgPicture.asset(
                                  'icons/Reset.svg',
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            //play animation
                            _btnanimation.isActive = true;
                            if (_formKey.currentState!.validate()) {
                              // add data to the cloud firestore
                              _fireStore.collection('Information').add({
                                'Email': email,
                                'Password': password,
                                'Picture': picture,
                                'Time': Timestamp.now(),
                              });

                              // add data locally

                              Provider.of<Data>(context, listen: false)
                                  .setEmail(email);
                              Provider.of<Data>(context, listen: false)
                                  .setPass(password);
                              Provider.of<Data>(context, listen: false)
                                  .setPic(picture);
                              Provider.of<Data>(context, listen: false)
                                  .addEmail(
                                      Provider.of<Data>(context, listen: false)
                                          .email!,
                                      Provider.of<Data>(context, listen: false)
                                          .password!,
                                      Provider.of<Data>(context, listen: false)
                                          .picture!);

                              emailController.clear();
                              passController.clear();

                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 64,
                            width: 236,
                            child: Stack(
                              children: [
                                RiveAnimation.asset(
                                  'assets/submit.riv',
                                  controllers: [_btnanimation],
                                ),
                                Positioned.fill(
                                    top: 4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Submit',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        SvgPicture.asset(
                                          'icons/arrow_right.svg',
                                          color: Colors.blue,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CloseButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

///////////////////Created Widgets///////////////////

  Widget Email() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Field can not be empty";
          }
          return null;
        },
        onSaved: (newValue) {},
        controller: emailController,
        onChanged: (value) {
          email = value;
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 10),
            child: SvgPicture.asset(
              'icons/mail.svg',
              height: 20,
              width: 20,
            ),
          ),
          label: Text('Email'),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget Password() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Field can not be empty";
          }
          return null;
        },
        onSaved: (newValue) {},
        controller: passController,
        onChanged: (value) {
          password = value;
        },
        style: TextStyle(fontSize: 18),
        obscureText: Provider.of<Data>(context).visible == false ? true : false,
        decoration: InputDecoration(
            labelStyle: TextStyle(),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 10),
              child: SvgPicture.asset(
                'icons/passwordLock.svg',
                height: 28,
                width: 28,
              ),
            ),
            label: Text('Password'),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12)),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
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
                  Provider.of<Data>(context, listen: false).changeVisibility();
                },
              ),
            )),
      ),
    );
  }

  Widget Company() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        child: DropdownButtonFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "";
            }
            return null;
          },
          onSaved: (newValue) {},
          elevation: 16,
          iconSize: 20,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(12)),
              label: Text('Company'),
              floatingLabelBehavior: FloatingLabelBehavior.always),
          value: dropDownItem,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(
              value: value,
              child: SvgPicture.asset(
                value,
                height: 25,
                width: 25,
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
    );
  }
}

class CloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(radius: 18, child: Icon(Icons.close))),
    );
  }
}
