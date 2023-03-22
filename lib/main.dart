import 'package:cheezy_diaries/screens/home_page.dart';
import 'package:cheezy_diaries/screens/journal/add_journal.dart';
import 'package:cheezy_diaries/screens/journal/logs_list.dart';
import 'package:cheezy_diaries/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      
    );
  }

 

}
 