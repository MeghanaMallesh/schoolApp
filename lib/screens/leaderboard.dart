import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/home_page.dart';
import 'package:schoolapp/components/student_rank.dart';
import 'package:http/http.dart' as http;
import 'package:schoolapp/models/student_rank.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  bool changebtn = true;
  bool _loading = false;
  var StudentPhoto;
  var StudentName;
  var TestScore;
  var StudentPhoto2;
  var StudentName2;
  var TestScore2;
  var StudentPhoto3;
  var StudentName3;
  var TestScore3;
  List<StudentRankModel> _list = <StudentRankModel>[];

  studentRank() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));

    final String url =
        'http://projects.creatise.in/school_app/student-test-results?';
    //   widget.data.toString();
    //  print(widget.data);
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    setState(() {
      _loading = false;
    });
    if (response.statusCode == 200) {
      print('some thing');
      Map result = json.decode(response.body);
      print(result);
      var studentPhoto =
          result['responseData']['data'][0]['students'][0]['photo'];
      var studentName =
          result['responseData']['data'][0]['students'][0]['first_name'];
      var testScore = result['responseData']['data'][0]['test_score'];

      var studentPhoto2 =
          result['responseData']['data'][1]['students'][0]['photo'];
      var studentName2 =
          result['responseData']['data'][1]['students'][0]['first_name'];
      var testScore2 = result['responseData']['data'][1]['test_score'];

      var studentPhoto3 =
          result['responseData']['data'][2]['students'][0]['photo'];
      var studentName3 =
          result['responseData']['data'][2]['students'][0]['first_name'];
      var testScore3 = result['responseData']['data'][2]['test_score'];

      StudentPhoto2 = studentPhoto2;
      StudentName2 = studentName2;
      TestScore2 = testScore2;

      StudentPhoto3 = studentPhoto3;
      StudentName3 = studentName3;
      TestScore3 = testScore3;
      StudentPhoto = studentPhoto;
      StudentName = studentName;
      TestScore = testScore;
      var StudentRankList = result['responseData']['data'];

      final items = StudentRankList.cast<Map<String, dynamic>>();

      List<StudentRankModel> listOfUsers = items.map<StudentRankModel>((json) {
        if (mounted) {
          print(StudentRankModel.fromJson(json));
          print("hello");
          setState(() {
            _list.add(StudentRankModel.fromJson(json));
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

  @override
  void initState() {
    studentRank();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double e_height = MediaQuery.of(context).size.height * .58;
    return new Scaffold(
      backgroundColor: Colors.white,
      body: !_loading
          ? CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 0.0,
                  //    backgroundColor: Colors.white,
                  backgroundColor: Color(0xff113F67),
                  expandedHeight: e_height,
                  floating: true,
                  pinned: true,
                  title: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              height: 40,
                              width: 65,
                              decoration: new BoxDecoration(
                                //    color: Colors.transparent,
                                //   Image(
                                image: DecorationImage(
                                  image: AssetImage('images/startquizz.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Leaderboard',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ],
                  ),

                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/rankboard.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //    SizedBox(height: 30,),
                                new Container(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircleAvatar(
                                    //  backgroundColor: ,
                                    backgroundImage:
                                        ExactAssetImage('images/boy2.png'),
                                    radius: 150.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  //    'Manoj',
                                  StudentName2,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                new Container(
                                  height: 50,
                                  width: 75,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('images/silvarmedal.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  //    ' 50 Points',
                                  TestScore2.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                //  SizedBox(height: 40,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 39.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //    SizedBox(height: 30,),
                                new Container(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircleAvatar(
                                    //  backgroundColor: ,
                                    backgroundImage:
                                        ExactAssetImage('images/boy2.png'),
                                    radius: 150.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  //  'Arun',
                                  StudentName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                new Container(
                                  height: 80,
                                  width: 130,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/goldmedal.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  //   '70 Points',
                                  TestScore.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                //  SizedBox(height: 40,),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //    SizedBox(height: 30,),
                                new Container(
                                  height: 50.0,
                                  width: 50.0,
                                  child: CircleAvatar(
                                    //  backgroundColor: ,
                                    backgroundImage:
                                        ExactAssetImage('images/boy2.png'),
                                    radius: 150.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  //   'Vinod',
                                  StudentName3,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                new Container(
                                  height: 40,
                                  width: 40,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/bronz.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  //    '40 Points  ',
                                  TestScore3.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 65.0,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) =>
                        StudentRank(_list[index]),
                    childCount: _list.length,
                  ),
                ),
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }
}
