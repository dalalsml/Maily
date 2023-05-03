import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maily/screens/connexion.dart';
import 'package:maily/screens/profile.dart';

class AnimatedBottomNavBar extends StatefulWidget {
  final int ind;
  const AnimatedBottomNavBar(this.ind);
  @override
  _AnimatedBottomNavBarState createState() => _AnimatedBottomNavBarState(ind);
}

class _AnimatedBottomNavBarState extends State<AnimatedBottomNavBar> {
  int _selectedIndex;

  _AnimatedBottomNavBarState(this._selectedIndex);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Color(0xffE9E9E9),
      color:Color(0xff0D202E) ,
      animationDuration: Duration(milliseconds: 300),
      items: [
        Icon(Icons.mail,size:35,color:_selectedIndex == 0? Color(0xffE26127):Color(0xffE9E9E9),),
        Icon(Icons.bar_chart,size:35,color:_selectedIndex == 1? Color(0xffE26127):Color(0xffE9E9E9),),
        Icon(Icons.person,size:35,color:_selectedIndex == 2? Color(0xffE26127):Color(0xffE9E9E9),)
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          if (_selectedIndex == 2) {
            Get.to(  duration: const Duration(milliseconds: 900),() => const Profile(),
              transition: Transition.fadeIn
            );
          } else if (_selectedIndex == 0) {
            Get.to( duration: const Duration(milliseconds: 900),() => const Home(),
                transition: Transition.fadeIn
            );
          }
        });
      },
      index: _selectedIndex, // Set the initial selected index here
    );
  }
}