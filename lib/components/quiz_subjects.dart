import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/subject_topics.dart';
import 'package:schoolapp/models/subject_list.dart';

_QuizSubjectsState subjectsState;

class QuizSubjects extends StatefulWidget {
  final SubjectList _sublist;
  QuizSubjects(this._sublist);
  @override
  _QuizSubjectsState createState() {
    subjectsState = _QuizSubjectsState(_sublist);
    return subjectsState;
  }
}

class _QuizSubjectsState extends State<QuizSubjects> {
  final SubjectList slist;
  _QuizSubjectsState(this.slist);

  hexcolor(String colorhexcode) {
    String colornew = '' + colorhexcode;
    colornew = colornew.replaceAll('#', '0xff');
    int colorint = int.parse(colornew);
    return colorint;
  }

  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;
    //  double d_height = MediaQuery.of(context).size.height *1;
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Container(
            height: 90,

            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                color: Color(hexcolor(slist.subColor.toString())),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[],
                      ),
                      new Container(
                        height: 10.0,
                        width: 10.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white70,
                          backgroundImage: NetworkImage(slist.subjectLogo),
                          radius: 150.0,
                        ),
                      ),
                      /*     Icon(
                        Icons.star_border,
                        color: Colors.white,
                        size: 23,
                      ),   */
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        //   'English',
                        slist.subjectName,
                        style: TextStyle(
                            color: Color(hexcolor(slist.subTextColor.toString())),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ]),
              ),
            ),
            //     ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SubTopics(
                  subjectName: slist.subjectName,
                  subjectId: slist.subId.toString(),
                  subjectLogo: slist.subjectLogo,
                ),
              ),
            );
          },
        ),
      ],
      //  ),
    );
  }
}
