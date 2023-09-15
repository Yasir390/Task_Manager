import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/style.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(context),
          Container(
            padding: EdgeInsets.all(30),
            child: Center(
              child: Image.asset("assets/images/logo.png",
                width: 230,
                height:90,
                alignment: Alignment.center,),

            ),
          )
        ],
      ),
    );
  }
}
