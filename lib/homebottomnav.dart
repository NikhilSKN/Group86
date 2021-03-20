import 'package:flutter/material.dart';
import 'Home_page.dart';
import 'Schedule_page.dart';
import 'theme.dart' as Theme;
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'main_drawer.dart';

class Homebottomnav extends StatefulWidget {
  @override
  _HomebottomnavState createState() => _HomebottomnavState();
}

class _HomebottomnavState extends State<Homebottomnav> {
  double latitude;
  double longitude;
  String _city = 'City';
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour >= 4 && hour < 12) {
      return 'Good Morning!';
    }
    if (hour >= 12 && hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }

  void getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      latitude = position.latitude;
      longitude = position.longitude;
      setState(() {
        _city = first.locality;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MainDrawer(),
      body: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: <Widget>[
              ClipPath(
                clipper: ClippingClass(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 4 / 7,
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
                ),
              ),
              AppBar(
                toolbarHeight: 60,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Text(
                      _city,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dashed,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          getLocation();
                        },
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      )),
                ],
                actionsIconTheme: IconThemeData(
                  size: 40.0,
                  color: Colors.white,
                  opacity: 10.0,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 100),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset("assets/logo.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 4 / 7 - 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TypewriterAnimatedTextKit(
                              text: ['Hi Nikhil'],
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(greeting(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              )),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/truck.png'),
                            // fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        child: Text("Get Started! ",
                            style: TextStyle(
                              color: Color(0xFF505050),
                              fontSize: 25,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Container(
                      child: Text("Sell scrap from your doorstep.",
                          style: TextStyle(
                            color: Color(0xFF505050),
                            fontSize: 15,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // _customCard(
                  //     imageUrl: "recycle.png", item: "Wash", duration: "1 Day"),
                  Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return StepperSchedule();
                          },
                          // settings: RouteSettings(name: "/Homepage"),
                        ));
                      },
                      backgroundColor: Color(0xFF5aff15),
                      elevation: 10,
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_customCard({String imageUrl, String item, String duration}) {
  return SizedBox(
    height: 200,
    width: 150,
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/" + imageUrl),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item,
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(duration)
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
