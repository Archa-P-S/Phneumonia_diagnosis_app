import 'package:flutter/material.dart';
import 'package:x_ray_app/Screens/Splash.dart';

void main(){
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.greenAccent
            )
        ),
        home: SplashScreen(),
    );
  }
}
