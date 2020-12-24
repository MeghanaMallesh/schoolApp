import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:schoolapp/Screens/quiz_questions2.dart';
import 'package:schoolapp/Screens/scoreboard.dart';
import 'package:slide_transition_page_route/slide_transition_page_route.dart';

class QuizQuestions extends StatefulWidget {
  @override
  _QuizQuestionsState createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {
  bool click = true;
  bool click2 = true;
  bool click3 = true;
  bool click4 = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double d_height = MediaQuery.of(context).size.height * .13;
    double c_width = MediaQuery.of(context).size.width * 0.35;
    double a_width = MediaQuery.of(context).size.width * 0.21;
    return new Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Plants',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // SizedBox(height: 5,),
                      /*    Text(
                        '13/25',
                        style: TextStyle(fontSize: 15),
                      ),  */

                      Icon(
                        Icons.more_vert,
                        size: 18,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              'Biology',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            ),
          ],
        ),

        flexibleSpace: Container(
          height: 170,
          width: 20,
          child: Image(
            image: AssetImage('images/appbar.png'),
            fit: BoxFit.cover,
          ),
        ),
        //   backgroundColor: Colors.transparent,
      ),
      //   ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Questions',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff113F67),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '25/25',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff113F67),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new LinearPercentIndicator(
                  width: 280.0,
                  lineHeight: 14.0,
                  percent: 0.8,
                  backgroundColor: Colors.grey,
                  progressColor: Color(0xff113F67),
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 18,
                  width: 18,
                  child: Image(
                    image: AssetImage('images/timer.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '02:15:06',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    //   color: Colors.pink,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                          elevation: 3,
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'What is the green pigment in plants called?',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 23,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: d_height,
                                              width: c_width,
                                              child: Image(
                                                image: NetworkImage(
                                                    'https://picsum.photos/250?image=9'),
                                                //   AssetImage('images/appbar.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text('a)'),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.check_circle,
                                                  color: click
                                                      ? Colors.grey
                                                      : Color(0xff113F67),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            click = false;
                                            click3 = true;
                                            click2 = true;
                                            click4 = true;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: d_height,
                                              width: c_width,
                                              child: Image(
                                                image: NetworkImage(
                                                    'https://picsum.photos/250?image'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text('b)'),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.check_circle,
                                                  color: click2
                                                      ? Colors.grey
                                                      : Color(0xff113F67),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            click2 = false;
                                            click3 = true;
                                            click = true;
                                            click4 = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: d_height,
                                              width: c_width,
                                              child: Image(
                                                image: NetworkImage(
                                                    'https://picsum.photos/250?image'),
                                                //         AssetImage('images/appbar.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text('c)'),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.check_circle,
                                                  color: click3
                                                      ? Colors.grey
                                                      : Color(0xff113F67),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            click3 = false;
                                            click = true;
                                            click2 = true;
                                            click4 = true;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      InkWell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: d_height,
                                              width: c_width,
                                              child: Image(
                                                image: NetworkImage(
                                                    'https://picsum.photos/250?image=9'),
                                                //     AssetImage('images/appbar.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text('d)'),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.check_circle,
                                                  color: click4
                                                      ? Colors.grey
                                                      : Color(0xff113F67),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            click4 = false;
                                            click = true;
                                            click3 = true;
                                            click2 = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ))),
                    )),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          //    crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_left,
                    color: Color(0xff113F67),
                    size: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Prev',
                    style: TextStyle(
                        color: Color(0xff113F67),
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  SlideRightRoute(
                    widget: QuizQuestions(),
                  ),
                );
                /*  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizQuestions2(),
                  ),
                );  */
              },
            ),
            SizedBox(
              width: a_width,
            ),
            Container(
              height: 30.0,
              width: 100,
              alignment: Alignment.center,
              child: ButtonTheme(
                minWidth: 130.0,
                height: 30.0,
                child: RaisedButton(
                  color: Color(0xff113F67),
                  elevation: 1.0,

                  //  child: setUpButtonChild(),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scoreboard(),
                      ),
                    );
                    //  _validateInputs(context);
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 0.5,
                        color: Color(0xff113F67),
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  //  padding: const EdgeInsets.fromLTRB(10, 10, 25, 10),
                  child: new Text(
                    "  Submit  ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  textColor: Colors.white,
                  //     ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
