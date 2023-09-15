import 'package:flutter/material.dart';
import 'package:taskmanager/style/style.dart';

BottomNavigationBar appBottomNav(currentIndex,onItemTapped){

  return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
           label: "New"
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
           label: "Progress"
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
           label: "Completed"
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.cancel_outlined),
           label: "Canceled"
        ),
      ],
      selectedItemColor: colorGreen,
      unselectedItemColor: colorLightGray,
      showUnselectedLabels:true,
      showSelectedLabels: true,
      currentIndex: currentIndex,
      onTap: onItemTapped,
    type: BottomNavigationBarType.fixed,

  );
}