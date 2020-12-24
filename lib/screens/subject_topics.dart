import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/leaderboard.dart';
import 'package:http/http.dart' as http;
import 'package:schoolapp/components/past_topics.dart';
import 'package:schoolapp/components/upcoming.dart';
import 'package:schoolapp/const/style_constant.dart';
import 'package:schoolapp/models/past_topiclist.dart';
import 'package:schoolapp/models/quiz_topicslist.dart';
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SubTopics extends StatefulWidget {
  var subjectName, subjectId, subjectLogo;

  SubTopics({Key key, this.subjectName, this.subjectId, this.subjectLogo})
      : super(key: key);

  @override
  _SubTopicsState createState() => _SubTopicsState();
}

class _SubTopicsState extends State<SubTopics> {
  bool _loading = false;
  bool changeButton = true;

  List<TopicListModel> _list = <TopicListModel>[];
  SharedPreferences sharedPreferences;
  Future _getTopicList() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    print(widget.subjectId);
    final String url =
        'http://projects.creatise.in/school_app/tests?id=' + widget.subjectId;

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    print(widget.subjectId);
    setState(() {
      _loading = false;
    });
    if (response.statusCode == 200) {
      print('some thing');
      var result = json.decode(response.body);
      print(result);
      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      var TopicList = result['responseData']['data'];
      //  print(TopicList);

      final items = TopicList.cast<Map<String, dynamic>>();

      List<TopicListModel> listOfUsers = items.map<TopicListModel>((json) {
        if (mounted) {
          print(TopicListModel.fromJson(json));
          print("hello");
          setState(() {
            _list.add(TopicListModel.fromJson(json));
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

  List<PastTopicModel> _lists = <PastTopicModel>[];

  Future _getPastTopicList() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    String studentBioId = (prefs.getString('student_bio_id'));
    final String url =
        'http://projects.creatise.in/school_app/student-test-results?student_bio_id=' +
            studentBioId.toString();

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
      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      var TopicList = result['responseData']['data'];
      print(TopicList);

      final items = TopicList.cast<Map<String, dynamic>>();

      List<PastTopicModel> listOfUsers = items.map<PastTopicModel>((json) {
        if (mounted) {
          print(PastTopicModel.fromJson(json));
          print("hello");
          setState(() {
            _lists.add(PastTopicModel.fromJson(json));
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
    _getTopicList();
    _getPastTopicList();
    super.initState();
  }

  hexcolor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  @override
  Widget build(BuildContext context) {
    double e_height = MediaQuery.of(context).size.height * .5;
    return new Scaffold(
      backgroundColor: Colors.white,
      body: !_loading
          ? CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 0.0,
                  backgroundColor: Color(hexcolor('76341B')),
                  expandedHeight: e_height,
                  floating: true,
                  pinned: true,
                  title: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              height: 40,
                              width: 65,
                              decoration: new BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/leaderboard.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Leaderboard(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Padding(
                      padding: const EdgeInsets.all(0),
                      //    margin: const EdgeInsets.only(bottom: 40.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            ButtonTheme(
                              height: 25,
                              minWidth: 45,
                              child: RaisedButton(
                                child: Text(
                                  'Upcoming',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: changeButton
                                          ? Colors.white
                                          : Color(hexcolor('#113F67'))),
                                ),
                                color: changeButton
                                    ? Color(hexcolor('#113F67'))
                                    : Colors.white,
                                onPressed: () {
                                  setState(() {
                                    changeButton = true;
                                  });
                                },
                                textColor: Colors.black,
                              ),
                            ),
                            ButtonTheme(
                              height: 25,
                              minWidth: 75,
                              child: RaisedButton(
                                child: Text(
                                  'Past',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: changeButton
                                          ? Color(hexcolor('#113F67'))
                                          : Colors.white),
                                ),
                                color: changeButton
                                    ? Colors.white
                                    : Color(hexcolor('#113F67')),
                                onPressed: () {
                                  setState(() {
                                    changeButton = false;
                                  });
                                },
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    background: Container(
                      //   height: 480,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/redbg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*    Container(
                          height: 10.0,
                          width: 10.0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white70,
                            backgroundImage: NetworkImage(widget.subjectLogo),
                            radius: 150.0,
                          ),
                        ),  */
                              SizedBox(
                                height: 10,
                              ),
                              Text(widget.subjectName,
                                  //  "Biology",
                                  style: largeTextStyle),
                              SizedBox(
                                height: 8,
                              ),
                              /*      Text("7 chapters", style: whiteTextStyle
                            //   TextStyle(color: Colors.white),
                            ),  */
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                changeButton
                    ? SliverFixedExtentList(
                        itemExtent: 70.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) =>
                              Upcoming(_list[index]),
                          childCount: _list.length,
                        ),
                      )
                    : SliverFixedExtentList(
                        itemExtent: 70.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) =>
                              PastTopics(_lists[index]),
                          childCount: _lists.length,
                        ),
                      )
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }
}
