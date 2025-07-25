import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:x_ray_app/Screens/upload.dart'; // Important for File

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          
          children: [
            Icon(Icons.home),
            Text('Home')
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Diagnose IT ',
                    style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen,
                              fontStyle: FontStyle.italic
                            ),),
                    Icon(FontAwesomeIcons.stethoscope, size: 30, color: Colors.blue),
                  ],
                ),
                SizedBox(height: 20,),
                Text("The app allows  to check whether a person is affected with phnemonia or not by simply sharing the x-ray image of the chest."),
                SizedBox(height: 20,),
                Text("The image you want to upload should look like this :"),
                SizedBox(height: 10,),
                Image.asset("assets/images/example_x_ray.jpeg",height: 200, width: 350, ),
                SizedBox(height: 20,),
                Text('Click the below button to diagnose '),
                SizedBox(height: 10,),
                ElevatedButton(
                  
              
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder:(context)=>UploadScreen() )
                      );
                  },
                   child:Icon(FontAwesomeIcons.stethoscope, size: 30, color: Colors.black), )
                
              ],
            ),
          ),

          )
          ),

    );
  }
}