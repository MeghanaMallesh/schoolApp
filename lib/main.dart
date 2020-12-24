import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schoolapp/screens/spalsh_screen.dart';

void main() => runApp(MyApp());
// void main() async {
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  hexcolor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  @override
  void initState() {
    super.initState();
    //  checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(hexcolor('#113F67')),
      ),
      home: SplashScreen(),
    );
  }
}
