import 'package:flutter/material.dart';
import 'package:schoolapp/components/student_listcard.dart';
import 'package:schoolapp/models/students_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class StudentList extends StatefulWidget {
  var schoolListId;
  StudentList({Key key, this.schoolListId}) : super(key: key);
  @override
  StudentListState createState() => StudentListState();
}

class StudentListState extends State<StudentList> {
  var schoolId;

  List<StudentListModel> _list = <StudentListModel>[];

  Future _getStudents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    setState(() {
      schoolId = widget.schoolListId.toString();
    });
    final String url =
        'http://projects.creatise.in/school_app/student-academics?school_id=$schoolId';

    //  widget.data;
    print(widget.schoolListId.toString());
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    if (response.statusCode == 200) {
      print('some thing');
      var result = json.decode(response.body);
      print(result);
      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      var StudentDetails = result['responseData']['data'];
      var StudentBioId = result['responseData']['data'][0]['student_bio_id'];
      prefs.setString("student_bio_id", StudentBioId.toString());
      //     prefs.setString("data", StudentDetails());

      print(StudentBioId.toString());
      print(StudentDetails);
      final items = StudentDetails.cast<Map<String, dynamic>>();

      List<StudentListModel> listOfUsers = items.map<StudentListModel>((json) {
        if (mounted) {
          setState(() {
            _list.add(StudentListModel.fromJson(json));
          });
        } else {
          Text('Loading...');
        }
      }).toList();
      print('returning list');

      return listOfUsers;
    } else {
      print('fail');
      throw Exception('Failed to load internet');
    }
  }

  @override
  void initState() {
    super.initState();
    _getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) => StudentListWid(_list[index]),
      ),
    );
  }
}
