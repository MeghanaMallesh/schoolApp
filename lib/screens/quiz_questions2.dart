import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:schoolapp/components/test_card.dart';
import 'package:schoolapp/models/quiz_test.dart';
import 'package:schoolapp/screens/scoreboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

_QuizQuestionsState qnState;

class QuizQuestions extends StatefulWidget {
  var testName, testId, totalQuestions, totalTime, studentTestId;
  QuizQuestions(
      {Key key,
      this.testName,
      this.studentTestId,
      this.testId,
      this.totalQuestions,
      this.totalTime})
      : super(key: key);
  @override
  _QuizQuestionsState createState() {
    qnState = _QuizQuestionsState();
    return qnState;
  }
}

class _QuizQuestionsState extends State<QuizQuestions> {
  PageController controller = PageController();
  int position = 0;
  Timer _timer;
  int _start = 0;
  bool _isButtonDisabled = true;
  List questionOptionArray = [];
//  var currentPageValue = 0.0;
  var testList;
  // int page = 1;
  // int limit = 1;
  String questionText = "";
//  List answerOptions = [];
//  var data = [];
  // String question1;

  bool _loading = false;

/*  clickNext() {
    setState(() {
      page++;
    });
    quizQuestions();
  }

  clickPrev() {
    setState(() {
      page--;
    });
    quizQuestions();
  }   */
  answerOption(
      {int questionId, int optionId, String isCorrectAns, int answerPoints}) {
    Map answerOptionEle = {
      "test_question_id": questionId,
      "test_option_id": optionId,
      "is_correct_answer": isCorrectAns,
      "answer_point": isCorrectAns == "yes" ? answerPoints : 0
    };
    questionOptionArray.add(answerOptionEle);
    print(questionOptionArray);
    setState(() {
      _isButtonDisabled = false;
    });
  }

  int totalQuestions;
  var duration;
  List<TestListModel> _tests = <TestListModel>[];

  quizQuestions() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));

    final String url =
        'http://projects.creatise.in/school_app/test-questions?test_id=' +
            widget.testId;
    //   'http://projects.creatise.in/school_app/test-questions?test_id=1&limit=1&page=${page.toString()}';

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
      print('some thing');

      var testList = result['responseData']['data'];
      //  var totalQn=result['responseData']['data']['test'][0]['questions_count'];
      //  var durationInSec=result['responseData']['data']['test'][0]['duration_in_sec'];

      //   duration=durationInSec;
      //  totalQuestions = totalQn;
      testList = testList;
      print('ssssssssssssssssssssssss');

      final items = testList.cast<Map<String, dynamic>>();
      List<TestListModel> _testsArray = <TestListModel>[];

      List<TestListModel> listOfUsers = await items.map<TestListModel>((json) {
        setState(() {
          _testsArray.add(TestListModel.fromJson(json));
          //  loadData = true;
        });
      }).toList();

      setState(() {
        _tests = _testsArray;
        //  question1 = questionText;
        // answerOptions = answerOptionsResults;
      });

      print('returning list');

      return listOfUsers;
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  hexcolor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  @override
  void initState() {
    quizQuestions();
    super.initState();

    controller.addListener(() {
      setState(() {
        position = controller.page.toInt();
      });
    });
    var now = DateTime.now();
    // Get a 2-minute interval
    var twoHours = now.add(Duration(seconds: widget.totalTime)).difference(now);
    // Get the total number of seconds, 2 minutes for 120 seconds
    widget.totalTime = twoHours.inSeconds;
    startTimer();
    //   startTimer();
  }

  // void startTimer() {
  //   if (_start == 0) {
  //     if (mounted) {
  //       setState(() {
  //         _start = widget.totalTime;
  //       });
  //     }
  //   }
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) => setState(
  //       () {
  //         if (_start < 1) {
  //           timer.cancel();
  //         } else {
  //           _start = _start - 1;
  //         }
  //       },
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   startTimer();
  //   _timer.cancel();
  // }

/*  _tQn(question) {
    questionText = question;
    print(question);
    print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
  }  */

  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) +
        ":" +
        formatTime(minute) +
        ":" +
        formatTime(second);
  }

  // Digital formatting, converting 0-9 time to 00-09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // Update interface
      setState(() {
        // minus one second because it calls back once a second
        widget.totalTime--;
      });
      /*  if (widget.totalTime < (1790)) {
        Fluttertoast.showToast(
            msg: "Please Hurry Up, You have only one min",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1);
        //   toast('Please enter correct Otp');
        throw Exception('Failed to signin');
      }   */
      if (widget.totalTime == 0) {
        // Countdown seconds 0, cancel timer
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    double a_height = MediaQuery.of(context).size.height * 0.5;
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
                  widget.testName,
                  //   'Plants',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      /*   Text(
                        '13/25',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 10,
                      ),   */
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
              //      SubName,
              'Biology',
              //  subjectsState.slist.subjectName,
              //   topicsState.widget.data,
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
      ),
      //   ),
      body: Column(
        children: <Widget>[
          Column(
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
                        color: Color(hexcolor('#113F67')),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    (position + 1).toString() +
                        '/' +
                        widget.totalQuestions.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(hexcolor('#113F67')),
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
                    percent: (int.parse(widget.totalQuestions) *
                        (position + 1).toDouble() /
                        100),
                    backgroundColor: Colors.grey,
                    progressColor: Color(hexcolor('#113F67')),
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
                    width: 5,
                  ),
                  Text(
                    constructTime(widget.totalTime),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff113F67),
                    ),
                  ),
                  /*   Text(
                    Duration(seconds: _start)
                        .toString()
                        .split('.')
                        .first
                        .padLeft(8, "0"),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),  */
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                // color: Colors.grey,
                height: a_height,
                child: PageView.builder(
                  physics: new NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: controller,
                  itemCount: _tests.length,
                  itemBuilder: (context, position) =>
                      TestCard(_tests[position]),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            position != 0
                ? InkWell(
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
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        position = position - 1;
                      });
                      controller.jumpToPage(position);
                    },
                  )
                : InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '',
                          style: TextStyle(
                              color: Color(0xff113F67),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    onTap: () {
                      print("Submitted");
                    },
                  ),
            _tests.length - 1 > position
                ? InkWell(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Next',
                          style: TextStyle(
                              color: Color(0xff113F67),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xff113F67),
                          size: 20,
                        ),
                      ],
                    ),
                    onTap: () {
                      //   print(arr)
                      //   nextHandler();
                      setState(() {
                        position = position + 1;
                      });
                      controller.jumpToPage(position);
                    },
                  )
                : Container(
                    height: 30.0,
                    width: 100,
                    alignment: Alignment.center,
                    child: ButtonTheme(
                      minWidth: 130.0,
                      height: 30.0,
                      child: RaisedButton(
                        color: _isButtonDisabled
                            ? Color(0xffc0c0c0)
                            : Color(0xff113F67),
                        elevation: 1.0,
                        onPressed: () {
                          _isButtonDisabled ? 
                        //  null
                        Fluttertoast.showToast(
            msg: "To submit you must answer atleast one question",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
         //   textColor: Colors.black,
            timeInSecForIos: 1)
        //   toast('Please enter correct Otp');
     //   throw Exception('Failed to signin');
                           : _showDialog(context);
                        },

                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 0.5,
                              color: _isButtonDisabled
                                  ? Color(0xffc0c0c0)
                                  : Color(0xff113F67),
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(40),
                        ),

                        child: new Text(
                          "Submit",
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

  void _showDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Are you really want to Submit?"),
          actions: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text("Yes"),
                  onPressed: () {
                    //  logout();
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scoreboard(
                            testId: widget.testId,
                            scores: questionOptionArray,
                            studentTestId: widget.studentTestId),
                      ),
                    );
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
}
