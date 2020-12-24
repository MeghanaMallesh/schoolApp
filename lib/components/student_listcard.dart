import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/home_page.dart';
import 'package:schoolapp/models/students_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentListWid extends StatefulWidget {
  final StudentListModel _stulist;
  StudentListWid(this._stulist);

  @override
  _StudentListWidState createState() => _StudentListWidState(_stulist);
}

class _StudentListWidState extends State<StudentListWid> {
  final StudentListModel slist;
  _StudentListWidState(this.slist);

  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * .8;

    return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Container(
              width: c_width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            slist.coverImage != null
                                ? new Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white70,
                                      backgroundImage:
                                          ExactAssetImage('images/boy2.png'),
                                      radius: 150.0,
                                    ),
                                  )
                                : Container(
                                    height: 50.0,
                                    width: 50.0,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white70,
                                      backgroundImage: NetworkImage(
                                          "https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg"),
                                      //  ExactAssetImage('images/boy2.png'),
                                      radius: 150.0,
                                    ),
                                  ),
                            SizedBox(width: 12),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  slist.studentFName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 1),
                                RichText(
                                  text: TextSpan(
                                    text: slist.className + ' ' + 'Std' + ' ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.black54),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            slist.sectionName + ' ' + 'Section',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .52,
                                  child: Text(
                                    slist.schoolName,
                                    textAlign: TextAlign.left,
                                    maxLines: null,
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      getSchoolName();
                    },
                  ),
                ),
              )),
          //    Text('Logout'),
        ]);
  }

  getSchoolName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("student_bio_id", slist.id.toString());
    // Navigator.pop(context);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new HomePage()));
  }
}
