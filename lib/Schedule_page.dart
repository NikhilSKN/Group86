import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home_page.dart';
import 'package:intl/intl.dart';
import 'Confirm_page.dart';
import 'theme.dart' as Themes;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class Schedule extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Color(0xFF5aff15),
//       ),
//       home: StepperSchedule(),
//     );
//   }
// }

class StepperSchedule extends StatefulWidget {
  @override
  _StepperScheduleState createState() => _StepperScheduleState();
}

class _StepperScheduleState extends State<StepperSchedule> {
  int _currentStep = 0;
  double latitude;
  double longitude;
  String sender;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  final _auth = FirebaseAuth.instance;
  final String _status = 'Booked';
  User loggedInUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    _addresscontroller.dispose();
    _landmarkcontroller.dispose();
    _phonecontroller.dispose();
    super.dispose();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        if (loggedInUser.email != null) {
          sender = loggedInUser.email;
        } else {
          sender = loggedInUser.phoneNumber;
        }
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> _date = [
    DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(new Duration(days: 1)))
        .toString(),
    DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(new Duration(days: 2)))
        .toString(),
    DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(new Duration(days: 3)))
        .toString(),
    DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(new Duration(days: 4)))
        .toString(),
    DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(new Duration(days: 5)))
        .toString(),
    DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(new Duration(days: 6)))
        .toString(),
    DateFormat("yyyy-MM-dd")
        .format(DateTime.now().add(new Duration(days: 7)))
        .toString(),
  ];
  List<String> _time = [
    '10 am - 12 pm',
    '12 pm - 2 pm',
    '2 pm - 4 pm',
    '4 pm - 6 pm'
  ];

  String _selecteddate;
  String _selectedtime;
  var _addresscontroller = TextEditingController();
  var _phonecontroller = TextEditingController();
  var _landmarkcontroller = TextEditingController();

  Future<String> getLocation() async {
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
      print("${first.addressLine}");
      setState(() {
        _addresscontroller.text = first.addressLine;
      });
      return first.addressLine;
    } catch (e) {
      print(e);
    }
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
        title: Text(_currentStep == 0 ? 'Select Date' : ""),
        isActive: _currentStep >= 0,
        state: StepState.indexed,
        content: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Select Pickup Date',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505050),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                      color: Color(0xFF5aff15),
                      style: BorderStyle.solid,
                      width: 2.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text(
                      'Please choose a Date',
                    ), // Not necessary for Option 1
                    value: _selecteddate,

                    onChanged: (newValue) {
                      setState(() {
                        _selecteddate = newValue;
                      });
                    },
                    items: _date.map((date) {
                      return DropdownMenuItem(
                        child: new Text(date),
                        value: date,
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Our Pickup executives will arrive on the selected pickup date.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Note: Same day Pickup coming soon.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      Step(
        isActive: _currentStep >= 1,
        state: StepState.indexed,
        title: Text(_currentStep == 1 ? 'Select Time' : ""),
        content: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Select Pickup Time',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505050),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                      color: Color(0xFF5aff15),
                      style: BorderStyle.solid,
                      width: 2.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text(
                        'Please choose a Time-Slot'), // Not necessary for Option 1
                    value: _selectedtime,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedtime = newValue;
                      });
                    },
                    items: _time.map((time) {
                      return DropdownMenuItem(
                        child: new Text(time),
                        value: time,
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Our Pickup executives will arrive anytime at the selected time-slot.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Note: Pickup executives will call you before coming.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      Step(
        isActive: _currentStep >= 2,
        state: StepState.indexed,
        title: Text(_currentStep == 2 ? 'Details' : ""),
        content: Column(
          children: <Widget>[
            Text(
              'Enter Details',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF505050),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                    color: Color(0xFF5aff15),
                    style: BorderStyle.solid,
                    width: 2.0),
              ),
              child: TextField(
                controller: _addresscontroller,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Enter Address",
                  labelText: 'Address',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        getLocation();
                      });
                    },
                    icon: Icon(Icons.my_location),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                    color: Color(0xFF5aff15),
                    style: BorderStyle.solid,
                    width: 2.0),
              ),
              child: TextFormField(
                controller: _landmarkcontroller,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: 'Landmark',
                  hintText: "Enter Landmark",
                ),
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(
                    color: Color(0xFF5aff15),
                    style: BorderStyle.solid,
                    width: 2.0),
              ),
              child: TextFormField(
                controller: _phonecontroller,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: 'Mobile Number',
                  hintText: "Enter Mobile Number",
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            'Kabadify',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _onStepCancel();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )),
          ],
          actionsIconTheme: IconThemeData(
            size: 30.0,
            color: Colors.white,
            opacity: 10.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Color(0xFF5aff15),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              gradient: new LinearGradient(
                  colors: [
                    Themes.Colors.loginGradientStart,
                    Themes.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          Form(
            child: Stepper(
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                _onStepContinue = onStepContinue;
                _onStepCancel = onStepCancel;
                return SizedBox.shrink();
              },
              steps: _stepper(),
              type: StepperType.horizontal,
              physics: ClampingScrollPhysics(),
              currentStep: this._currentStep,
              onStepContinue: () {
                setState(() {
                  if (this._currentStep < this._stepper().length - 1) {
                    this._currentStep = this._currentStep + 1;
                  } else {
                    _firestore
                        .collection('schedule')
                        .doc(_auth.currentUser.uid)
                        .collection('Perschedule')
                        .add({
                      'Sender': sender + '    ' + _phonecontroller.text,
                      'Landmark': _landmarkcontroller.text,
                      'Status': _status,
                      'Date': _selecteddate,
                      'Mobile Number': _phonecontroller.text,
                      'Time': _selectedtime,
                      'Address': _addresscontroller.text,
                    });
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return ConfirmPage(
                        Orderdate: _selecteddate,
                        Ordertime: _selectedtime,
                        Orderstatus: _status,
                        Orderaddress: _addresscontroller.text,
                        OrderLandmark: _landmarkcontroller.text,
                        OrderMobile: _phonecontroller.text,
                      );
                    }));
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (this._currentStep > 0) {
                    this._currentStep = this._currentStep - 1;
                  } else {
                    this._currentStep = 0;
                  }
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: FlatButton(
                        onPressed: () => _onStepContinue(),
                        color: Color(0xFF5aff15),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          _currentStep == 2 ? 'Confirm' : 'Continue',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ]));
  }
}
