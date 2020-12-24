import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/leaderboard.dart';
import 'package:schoolapp/components/bottom_navbar.dart';
import 'package:schoolapp/components/quiz_subjects.dart';
import 'package:schoolapp/const/style_constant.dart';
import 'package:schoolapp/models/subject_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class QuizSubPage extends StatefulWidget {
  @override
  _QuizSubPageState createState() => _QuizSubPageState();
}

class _QuizSubPageState extends State<QuizSubPage> {
  List<SubjectList> _list = <SubjectList>[];
  SharedPreferences sharedPreferences;
  Future _getSubjectList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    final String url = 'http://projects.creatise.in/school_app/quiz-categories';

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    if (response.statusCode == 200) {
      print('some thing');
      var result = json.decode(response.body);
      print(result);
      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      var SubjList = result['responseData'];

      print(SubjList);

      final items = SubjList.cast<Map<String, dynamic>>();

      List<SubjectList> listOfUsers = items.map<SubjectList>((json) {
        if (mounted) {
          print(SubjectList.fromJson(json));
          print("hello");
          setState(() {
            _list.add(SubjectList.fromJson(json));
            //   homePostload = false;
          });
        } else {
          Text('Loading...');
        }
      }).toList();
      print('returning list');

      return listOfUsers;
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  TextStyle countStyle = TextStyle(fontSize: 20);

  TextStyle active = TextStyle(color: Colors.red);

  final tabText = TextStyle(fontSize: 12);

  AppBar appBar = AppBar(
      //  elevation: 0.8,
      backgroundColor: Color(0xff113F67),
      title: Text(
        'Profile',
      ));

  @override
  void initState() {
    super.initState();
    _getSubjectList();
  }

  @override
  Widget build(BuildContext context) {
    double e_height = MediaQuery.of(context).size.height * .5;
    double a_height = MediaQuery.of(context).size.height * .046;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            backgroundColor: Color(0xff113F67),
            expandedHeight: e_height,
            floating: true,
            pinned: true,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //   SizedBox(height: 10,),
                  InkWell(
                    child: Container(
                      height: 45,
                      width: 65,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/leaderboard.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Leaderboard(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                //   height: 480,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/quizz.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: a_height,
                  ),
                  Text('CHOOSE', style: tabTextStyle),
                  Text('SUBJECTS', style: tabTextStyle),
                ],
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
            ),
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => QuizSubjects(_list[index]),
                childCount: _list.length),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
