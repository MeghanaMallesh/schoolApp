import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/home_page.dart';
import 'package:schoolapp/const/style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  var eventId;
  DetailsPage({Key key, this.eventId}) : super(key: key);
  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  bool _loading = false;
  var eventName;
  var description1;
  var memoFor;
  var attachments;
  var clr;
  int attach;
  hexcolor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  eventDetails() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));

    final String url =
        'http://projects.creatise.in/school_app/student-diaries/' +
            widget.eventId.toString();
    print(widget.eventId.toString());
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    if (response.statusCode == 200) {
      print('some thing');
      Map result = json.decode(response.body);
      print(result);
      var eName = result['responseData']['title'];
      var description = result['responseData']['description'];
      var memoFor1 = result['responseData']['memo_for'];
      var memoType = result['responseData']['memo_type']['color_code'];
      setState(() {
        attachments = result['responseData']['attachment'];
        _loading = false;
      });
      print(attachments);
      print("akash");

      memoFor = memoFor1;

      print(attach);

      eventName = eName;
      clr = memoType;

      print(eventName);
      description1 = description;
      print(description1);
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  @override
  void initState() {
    eventDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.9;
    double d_width = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(hexcolor('#113F67')),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Event Details',
          style: largeTextStyle,
        ),
      ),
      body: !_loading
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: d_width,
                          child: Text(
                            eventName,
                            textAlign: TextAlign.left,
                            maxLines: null,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 17,
                          width: 47,
                          decoration: new BoxDecoration(
                            color: Color(hexcolor(clr)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            memoFor,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: c_width,
                          child: Text(
                            description1,
                            textAlign: TextAlign.left,
                            maxLines: null,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: stuProfTextStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    attachments.length > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                  children: attachments
                                      .map<Widget>(
                                        (item) => InkWell(
                                          child: Icon(
                                            item['type'].contains('image')
                                                ? Icons.image
                                                : Icons.picture_as_pdf,
                                            color: Colors.blue,
                                            size: 70.0,
                                          ),
                                          onTap: () async {
                                            final url =
                                                "http://projects.creatise.in/school_app/api/downloads?file=${item['filename']}&display_filename=${item['display_filename']}";
                                            print(url);
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                        ),
                                      )
                                      .toList()),
                            ],
                          )
                        : Text(
                            " No Attachments for this events",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                  ]),
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  getSchoolName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolName = (prefs.getString('name'));
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new HomePage(schoolName: schoolName)));
  }
}
