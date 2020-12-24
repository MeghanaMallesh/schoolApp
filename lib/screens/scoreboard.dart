import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/leaderboard.dart';
import 'package:http/http.dart' as http;
import 'package:schoolapp/screens/home_page.dart';
import 'package:schoolapp/screens/quiz_subjectspage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Scoreboard extends StatefulWidget {
  var testId, scores, studentTestId;
  Scoreboard({Key key, this.testId, this.scores, this.studentTestId})
      : super(key: key);
  @override
  _ScoreboardState createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  var TestScore;
  var CorrectAns;
  var WrongAns;
  var AttemptedQn;
  var TotalQuestions;
  bool _loading = false;
  getScoreboard() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    String schoolId = (prefs.getString('school_id'));
    String studentBioId = (prefs.getString('student_bio_id'));

    final String url =
        'http://projects.creatise.in/school_app/student-test-question-answers';

    var req = {
      "school_id": schoolId,
      "student_bio_id": studentBioId,
      "test_id": widget.testId,
      "student_test_id": widget.studentTestId,
      //   startQuiz.Id.toString(),
      "questionOptionArray": widget.scores,
    };

    var response = await http.post(Uri.encodeFull(url),
        body: json.encode(req),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');

    if (response.statusCode == 201) {
      print('some thing');
      Map result = json.decode(response.body);
      print(result);
      var testScore = result['responseData']['test_score'];
      var totalQuestions = result['responseData']['no_of_question'];
      var totalAttempted = result['responseData']['total_attempted'];
      var correctAns = result['responseData']['total_correct_answer'];
      var wrongAns = result['responseData']['total_wrong_answer'];
      print(result);

      //  var endDate = result['responseData']['end_date'];
      setState(() {
        //   attchments = result['responseData']['attachment'];
        _loading = false;
      });
      TotalQuestions = totalQuestions;
      TestScore = testScore;
      WrongAns = wrongAns;
      CorrectAns = correctAns;
      AttemptedQn = totalAttempted;
      // EndDate=endDate;
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  @override
  void initState() {
    getScoreboard();
    super.initState();
  }

  @override
  void didUpdateWidget(Scoreboard oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double e_height = MediaQuery.of(context).size.height * .5;
    double a_height = MediaQuery.of(context).size.height * .18;
    return new Scaffold(
      backgroundColor: Colors.white,
      body: !_loading
          ? NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Color(0xff113F67),
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    expandedHeight: e_height,
                    floating: false,
                    pinned: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            height: 45,
                            width: 65,
                            decoration: new BoxDecoration(
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
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 100.0,
                                height: 20.0,
                                child: RaisedButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Leaderboard(),
                                      ),
                                    );
                                  },
                                  textColor: Color(0xff113F67),
                                  padding: const EdgeInsets.all(5.0),
                                  child: new Text(
                                    " View Leaderboard ",
                                    style: TextStyle(
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        background: Container(
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/scoreboard.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: a_height,
                              ),
                              Text(
                                //   "70 Points Earned",
                                TestScore.toString() + " " + 'Points Earned',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Biology',
                          style: TextStyle(
                              fontSize: 19.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    new Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 0),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: new Text(
                                "        Total Questions       ",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        new Positioned(
                          bottom: -19,
                          child: new Container(
                            child: new Column(
                              children: <Widget>[
                                //  bottom: 50.0,
                                Container(
                                  height: 81,
                                  width: 62,
                                  decoration: new BoxDecoration(
                                    //    color: Colors.transparent,
                                    //   Image(
                                    image: DecorationImage(
                                      image: AssetImage('images/rectangle.png'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(22, 29, 10, 10),
                                    child: Text(
                                      //   '25',
                                      TotalQuestions < 10
                                          ? '0' + TotalQuestions.toString()
                                          : TotalQuestions.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  //  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    new Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 0),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: new Text(
                                "     Attempted Questions",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        new Positioned(
                          //  top: 10,
                          //    right: 165,
                          bottom: -19,
                          //   left: -10,
                          child: new Container(
                            child: new Column(
                              //  mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //  bottom: 50.0,
                                Container(
                                  height: 81,
                                  width: 62,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/rectangle.png'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(22, 29, 10, 10),
                                    child: Text(
                                      AttemptedQn < 10
                                          ? '0' + AttemptedQn.toString()
                                          : AttemptedQn.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  //  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: new Text(
                                "        Correct Answers     ",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        new Positioned(
                          bottom: -19,
                          child: new Container(
                            child: new Column(
                              children: <Widget>[
                                Container(
                                  height: 81,
                                  width: 62,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/rectangle.png'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        22, 29, 10, 10),
                                    child: Text(
                                      //   '13',
                                      CorrectAns < 10
                                          ? '0' + CorrectAns.toString()
                                          : CorrectAns.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    new Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: new Text(
                                "       Incorrect Answers    ",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        new Positioned(
                          bottom: -19,
                          child: new Container(
                            child: new Column(
                              children: <Widget>[
                                Container(
                                  height: 81,
                                  width: 62,
                                  decoration: new BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/rectangle.png'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        22, 29, 10, 10),
                                    child: Text(
                                      WrongAns < 10
                                          ? '0' + WrongAns.toString()
                                          : WrongAns.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: Container(
        height: 50.0,
        width: 350,
        alignment: Alignment.center,
        child: ButtonTheme(
          minWidth: 130.0,
          height: 30.0,
          child: RaisedButton(
            color: Color(0xff113F67),
            elevation: 1.0,
            onPressed: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizSubPage(),
                ),
              );
            },
            padding: const EdgeInsets.fromLTRB(10, 10, 25, 10),
            child: new Text(
              "    Take New Quiz    ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
