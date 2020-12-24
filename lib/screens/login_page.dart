import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:schoolapp/Screens/Otp.dart';
import 'package:schoolapp/const/style_constant.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
} 

class LoginPageState extends State<LoginPage> {
  int _state = 0;
  String url = 'http://projects.creatise.in/school_app/users/send-otp';
  makeRequest(var text) async {
    setState(() {
      _state = 1;
    });
    final req = {
      "mobile":
          //"9663581090",
          text.toString(),
    };

    print(text);
    var response =
        await http.post(Uri.encodeFull(url), body: json.encode(req), headers: {
      "content-type": "application/json",
      "accept": "application/json",
    });
    print(response.body);
    if (response.statusCode == 200) {
      Map result = json.decode(response.body);
      print(result);
      JsonEncoder encoder = new JsonEncoder.withIndent('  ');
      String mobileNum = encoder.convert(result['responseData']['mobile']);
      String otpNum = encoder.convert(result['responseData']['otp']);
      print(mobileNum);
      print(otpNum);
      String number = mobileNum.replaceAll('"', '');

      setState(() {
        _state = 2;
      });
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => new Otp(mobilenumber: number)));
      //   int.parse()
    } else {
      setState(() {
        _state = 0;
      });
      throw Exception('Failed to signin');
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController user = new TextEditingController();
  String _number;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @protected
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print(visible);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double c_height = MediaQuery.of(context).size.height * .5;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: c_height,
                margin: EdgeInsets.only(bottom: 22),

             //   color: Color(hexcolor('#113F67')),
color: Color(0xff113F67),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 50,
                        width: 50,
                        child: Image.asset('images/sms-white.png')),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'We need to text you the OTP',
                      style: whiteTextStyle,
                      /* TextStyle(color: Colors.white, fontSize: 13),  */
                    ),
                    Text(
                      'to authenticate your account',
                      style: whiteTextStyle,
                      //     TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Text(
                      'Mobile Number',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    new Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          new Container(
                            margin: const EdgeInsets.only(
                              right: 40,
                              left: 40,
                            ),
                            child: new TextFormField(
                              autofocus: true,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              controller: user,
                              decoration: const InputDecoration(
                                hintText: 'Enter Your Mobile Number',
                                hintStyle: whiteTextStyle,
                                /* TextStyle(
                                    fontSize: 12.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),   */
                                //    labelText: 'Email Id',

                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15.0),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: validateMobile,
                              onSaved: (String val) {
                                _number = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //     ),
              ),
              Positioned.fill(
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: Colors.white,
                    child: setUpButtonChild(),
                    onPressed: () {
                      setState(() {
                        if ((_state == 0) && (_validateInputs(context) == 0)) {
                          _validateInputs(context);
                        }
                      });
                    },
                    /*         child: RaisedButton(
                    elevation: 8,
                    child: Text(
                      ' Confirm ',
                      style: TextStyle(
                        color: Color(hexcolor('#113F67')),
                      ),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      _validateInputs(context);
                    },
                    textColor: Colors.black,
                  ),   */
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  _validateInputs(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('ooooooooooooooo');
      makeRequest(user.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Confirm",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
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
