import 'package:flutter/material.dart';
import 'package:schoolapp/models/student_rank.dart';

class StudentRank extends StatefulWidget {
  final StudentRankModel _stulist;
  StudentRank(this._stulist);

  @override
  _StudentRankState createState() => _StudentRankState(_stulist);
}

class _StudentRankState extends State<StudentRank> {
  final StudentRankModel slist;
  _StudentRankState(this.slist);
 
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * .95;
    return new Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "4",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      new Container(
                        height: 35.0,
                        width: 35.0,
                        child: CircleAvatar(
                          backgroundImage: ExactAssetImage('images/boy2.png'),
                          radius: 150.0,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        //   'Amith'
                        slist.studentName,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 26,
                        width: 25,
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/averagemedal.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      //  Icon(Icons.star),
                      Text(
                        //     '23 points',
                        slist.testScore.toString(),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
