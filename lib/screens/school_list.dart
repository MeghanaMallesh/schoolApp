import 'package:flutter/material.dart';
import 'package:schoolapp/components/school_listcard.dart';
import 'package:schoolapp/models/school_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SchoolList extends StatefulWidget {
  @override
  _SchoolListState createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {
  var sname;
  var coverImage;

  List<SchListModel> _list = <SchListModel>[];
  SharedPreferences sharedPreferences;
  Future _getSchools() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String auth = (prefs.getString('auth'));
    final String url =
        'http://projects.creatise.in/school_app/user-schools?get_auth_school=yes';

    var response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json", "Authorization": auth});
    print('after');
    if (response.statusCode == 200) {
      print('some thing');
      var result = json.decode(response.body);
      print(result);
      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      var SchoolDetails = result['responseData']['data'];

      var SchoolId = result['responseData']['data'][0]['school_id'];
      var SchoolName = result['responseData']['data'][0]['schools'][0]['name'];
      prefs.setString("school_id", SchoolId.toString());
      prefs.setString('name', SchoolName);

      print(SchoolName);
      final items = SchoolDetails.cast<Map<String, dynamic>>();

      List<SchListModel> listOfUsers = items.map<SchListModel>((json) {
        if (mounted) {
          print(SchListModel.fromJson(json));
          print("hello");
          setState(() {
            _list.add(SchListModel.fromJson(json));
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
    _getSchools();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) => SchoolListWid(_list[index]),
      ),
    );
  }
}
