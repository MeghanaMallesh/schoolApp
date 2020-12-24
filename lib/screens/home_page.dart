import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/login_page.dart';
import 'package:schoolapp/Screens/notification_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schoolapp/components/bottom_navbar.dart';
import 'package:schoolapp/components/event_card.dart';
import 'package:schoolapp/const/style_constant.dart';
import 'package:schoolapp/models/student_dairy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  var schoolName;

  HomePage({Key key, this.schoolName}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool loadData = false;
  var schoolName;
  TabController tabController;
  bool _loading = false;
  String text = "today";

  List<StudentDairy> _events = <StudentDairy>[];

  schoolDetails() async {
    print("annnnnnn");
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    String SchoolName = (prefs.getString('name'));
    String StudentId = (prefs.getString('student_bio_id'));
    schoolName = SchoolName;
    print(widget.schoolName);
    print(StudentId);
    final String url =
        //    'http://projects.creatise.in/school_app/student-diaries?shortBy=$text' ;
        'http://projects.creatise.in/school_app/student-diaries?student_bio_id=${StudentId.toString()}&shortBy=$text';

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print(url);
    print(json.decode(response.body));
    setState(() {
      _loading = false;
    });
    if (response.statusCode == 200) {
      print('some thing');
      var result = json.decode(response.body);

      var eventList = result['responseData']['data'];
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
      print(result['responseData']['data'][0]['memo_type']['color_code']);
      final items = eventList.cast<Map<String, dynamic>>();
      List<StudentDairy> _eventsArray = <StudentDairy>[];

      List<StudentDairy> listOfUsers = await items.map<StudentDairy>((json) {
        setState(() {
          _eventsArray.add(StudentDairy.fromJson(json));
          loadData = true;
        });
      }).toList();

      setState(() {
        _events = _eventsArray;
      });
      print('returning list');
      //    loading = false; //bcz response is succ dn no loading
      return listOfUsers;
    } else {
      //  toast('failed to load');

      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  @protected
  void initState() {
    super.initState();
    setState(() {
      text = "today";
    });
    schoolDetails();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
    )..addListener(() {
        print(tabController.index);
        switch (tabController.index) {
          case 0:
            {
              setState(() {
                text = "today";
              });
            }
            break;
          case 1:
            {
              setState(() {
                text = "tomorrow";
              });
            }
            break;
          case 2:
            {
              setState(() {
                text = "week";
              });
            }
            break;
          case 3:
            {
              setState(() {
                text = "month";
              });
            }
            break;
          default:
            {
              setState(() {
                text = "today";
              });
            }
            break;
        }
        schoolDetails();
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * .6;
    return MaterialApp(
      home:
          //   DefaultTabController(
          //  length: 4,
          // child:
          Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff113F67),
          bottom: TabBar(
            //   indicatorColor: Colors.white,
            controller: tabController,
            tabs: [
              Tab(
                child: Text(
                  'Today',
                  style: tabTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  'Tomorrow',
                  style: tabTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  'Week',
                  style: tabTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  'Month',
                  style: tabTextStyle,
                ),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              schoolName != null
                  ? Container(
                      width: c_width,
                      child: Text(
                        schoolName,
                        textAlign: TextAlign.left,
                        maxLines: null,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: largeTextStyle,
                      ),
                    )
                  : Text(''),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.notifications,
                      size: 22,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationPage(),
                        ),
                      );
                    },
                  ),
                  //  Icon(Icons.more_vert),
                  SizedBox(width: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(height: 43),
                      PopupMenuButton(
                        child: Icon(
                          Icons.more_vert,
                          size: 25,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: InkWell(
                              child: Container(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                _showDialog(context);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        body: !_loading
            ? TabBarView(
                controller: tabController,
                children: [
                  loadData
                      ? ListView.builder(
                          itemCount: _events.length,
                          itemBuilder: (context, index) =>
                              EventCard(_events[index]),
                        )
                      : ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) => Container(
                            //   height: 110,
                            width: c_width,
                            child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //  SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Event Not Found",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "no events found",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                  loadData
                      ? ListView.builder(
                          itemCount: _events.length > 0 ? _events.length : 0,
                          itemBuilder: (context, index) =>
                              EventCard(_events[index]),
                        )
                      : ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) => Container(
                            //   height: 110,
                            width: c_width,
                            child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //  SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Event Not Found",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "no events found",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                  loadData
                      ? ListView.builder(
                          itemCount: _events.length > 0 ? _events.length : 0,
                          itemBuilder: (context, index) =>
                              EventCard(_events[index]),
                        )
                      : ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) => Container(
                            width: c_width,
                            child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Event Not Found",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "no events found",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                  loadData
                      ? ListView.builder(
                          itemCount: _events.length > 0 ? _events.length : 0,
                          itemBuilder: (context, index) =>
                              EventCard(_events[index]),
                        )
                      : ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) => Container(
                            //   height: 110,
                            width: c_width,
                            child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //  SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Event Not Found",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "no events found",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
        bottomNavigationBar: BottomNavBar(),
        /*   bottomNavigationBar: new BottomNavigationBar(
                            currentIndex: _currentIndex,
                         //   selectedItemColor: Colors.deepOrange,
                            unselectedItemColor: Colors.grey,
                            onTap: (newIndex) => setState(() {
                              _currentIndex = newIndex;
                            }),
                            items: [
                              new BottomNavigationBarItem(
                                  icon: new Icon(Icons.home), title: new Text("Home")),
                              new BottomNavigationBarItem(
                                  icon: new Icon(Icons.person), title: new Text("Students")),
                              new BottomNavigationBarItem(
                                  icon: new Icon(Icons.school), title: new Text("Schools")),
                            ],
                          ),
                          body: new IndexedStack(
                            index: _currentIndex,
                            children: <Widget>[
                              //   new YourCustomTrendsWidget(),
                              //  new YourCustomFeedWidget(),
                              //  new YourCustomCommunityWidget(),
                            ],
                          ),     */
      ),
      //   ),
    );
  }

  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Are you really want to logout?"),
          actions: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text("Yes"),
                  onPressed: () {
                    logout();
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void logout() async {
    final String url = 'http://projects.creatise.in/school_app/users/logout';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');

    if (response.statusCode == 200) {
      print('some thing');
      var result = json.decode(response.body);
      print(result);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }
}
