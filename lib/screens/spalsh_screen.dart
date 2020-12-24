import 'dart:async';
import 'package:flutter/material.dart';
import 'package:schoolapp/screens/home_page.dart';
import 'package:schoolapp/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    Future.delayed(Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth1 = (prefs.getString('auth'));
    String SchoolId = (prefs.getString('school_id'));
    String StudentId = (prefs.getString('student_bio_id'));
    print(StudentId);
    print('ggggggggggggggggggggggggggggggggggggg');
    print(SchoolId);

    final String url =
        'http://projects.creatise.in/school_app/user-schools?get_auth_school=yes';

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth1});
    print('after');
    if (response.statusCode == 401) {
      print('some thing');

      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginPage()));
    } else {
      if (auth1 == null || auth1 == '') {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new LoginPage()));
      } /* else {
        if (SchoolId != null || SchoolId != '') {
          if (StudentId != null || StudentId != '') {
            Navigator.of(context).pushReplacement(
                new MaterialPageRoute(builder: (context) => new HomePage()));
            //      data: SchoolName)));
          } else {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (context) => new StudentList(
                      data: SchoolId,
                    )));
          }
        } */
      else {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new HomePage()));
      }
      //   }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          color: Colors.pinkAccent,
          /*     child: Image.asset(
            'images/background.png',
            fit: BoxFit.contain,
            height: 380,
            width: 280,
          ),   */
        ));
  }
}
