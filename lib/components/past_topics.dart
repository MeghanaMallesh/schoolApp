import 'package:flutter/material.dart';
import 'package:schoolapp/models/past_topiclist.dart';

class PastTopics extends StatefulWidget {
  final PastTopicModel _toplist;
  PastTopics(this._toplist);
  @override
  _PastTopicsState createState() => _PastTopicsState(_toplist);
}

class _PastTopicsState extends State<PastTopics> {
  final PastTopicModel tlist;
  _PastTopicsState(this.tlist);
  bool changebtn = true;
  
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * .95;
    return new Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              //   height: 110,
              width: c_width,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            //    "Animal Kingdom",
                            tlist.topicName,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            //   "13 marks",
                            tlist.totalMarks.toString() + ' ' 'marks',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      //  SizedBox(width: 100,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 26,
                            width: 25,
                            decoration: new BoxDecoration(
                              //    color: Colors.transparent,
                              //   Image(
                              image: DecorationImage(
                                image: AssetImage('images/goldmedal.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          //  Icon(Icons.star),
                          Text(
                            //   '23 points',
                            tlist.testScore.toString(),
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //   ],
                ),
              )),
          //   ),
        ],
      ),
    );
  }
}
