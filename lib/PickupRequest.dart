import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme.dart' as Themes;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class PickupRequest extends StatefulWidget {
  @override
  _PickupRequestState createState() => _PickupRequestState();
}

class _PickupRequestState extends State<PickupRequest> {
  ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
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
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
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
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Pickup Request',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505050),
                ),
              ),
            ),
            OrderStream(),
          ],
        ),
      ),
    );
  }
}

class OrderStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('schedule')
            .doc(_auth.currentUser.uid)
            .collection('Perschedule')
            .where('Status', isEqualTo: 'Booked')
            .orderBy('Date')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFF5aff15),
              ),
            );
          }
          final orders = snapshot.data.docs;
          List<OrderCard> ordercard = [];
          for (var order in orders) {
            final orderdate = order.data()['Date'];
            final ordertime = order.data()['Time'];
            final orderstatus = order.data()['Status'];
            final orderaddress = order.data()['Address'];
            final orderlandmark = order.data()['Landmark'];
            final ordermobno = order.data()['Mobile Number'];

            final orderdetails = OrderCard(
              date: orderdate,
              time: ordertime,
              status: orderstatus,
              address: orderaddress,
              landmark: orderlandmark,
              mobno: ordermobno,
            );

            ordercard.add(orderdetails);
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              children: ordercard,
            ),
          );
        });
  }
}

class OrderCard extends StatelessWidget {
  OrderCard(
      {this.date,
      this.time,
      this.status,
      this.address,
      this.landmark,
      this.mobno});
  final String date;
  final String time;
  final String status;
  final String address;
  final String landmark;
  final String mobno;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 200,
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: Text('Date: ' + date)),
                Expanded(child: Text('Time: ' + time)),
                Expanded(child: Text('Status: ' + status)),
                Expanded(child: Text('Address: ' + address)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
