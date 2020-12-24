import 'package:flutter/material.dart';
import 'package:schoolapp/screens/quiz_questions2.dart';
import 'package:schoolapp/const/style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizStartPage extends StatefulWidget {
  final totalQuestions;
  final testId;
  QuizStartPage({Key key, this.totalQuestions, this.testId}) : super(key: key);
  @override
  _QuizStartPageState createState() => _QuizStartPageState();
}

class _QuizStartPageState extends State<QuizStartPage> {
  bool _loading = false;
  var TestName;
  var TotalMarks;
  var TotalTime;
  var EndDate;
  var TotalQuestion;
  var Duration;
  quizDetails() async {
    setState(() {
      _loading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));

    final String url = 'http://projects.creatise.in/school_app/tests/' +
        widget.testId.toString();
    //   widget.data.toString();
    print(widget.testId.toString());
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
      var testName = result['responseData']['test_name'];
      var time = result['responseData']['duration_in_sec'];
      var totalMarks = result['responseData']['total_marks_allotted'];
      var questionCount = result['responseData']['questions_count'];
      var endDate = result['responseData']['end_date'];
      var duration = result['responseData']['duration_in_sec'];

      TestName = testName;
      TotalTime = time;
      TotalMarks = totalMarks;
      TotalQuestion = questionCount;
      EndDate = endDate;
      Duration = duration;
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  var studentTestId;
  testStart() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    String schoolId = (prefs.getString('school_id'));
    String studentId = (prefs.getString('student_bio_id'));
    final String url = 'http://projects.creatise.in/school_app/student-tests';
    //   widget.data.toString();
    //  print(widget.data);
    var req = {
      "school_id": schoolId.toString(),
      "student_bio_id": studentId.toString(),
      "test_id": widget.testId,
    };

    var response = await http.post(Uri.encodeFull(url),
        body: json.encode(req),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    print('tessssssssssssssstiddddddddddddddddddddd');
    print(widget.testId.toString());
    if (response.statusCode == 201) {
      print('some thing');
      Map result = json.decode(response.body);
      print(result);
      var schoolId = result['responseData']['school_id'];
      var studentBioId = result['responseData']['student_bio_id'];
      var testId = result['responseData']['test_id'];
      studentTestId = result['responseData']['id'];

      print(result);

      setState(() {
        _loading = false;
      });
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  @override
  void initState() {
    quizDetails();
    testStart();
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
    double c_width = MediaQuery.of(context).size.width * 0.85;
    double c_height = MediaQuery.of(context).size.height * 0.5;
    double b_height = MediaQuery.of(context).size.height * 0.24;

    return new Scaffold(
      backgroundColor: Colors.white,
      body: 
           NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Color(hexcolor('E86836')),
                    expandedHeight: c_height,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      // centerTitle: true,
                      background: Container(
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/quizbackground.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: b_height,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "TIME !",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 17,
                                ),
                                Text(
                                  "Test Your Knowledge !",
                                  style: largeTextStyle,
                                  /* TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),  */
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: !_loading
                  ? SingleChildScrollView(
                      child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              TestName,
                              //   'Plants',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(hexcolor('76341B')),
                              ),
                            ),
                            //  Text('End on 7/10/19'),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Ends on' + ' ' + EndDate,
                              //   'Ends on 16/11/2019',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  '?' +
                                      ' ' +
                                      TotalQuestion.toString() +
                                      ' ' +
                                      'QUESTIONS',
                                  style: quizDetailStyle),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.done,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(TotalMarks.toString() + ' ' + 'Marks',
                                      style: quizDetailStyle),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    TotalTime.toString() + ' ' + 'sec',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Instructions',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Wrap(children: <Widget>[
                                        Icon(
                                          Icons.fiber_manual_record,
                                          size: 11,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: c_width,
                                          child: Text(
                                              'This test consists of 25 Questions with 4 options each of which there is only one correct option.',
                                              textAlign: TextAlign.left,
                                              maxLines: null,
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                              style: quizDetailStyle2),
                                        ),
                                        //   ),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                              //   ],
                              //   ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Wrap(children: <Widget>[
                                        Icon(
                                          Icons.fiber_manual_record,
                                          size: 11,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: c_width,
                                          child: Text(
                                              'Every correct answer is awarded 1 mark and for wrong answers  -0.25 marks will be cut. There are no negative marks for unattempted questions.',
                                              textAlign: TextAlign.left,
                                              maxLines: null,
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                              style: quizDetailStyle2),
                                        ),
                                        //   ),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Wrap(children: <Widget>[
                                        Icon(
                                          Icons.fiber_manual_record,
                                          size: 11,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),

                                        Text(
                                            'Tap on the options to select the correct answer.',
                                            //  about1,
                                            //   'A warm welcome to every students and parents to Creatise School. The school was inaugurated in July 1961 by Mr.John, with the objective of preparing students for entry into national defence academy in Bangalore.',

                                            softWrap: true,
                                            style: quizDetailStyle2),

                                        //   ),
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
      
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),),
      bottomNavigationBar: Container(
        //   color: Colors.pink,
        height: 50.0,
        width: 350,
        alignment: Alignment.center,
        child: ButtonTheme(
          minWidth: 130.0,
          height: 30.0,
          child: RaisedButton(
            focusElevation: 3,
            color: Color(hexcolor('#113F67')),
            elevation: 1.0,

            //  child: setUpButtonChild(),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizQuestions(
                        studentTestId: studentTestId,
                        testName: TestName,
                        testId: widget.testId,
                        totalQuestions: TotalQuestion.toString(),
                        totalTime: TotalTime),
                  ));
              //  _validateInputs(context);
            },
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              " Start Quiz ",
              style: TextStyle(fontSize: 15),
            ),
            textColor: Colors.white,
            //     ),
          ),
        ),
      ),
    );
  }
}
