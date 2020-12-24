import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:schoolapp/Screens/school_list.dart';
import 'package:schoolapp/const/style_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Otp extends StatefulWidget {
  var mobilenumber;
  Otp({Key key, this.mobilenumber}) : super(key: key);
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  int _state = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences sharedPreferences;
  String url = 'http://projects.creatise.in/school_app/users/verify-otp';
  makeRequest(var text) async {
    setState(() {
      _state = 1;
    });
    final req = {"mobile": widget.mobilenumber, "otp": controller.text};
    var response =
        await http.put(Uri.encodeFull(url), body: json.encode(req), headers: {
      "content-type": "application/json",
      "accept": "application/json",
    });
    print(widget.mobilenumber);
    // print(response.body);
    if (response.statusCode == 200) {
      Map result = json.decode(response.body);
      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      String tokenType = encoder.convert(result['responseData']['token_type']);
      String accessToken =
          encoder.convert(result['responseData']['access_token']);
      //   String userId = encoder.convert(result['responseData']['user_id']);

      //  print(tokenType);
      //  print(accessToken);
      String token = tokenType.replaceAll('"', '');
      String access = accessToken.replaceAll('"', '');

      var auth = token + " " + access;
      //  print(auth);

      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("token_type", token);
      sharedPreferences.setString("access_token", access);
      sharedPreferences.setString("auth", auth);
      // sharedPreferences.setString("id", userId);
      setState(() {
        _state = 2;
      });
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => new SchoolList()));
    } else {
      setState(() {
        _state = 0;
      });
      Fluttertoast.showToast(
          msg: "Please enter correct OTP",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 1);
      //   toast('Please enter correct Otp');
      throw Exception('Failed to signin');
    }
  }

  TextEditingController controller = TextEditingController();
  String thisText = "";
  int pinLength = 4;
  bool hasError = false;
  String errorMessage;

  Widget buildText(String text) {
    return Text(
      text,
      style: largeTextStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
          child: Stack(
        children: <Widget>[
          Container(
            height: 360,
            width: c_width,
            margin: EdgeInsets.only(bottom: 22),

            color: Color(0xff113F67),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                buildText('OTP Verification'),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 49,
                    width: 49,
                    child: Image.asset('images/sms-white.png')),
                SizedBox(
                  height: 13,
                ),
                Text(
                  'Please type the verification',
                  style: whiteTextStyle,
                ),
                Text(
                  'code sent to your mobile',
                  style: whiteTextStyle,
                ),
                SizedBox(
                  height: 40,
                ),
                buildText('Enter your OTP'),
                PinCodeTextField(
                  autofocus: true,
                  controller: controller,
                  hideCharacter: false,
                  highlight: true,
                  highlightColor: Colors.blue,
                  defaultBorderColor: Colors.white,
                  hasTextBorderColor: Colors.green,
                  maxLength: pinLength,
                  hasError: hasError,
                  //    maskCharacter: "*",highlightAnimationBeginColor: Colors.white,//😎"
                  onTextChanged: (text) {
                    setState(() {
                      hasError = false;
                    });
                  },
                  onDone: (text) {
                    print("DONE $text");
                  },
                  pinCodeTextFieldLayoutType:
                      PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                  wrapAlignment: WrapAlignment.start,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 30.0, color: Colors.white),
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                ),
                Visibility(
                  child: Text(
                    "Wrong PIN!",
                    style: TextStyle(color: Colors.red),
                  ),
                  visible: hasError,
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
            //     ),
          ),
          Positioned.fill(
            //   bottom: -20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                color: Colors.white,
                child: setUpButtonChild(),
                onPressed: () {
                  setState(() {
                    makeRequest(controller.text);
                  });
                },
              ),
            ),
          ),
        ],
      )),
    );
  }

  void toast(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 5),
    ));
  }

  setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        " Done ",
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontSize: 15.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      );
    } else {
      return Icon(Icons.check, color: Colors.blue);
    }
  }
}
