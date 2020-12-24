import 'package:flutter/material.dart';
import 'package:schoolapp/const/style_constant.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<int> _listData = List<int>.generate(100, (i) => i);

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.7;
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff113F67),
        centerTitle: true,
        elevation: 7.0,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Notifications',
              style: largeTextStyle,
            ),
          ],
        ),
      ),
      body: ListView(
        // padding: EdgeInsets.all(8.0),

        children: _listData.map((i) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: i % 4 == 0
                ? Container(
                    color: Colors.grey.withOpacity(.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Sep 10 Tuesday",
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                            )),
                        Text("2 day ago",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                    padding: EdgeInsets.all(5.0),
                  )
                //  SizedBox(height: 5);
                : //ListTile(
                //      title: //Text("Item $i"),

                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        height: 48.0,
                        width: 95.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          image: DecorationImage(
                            image: ExactAssetImage('images/school2.jpg'),
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Creatise School',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            width: c_width,
                            child: Text(
                              'Parents Meeting on Oct 21',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.left,
                              maxLines: null,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: c_width,
                            child: Text(
                              'Please make him to work more on science topics.',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                              maxLines: null,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ), // Divider(height: 1.0, color: Colors.red),
                        ],
                      ),
                    ],
                  ),
          );
        }).toList(),
      ),
    );
  }
}
