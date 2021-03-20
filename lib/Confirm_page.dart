import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'theme.dart' as Themes;
import 'Home_page.dart';

class ConfirmPage extends StatefulWidget {
  final String Orderdate;
  final String Ordertime;
  final String Orderstatus;
  final String Orderaddress;
  final String OrderLandmark;
  final String OrderMobile;

  ConfirmPage({
    Key key,
    @required this.Orderdate,
    @required this.Ordertime,
    @required this.Orderstatus,
    @required this.Orderaddress,
    @required this.OrderLandmark,
    @required this.OrderMobile,
  }) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Kabadify',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Container(),
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
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Lottie.asset(
                  'assets/success.json',
                  width: size.width * .30,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Success!",
                    style: TextStyle(
                        color: Color(0xff063057),
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
              ),
            ),
            Center(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.all(7.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF5aff15), width: 3),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: SelectableText(
                        widget.Orderdate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text(' Date '),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.all(7.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF5aff15), width: 3),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: SelectableText(
                        widget.Ordertime,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text(' Time '),
                      )),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                    "You have successfully scheduled your scrap pickup on above Date and Time.",
                    style: TextStyle(color: Color(0xff063057), fontSize: 14),
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(85, 5, 85, 5),
                child: SizedBox(
                    width: double.infinity,
                    child: blueButton(
                        "Go Home",
                        () => {
                              Navigator.of(context).maybePop()
                              // Navigator.of(context)
                              //     .popUntil(ModalRoute.withName('/Homepage')),
                              // Navigator.pushAndRemoveUntil(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return Homepage();
                              // }), (Route route) => false)
                              // Navigator.push(context,
                              // }))
                            }))),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: viewMoreButtons(
                    "View Details",
                    () => {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 600,
                                  color: Color(0xFF737373),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(20),
                                          topRight: const Radius.circular(20),
                                        )),
                                    child: Column(
                                      children: <Widget>[
                                        viewMoreButtons("Close",
                                            () => {Navigator.pop(context)}),
                                        SizedBox(height: 10),
                                        listItemContainer(
                                            "Address", widget.Orderaddress),
                                        listItemContainer(
                                            "Landmark", widget.OrderLandmark),
                                        listItemContainer(
                                            "Number", widget.OrderMobile),
                                        listItemContainer(
                                            "Status", widget.Orderstatus),
                                      ],
                                    ),
                                  ),
                                );
                              })
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

MaterialButton viewMoreButtons(String title, Function fun) {
  return MaterialButton(
    onPressed: fun,
    textColor: Colors.white,
    color: const Color(0xFF5aff15),
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    ),
    height: 55,
    minWidth: 700,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  );
}

RaisedButton blueButton(String label, Function fun) {
  return RaisedButton(
    onPressed: fun,
    textColor: Colors.white,
    color: Color(0xFF5aff15),
    padding: const EdgeInsets.all(5.0),
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

Widget listItemContainer(String title, String value) => Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(196, 196, 196, 1)),
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
        ],
      ),
      decoration: BoxDecoration(
          border: new Border(
              bottom: new BorderSide(width: 1.0, color: Color(0xffC4C4C4)))),
    );
