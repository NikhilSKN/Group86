import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'PickupRequest.dart';
import 'theme.dart' as Theme;
import 'login_page.dart';
import 'authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final _auth = FirebaseAuth.instance;

  String Emaili = '';

  Future<String> Emailid() async {
    User user = await _auth.currentUser;
    setState(() {
      if (user.phoneNumber != null) {
        Emaili = user.phoneNumber;
      } else {
        Emaili = user.email;
      }
      // print(user.phoneNumber);
    });
  }

  @override
  void initState() {
    Emailid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              // width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.Colors.loginGradientStart,
                      Theme.Colors.loginGradientEnd
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      Emaili,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text(
          //     'Profile',
          //     style: TextStyle(fontSize: 18),
          //   ),
          //   onTap: null,
          // ),
          ListTile(
            leading: Icon(Icons.receipt),
            title: Text(
              'Pickup Request',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => PickupRequest()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.next_week),
            title: Text(
              'About',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Color(0xFF5aff15),
            endIndent: 70,
            indent: 70,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.arrow_back_ios),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () async {
              User user = await _auth.currentUser;
              if (user.providerData[0].providerId == 'google.com') {
                await gooogleSignIn.disconnect();
              }
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('email');
              await _auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route route) => false);
            },
          ),
        ],
      ),
    );
  }
}
