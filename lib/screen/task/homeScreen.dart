import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/component/cancelTaskList.dart';
import 'package:taskmanager/component/completedTaskList.dart';
import 'package:taskmanager/component/progressTaskList.dart';

import '../../component/TaskAppBar.dart';
import '../../component/appBottomNav.dart';
import '../../component/newTaskList.dart';
import '../../utility/utility.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {


  int TabIndex=0;
  Map<String,String> ProfileData={"email":"","firstName":"","lastName":"","photo":DefaultProfilePic};

  onItemTapped(int index){
    setState(() {
      TabIndex=index;
    });
  }


  final widgetsOptions=[
    newTaskList(),
    progressTaskList(),
    completedTaskList(),
    cancelTaskList(),
  ];

  ReadAppBarData() async {
    String? email= await ReadUserData('email');
    String? firstName= await ReadUserData('firstName');
    String? lastName= await ReadUserData('lastName');
    String? photo= await ReadUserData('photo');

    setState(() {
      ProfileData={"email":"$email","firstName":"$firstName","lastName":"$lastName","photo":DefaultProfilePic};
    });

  }

  @override
  void initState() {
    ReadAppBarData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:TaskAppBar(context,ProfileData),
      body:widgetsOptions.elementAt(TabIndex),
      bottomNavigationBar: appBottomNav(TabIndex,onItemTapped),
    );
  }
}
