import 'package:flutter/material.dart';
import 'package:swipe_up/swipe_up.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:url_launcher/url_launcher.dart';

final Color backgroundColor = Colors.lightBlue[400];

class MainPage extends StatefulWidget{
  HomePage createState()=> HomePage();
}

class HomePage extends State<MainPage> {
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  _launchURL() async {
    var isoCode = {
      "IN":91
    };
    var url = 'https://wa.me/' + isoCode[phoneIsoCode].toString() + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          homescreen(context),
          welcome(context),
        ],
      ),
    );
  }

  Widget welcome(context) {
    return SwipeUp(
        color: Colors.white,
        sensitivity: 0.5,
        onSwipe: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => homescreen(context)));
        },
        body: Material(
          color: backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('No More',
                    style: TextStyle(color: Colors.white, fontSize: 70.0)),
                Text('Saving',
                    style: TextStyle(color: Colors.white, fontSize: 100.0)),
                Text('Contacts',
                    style: TextStyle(color: Colors.white, fontSize: 70.0))
              ],
            ),
          ),
        ),
        child: Material(
            color: Colors.transparent,
            child: Text('Swipe Up to Start Messaging', style: TextStyle(color: Colors.white))));
  }

  Widget homescreen(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsOpen'),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Container(
              height: 160,
              child: PageView(
                controller: PageController(viewportFraction: 0.6),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.amberAccent,
                    width: 100
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.amberAccent,
                    width: 100
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.amberAccent,
                    width: 100
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.amberAccent,
                    width: 100
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.amberAccent,
                    width: 100
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
              decoration: InputDecoration(
                labelText: "Name"
              ),
            ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(15.0),
              child: InternationalPhoneInput(
                onPhoneNumberChange: onPhoneNumberChange,
                initialPhoneNumber: phoneNumber,
                initialSelection: phoneIsoCode,
                enabledCountries: ['+91'],
                labelText: "Enter Phone Number",
              ),
            ),
            SizedBox(height: 40),
            Container(
                child: RaisedButton(
                onPressed: _launchURL,
                child: Text('Sent Message'),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
}