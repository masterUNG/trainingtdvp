import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdvp/components/backend/services/services.dart';
import 'package:tdvp/components/frontend/customer/service/services.dart';
import 'package:tdvp/components/frontend/guest/home/homepage.dart';
import 'package:tdvp/models/users_model.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/splash',
    page: () => SplashPage(),
  ),
  GetPage(
    name: '/customer',
    page: () => CustomerService(),
  ),
  GetPage(
    name: '/admin',
    page: () => AdminService(),
  ),
];
String firstPage = '/splash';

Future<void> main() async {
  //Orientation
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) async {
    print('## initial OK #################');
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        print('## event ไม่เท่ากัน null');

        String uid = event.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get()
            .then((value) {
          print('## value ----> ${value.data()}');

          UserModel userModel = UserModel.fromMap(value.data()!);

          print('## level ---> ${userModel.level}');

          firstPage = '/${userModel.level}';
          runApp(MyApp());
        });
      } else {
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //primaryColor: Color(0xff0d569f),
          primaryColor: Color(0xff041f78),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white),
      // home: SplashPage(),
      getPages: getPages,
      initialRoute: firstPage,
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const HomePage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xff044697),
              Color(0xff033168),
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
