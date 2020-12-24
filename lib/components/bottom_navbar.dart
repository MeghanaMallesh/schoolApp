import 'package:flutter/material.dart';
import 'package:schoolapp/screens/home_page.dart';
import 'package:schoolapp/screens/quiz_subjectspage.dart';
import 'package:schoolapp/screens/school_profilepage.dart';
import 'package:schoolapp/screens/student_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 23,
                color: Color(0xff113F67),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            InkWell(
              child: new GestureDetector(
                child: Icon(
                  Icons.person,
                  color: Color(0xff113F67),
                  size: 23,
                ),
                onLongPress: () {
                  //    Navigator.pop(context);
                  //    _settingModalBottomSheet3(context);
                },
                onTap: () {
                  //     getstudentListId();
                  studentProf();
                },
              ),
            ),
            InkWell(
              child: new GestureDetector(
                child: Container(
                    height: 21,
                    width: 21,
                    child: Image.asset(
                      'images/School.png',
                      color: Color(0xff113F67),
                    )),
                onLongPress: () {},
                onTap: () {
                  schoolProf();
                },
              ),
            ),
            InkWell(
              child: new GestureDetector(
                child: Container(
                    height: 21,
                    width: 21,
                    child: Image.asset(
                      'images/quizicon.png',
                      color: Color(0xff113F67),
                    )),
                onLongPress: () {},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizSubPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet3(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String schoolId = (prefs.getString('school_id'));
    String studentList = (prefs.getString('data'));
    print(studentList);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          );
        });
  }

  void _settingModalBottomSheet2(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                height: 40.0,
                                width: 40.0,
                                child: CircleAvatar(
                                  backgroundImage:
                                      ExactAssetImage('images/school2.jpg'),
                                  radius: 150.0,
                                ),
                              ),
                              SizedBox(width: 12),
                              //  SizedBox(height: 4),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //   Text('Arvindh Tiwari',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  //      SizedBox(height: 5),
                                  Text(
                                    'Abcxyz School',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          /*     IconButton(
                                                                                                                icon:  Icon(Icons.radio_button_checked),     */
                        ],
                      ),
                      onTap: () {
                        schoolProf();
                      }),
                ),
                Divider(
                  height: 3,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                height: 40.0,
                                width: 40.0,
                                child: CircleAvatar(
                                  backgroundImage:
                                      ExactAssetImage('images/schoolbui.jpg'),
                                  radius: 150.0,
                                ),
                              ),
                              SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Creatise School',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        schoolProf();
                      }),
                ),
              ],
            ),
          );
        });
  }

  schoolProf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolId = (prefs.getString('school_id'));

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new SchoolProfile(schoolId: schoolId.toString())));
  }

  studentProf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String StudentBioId = (prefs.getString('student_bio_id'));
    print(StudentBioId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentProfile(
          studentBioId: StudentBioId.toString(),
        ),
      ),
    );
  }
}
