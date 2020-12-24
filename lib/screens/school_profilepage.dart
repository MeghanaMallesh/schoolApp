import 'dart:convert';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:schoolapp/components/bottom_navbar.dart';
import 'package:schoolapp/components/calendar.dart';
import 'package:schoolapp/const/style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolProfile extends StatefulWidget {
  var schoolId;
  SchoolProfile({Key key, this.schoolId}) : super(key: key);
  @override
  _SchoolProfileState createState() => _SchoolProfileState();
}

class _SchoolProfileState extends State<SchoolProfile> {
  bool _loading = false;
  var s1name;
  var mobileNo;
  var emailId;
  var address1;
  var about1;
  schoolDetails() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));

    final String url = 'http://projects.creatise.in/school_app/schools/' +
        widget.schoolId.toString();

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    setState(() {
      _loading = false;
    });
    if (response.statusCode == 200) {
      print('some thing');
      var result = json.decode(response.body);
      print(result);
      var sname = result['responseData']['name'];
      var mobile = result['responseData']['mobile'];
      var address = result['responseData']['address'];
      var email = result['responseData']['email'];
      var about = result['responseData']['description'];
      s1name = sname;
      print(sname);
      mobileNo = mobile;
      print(mobileNo);
      address1 = address;
      emailId = email;
      about1 = about;
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  _launchCaller() async {
    const url = "tel:0802387656";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//  DateTime _date = new DateTime.now();
  /* Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1997),
        lastDate: new DateTime(2020));
    if (picked != null && picked != _date) {
      print('Date selected:${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }   */

  @override
  void initState() {
    schoolDetails();
    super.initState();
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500),
    );
  }

  Widget contactInfoIcons(IconData icon) {
    return Icon(
      icon,
      //  Icons.location_on,
      size: 23,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.9;
    double a_width = MediaQuery.of(context).size.width * 0.5;
    double d_width = MediaQuery.of(context).size.width * 0.7;
    double e_width = MediaQuery.of(context).size.width * 1;
    double e_height = MediaQuery.of(context).size.height * .35;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(e_height),
        child: AppBar(
          titleSpacing: 0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/schoolbui.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: !_loading
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: a_width,
                          child: Text(
                            s1name,
                            textAlign: TextAlign.left,
                            maxLines: null,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  height: 16,
                                  width: 16,
                                  child: Image.asset('images/calendar.png')),
                              onTap: () {
                                //    _selectedDate(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventCalendar(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 4),
                            InkWell(
                              child: Text(
                                'View Calendar',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff113F67),
                                ),
                              ),
                              onTap: () {
                                //  EventCalendar();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventCalendar(),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 11),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildText('    Contact Info'),
                      SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Container(
                          alignment: Alignment.center,
                          width: e_width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      contactInfoIcons(Icons.location_on),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      Container(
                                        width: d_width,
                                        child: Text(
                                          address1,
                                          //     'No.16 halalli, 8th Cross, Main road, Mysore Road , Bangalore-560067.',
                                          textAlign: TextAlign.left,
                                          maxLines: null,
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                          style: stuProfTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      contactInfoIcons(
                                        Icons.phone,
                                      ),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      InkWell(
                                        child: Text(
                                          mobileNo,
                                          style: stuProfTextStyle,
                                        ),
                                        onTap: () {
                                          _launchCaller();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      contactInfoIcons(Icons.mail),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                          child: Text(
                                            emailId,
                                            //    'Creatise123@gmail.com',
                                            style: stuProfTextStyle,
                                          ),
                                          onTap: () {
                                            _launchURL(
                                              'Creatise123@gmail.com',
                                            );
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.5),
                      buildText('   About'),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child: Container(
                          width: e_width,
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: c_width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      about1,
                                      textAlign: TextAlign.left,
                                      maxLines: null,
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  _launchURL(
    String toMailId,
  ) async {
    // String subject, String body) async {
    var url = 'mailto:$toMailId?subject=';
    //  $subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
