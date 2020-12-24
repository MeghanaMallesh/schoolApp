import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/Student_List.dart';
import 'package:schoolapp/models/school_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchoolListWid extends StatefulWidget {
  final SchListModel _schlist;
  SchoolListWid(this._schlist);

  @override
  _SchoolListWidState createState() => _SchoolListWidState(_schlist);
}

class _SchoolListWidState extends State<SchoolListWid> {
  final SchListModel slist;
  _SchoolListWidState(this.slist);

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * .9;
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //     SizedBox(height: 30,),
        InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 30, 3, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          image: DecorationImage(
                              image:
                                  //    (slist.coverImage != null)
                                  //     ? NetworkImage(" http://projects.creatise.in/school_app/" + slist.coverImage)
                                  ExactAssetImage('images/schoolbui.jpg'),
                              fit: BoxFit.cover),
                        ),
                        //  color: Colors.pink,
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 40.0),
                        width: c_width,
                      ),
                    ),
                    /*     Padding(
                    padding: const EdgeInsets.fromLTRB(18, 30, 3, 0),
                    child : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        image: DecorationImage(
                            image: (slist.coverImage != null)
                                ? NetworkImage(" http://projects.creatise.in/school_app/" + slist.coverImage)
                                : ExactAssetImage('images/schoolbui.jpg'),
                            fit: BoxFit.cover),
                      ),
                      //  color: Colors.pink,
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 40.0),
                      width: c_width,
                    ),
                  ),  */

                    Positioned(
                      right: 20,
                      left: MediaQuery.of(context).size.width * .1,
                      bottom: 0,
                      child: Container(
                        width: c_width,
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  slist.schoolName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 33,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .61,
                                      child: Text(
                                        slist.address,
                                        //    'No.16 halalli, 8th Cross, Main road, Mysore Road , Bangalore 560067',
                                        //   cpost.caption,
                                        textAlign: TextAlign.left,
                                        maxLines: null,
                                        overflow: TextOverflow.clip,
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              getSchoolId();
              //    Navigator.pop(context);
            }),
      ],
    );
  }

  getSchoolId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("school_id", slist.id.toString());
    Navigator.pop(context);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new StudentList(
                  schoolListId: slist.id,
                )));
  }
}
