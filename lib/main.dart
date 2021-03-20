import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'theme.dart' as Theme;
import 'dart:async';
import 'OnBoarding_page.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

// const kBackgroundColor = Color(0xFF202020);
const kPrimaryColor = Color(0xFF5aff15);

int initScreen;
String finalEmail;
var userlog;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF5aff15),
      ),
      home: WelcomePage(),
      routes: {
        '/Homepage': (context) => Homepage(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => new _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _auth = FirebaseAuth.instance;
  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  Future<void> navigationPage() async {
    getValidationData().whenComplete(() async {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return initScreen == 0 || initScreen == null
            ? OnBoardingPage()
            : (finalEmail == null) ? LoginPage() : Homepage();
      }));
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: Container(
            width: double.infinity,
            height: double.infinity,
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
            child: Image.asset('assets/logo.png')),
      ),
    );
  }
}
