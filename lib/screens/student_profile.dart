import 'package:flutter/material.dart';
import 'package:schoolapp/components/bottom_navbar.dart';
import 'package:schoolapp/const/style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class StudentProfile extends StatefulWidget {
  var studentBioId;
  StudentProfile({Key key, this.studentBioId}) : super(key: key);
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  bool _loading = false;

  var fName;
  var lName;
  var schoolName;
  var stuClass;
  var stuSection;
  var dob;
  var rollNo;
  var admDate;
  var profilepic;
  Future studentDetails() async {
    setState(() {
      _loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    final String url =
        'http://projects.creatise.in/school_app/student-academics?' +
            widget.studentBioId.toString();

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

      var firstname =
          result['responseData']['data'][0]['student']['first_name'];
      var lastName = result['responseData']['data'][0]['student']['last_name'];
      var sClass = result['responseData']['data'][0]['class']['class_name'];
      var section =
          result['responseData']['data'][0]['section']['section_name'];
      var sdob = result['responseData']['data'][0]['student']['dob'];
      var photo = result['responseData']['data'][0]['student']['photo'];
      var sname = result['responseData']['data'][0]['school']['name'];
      var sadm = result['responseData']['data'][0]['section']['section_name'];
      var usn = result['responseData']['data'][0]['student']['usn'];

      setState(() {
        fName = firstname;
        lName = lastName;
        schoolName = sname;
        stuClass = sClass;
        stuSection = section;
        rollNo = usn;
        dob = sdob;
        admDate = sadm;
        profilepic = photo;
      });
      print(fName);
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  var fatherName;
  var parentMobileNo;
  var parentMailId;
  var parentAdrees;
  var motherName;
  var relationTypeFa;
  var relationTypeMa;
  Future parentDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));

    final String url =
        'http://projects.creatise.in/school_app/parent-bios?student_bio_id=' +
            widget.studentBioId.toString();

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    if (response.statusCode == 200) {
      print('some thing');
      var result = json.decode(response.body);
      print(result);

      var faName = result['responseData']['data'][0]['first_name'];
      var maName = result['responseData']['data'][1]['first_name'];
      var mobile = result['responseData']['data'][0]['mobile'];
      var email = result['responseData']['data'][0]['email'];
      var address = result['responseData']['data'][0]['address'];
      var relType1 = result['responseData']['data'][0]['relation_type'];
      var relType2 = result['responseData']['data'][1]['relation_type'];
      fatherName = faName;
      motherName = maName;
      parentMobileNo = mobile;
      parentMailId = email;
      parentAdrees = address;
      relationTypeFa = relType1;
      relationTypeMa = relType2;
      print(relationTypeFa);
      print(relationTypeMa);
      print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
      print(fatherName);
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  bool stinfo = true;
  TextStyle countStyle = TextStyle(fontSize: 20);

  TextStyle active = TextStyle(color: Colors.red);

  final tabText = TextStyle(fontSize: 12);

  @protected
  void initState() {
    super.initState();
    studentDetails();
    parentDetails();
  }

  Widget buildStudentInfoText(String text) {
    return Text(
      text,
      //   'First Name',
      style:
          studentInfoTextStyle, /* TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),  */
    );
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.4;
    double d_width = MediaQuery.of(context).size.width * 0.4;
    double e_width = MediaQuery.of(context).size.width * 1;
    double h_height = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      body: !_loading
          ? Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: h_height,
                      width: e_width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('images/background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          profilepic != null
                              ? Container(
                                  height: 110,
                                  width: 110,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white24,
                                    backgroundImage:
                                        ExactAssetImage(profilepic),
                                    //     'images/boy2.png'),
                                    radius: 100,
                                  ),
                                )
                              : Container(
                                  height: 110,
                                  width: 110,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "https://www.cornwallbusinessawards.co.uk/wp-content/uploads/2017/11/dummy450x450.jpg"),
                                    //     'images/boy2.png'),
                                    radius: 100,
                                  ),
                                ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            fName + ' ' + lName,
                            //    "ARVINDH TIWARI",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            //stuClass+' '+stuSection,
                            stuClass +
                                ' ' +
                                ('Std') +
                                ' ' +
                                stuSection +
                                ' ' +
                                ('Section'),
                            //  "2nd Std, 'A' Section",
                            style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            schoolName,
                            //  "Creatise School",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      //r  ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Student Info',
                        style: TextStyle(
                            fontSize: 13,
                            color: stinfo ? Colors.white : Color(0xff113F67)),
                      ),
                      color: stinfo ? Color(0xff113F67) : Colors.white70,
                      onPressed: () {
                        setState(() {
                          stinfo = true;
                        });
                      },
                      textColor: Colors.black,
                    ),
                    RaisedButton(
                      child: Text(
                        'Parents Info',
                        style: TextStyle(
                            fontSize: 13,
                            color: stinfo ? Color(0xff113F67) : Colors.white),
                      ),
                      color: stinfo ? Colors.white70 : Color(0xff113F67),
                      onPressed: () {
                        setState(() {
                          stinfo = false;
                        });
                      },
                      textColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: stinfo
                        ? Container(
                            alignment: Alignment.center,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        buildStudentInfoText('First Name'),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(':'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: c_width,
                                          child: Text(
                                            fName,
                                            //   'Arvindh',
                                            textAlign: TextAlign.left,
                                            maxLines: null,
                                            overflow: TextOverflow.clip,
                                            softWrap: true,
                                            style: stuProfTextStyle,
                                            /* TextStyle(
                                              fontSize: 14,
                                            ),  */
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        buildStudentInfoText('Last Name'),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(':'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: c_width,
                                          child: Text(lName,
                                              //     'Tiwari',
                                              textAlign: TextAlign.left,
                                              maxLines: null,
                                              overflow: TextOverflow.clip,
                                              softWrap: true,
                                              style: stuProfTextStyle),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        buildStudentInfoText('Date of Birth'),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(':'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(dob,
                                            //      '15-06-2012',
                                            style: stuProfTextStyle),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        buildStudentInfoText('Roll Number'),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(':'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          rollNo.toString() == null
                                              ? Text('0')
                                              : rollNo.toString(),
                                          //      '09',
                                          style: stuProfTextStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        buildStudentInfoText('Admission Year'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(':'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('2019', style: stuProfTextStyle),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: Card(
                                child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      buildStudentInfoText("Father's Name"),
                                      SizedBox(
                                        width: 33,
                                      ),
                                      Text(':'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: c_width,
                                        child: Text(
                                            fatherName != null
                                                ? fatherName
                                                : "",
                                            // 'Anand Tiwari',
                                            textAlign: TextAlign.left,
                                            maxLines: null,
                                            overflow: TextOverflow.clip,
                                            softWrap: true,
                                            style: stuProfTextStyle),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      buildStudentInfoText("Mother's Name"),
                                      SizedBox(
                                        width: 28,
                                      ),
                                      Text(':'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: c_width,
                                        child: Text(motherName,
                                            //     'Lakshmi Tiwari',
                                            textAlign: TextAlign.left,
                                            maxLines: null,
                                            overflow: TextOverflow.clip,
                                            softWrap: true,
                                            style: stuProfTextStyle),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      buildStudentInfoText('Contact Number'),
                                      SizedBox(
                                        width: 17,
                                      ),
                                      Text(' :'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(parentMobileNo,
                                          //     '9788456365',
                                          style: stuProfTextStyle),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      buildStudentInfoText('Email-Id'),
                                      SizedBox(
                                        width: 64,
                                      ),
                                      Text('  :'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: c_width,
                                        child: Text(
                                          parentMailId,
                                          //     'Anand123@gmail.com',
                                          textAlign: TextAlign.left,
                                          maxLines: null,
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                          style: stuProfTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      buildStudentInfoText('Address'),
                                      SizedBox(
                                        width: 64,
                                      ),
                                      Text('  :'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: d_width,
                                        child: Text(parentAdrees,
                                            //     ' No.16 halalli,8th Cross, Main road, Mysore Road ,Bangalore 560067.',
                                            textAlign: TextAlign.left,
                                            maxLines: null,
                                            overflow: TextOverflow.clip,
                                            softWrap: true,
                                            style: stuProfTextStyle),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                          ),
                  ),
                ),
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
