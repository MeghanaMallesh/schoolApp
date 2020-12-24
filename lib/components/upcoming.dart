import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/quiz_details.dart';
import 'package:schoolapp/models/quiz_topicslist.dart';

class Upcoming extends StatefulWidget {
  final TopicListModel _toplist;
  Upcoming(this._toplist);
  @override
  _UpcomingState createState() => _UpcomingState(_toplist);
}

class _UpcomingState extends State<Upcoming> {
  final TopicListModel tlist;
  _UpcomingState(this.tlist);

  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 1;
    return new Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            child: Container(
                //   height: 110,
                width: c_width,
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tlist.topicName,
                              //   "Animal Kingdom",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  tlist.totalQuestions.toString() +
                                      ' ' +
                                      'Questions',
                                  //    '25 Questions',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  tlist.totalMarks.toString() + ' ' + 'Marks',
                                  //   '25 Marks',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'End Date: ' + tlist.endDate,
                          //  'End Date:15/11/19',
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),
                      ],
                    ),
                    //   ],
                  ),
                )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizStartPage(
                      totalQuestions: tlist.totalQuestions,
                      testId: tlist.testId.toString()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
