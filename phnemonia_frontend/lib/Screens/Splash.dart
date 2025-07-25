import 'package:flutter/material.dart';
import 'dart:async';
import 'package:x_ray_app/Screens/Home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

void initState(){

    super.initState();

    Timer(const Duration(seconds: 5),
    () {
     Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) =>HomeScreen()
      )
     );
    },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:Container(
          
          color: Colors.amberAccent,
          height: 80,
          width: 200,
          child:Center(
            child: Row(
              children: [
                Text('Diagnose IT',
                
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontStyle: FontStyle.italic
                ),
                ),
                SizedBox(width: 10,),
                Icon(FontAwesomeIcons.stethoscope, size: 30, color: Colors.green),
              ],
            ),
          )
        ) ,
      ),
    ) ;
  }
}