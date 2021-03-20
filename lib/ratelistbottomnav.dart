import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme.dart' as Themes;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kabadify',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
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
      body: ListView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Rate List',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF505050),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Metal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF505050),
              ),
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Copper",
                    duration: "₹200/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Brass",
                    duration: "₹150/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Aluminium",
                    duration: "₹60/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Casting Aluminium",
                    duration: "₹40/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Iron",
                    duration: "₹20/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Steel",
                    duration: "₹18/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Tin",
                    duration: "₹10/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Oil Tin",
                    duration: "₹15/piece"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Paper',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF505050),
              ),
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Carton",
                    duration: "₹10/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Carton(Commercial)",
                    duration: "₹10/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Newspaper",
                    duration: "₹9/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Copy",
                    duration: "₹8/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "White Papers",
                    duration: "₹7/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Record Paper",
                    duration: "₹7/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Plain Paper",
                    duration: "₹7/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Rough Paper",
                    duration: "₹7/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Books",
                    duration: "₹6/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Magzines",
                    duration: "₹6/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Grey Board",
                    duration: "₹1/kg"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Plastic',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF505050),
              ),
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Polythene",
                    duration: "₹15/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Plastic Jar(15 ltr)",
                    duration: "₹8/piece"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Soft Plastic",
                    duration: "₹6/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Fibre",
                    duration: "₹6/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Water/Oil Covers",
                    duration: "₹5/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Polythene(Mix)",
                    duration: "₹5/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Mix Plastic",
                    duration: "₹4/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Milk Covers",
                    duration: "₹2/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Plastic Jar(5 ltr)",
                    duration: "₹2/piece"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Plastic Bori",
                    duration: "₹2/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Hard Plastic",
                    duration: "₹1/kg"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'E-Waste',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF505050),
              ),
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "E-Waste",
                    duration: "₹10/kg"),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Other items',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF505050),
              ),
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Battery",
                    duration: "₹50/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Tyre",
                    duration: "₹3/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Mix-Waste",
                    duration: "₹2/kg"),
                _customCard(
                    //imageUrl: "recycle.png",
                    item: "Beer Bottles",
                    duration: "₹0.5/piece"),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

_customCard(
    { //String imageUrl,
    String item,
    String duration}) {
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
            // Image.asset("assets/" + imageUrl),
            Align(
              alignment: Alignment.bottomLeft,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      item,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(duration)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
