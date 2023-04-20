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
    return Container(
      color: Color(0xFFE9E9E9),
      height: 100,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 67,
                decoration: BoxDecoration(
                  color: Color(0xFF0D202E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
              bottom: 0,
              child: Align(
                heightFactor: 67,
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    _buildNavItem(Icons.mail, 0),
                    _buildNavItem(Icons.bar_chart, 1),
                    _buildNavItem(Icons.person, 2),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 2) {
              Get.to(() => const Profile(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 500));
            } else if (_selectedIndex == 0) {
              Get.to(() => const Home(),
                  transition: Transition.leftToRight,
                  duration: const Duration(milliseconds: 500));
            }
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: CircleAvatar(
            backgroundColor: isSelected ? Color(0xffE9E9E9) : Color(0xff0D202E),
            radius: isSelected ? 40 : 28,
            child: CircleAvatar(
              backgroundColor: Color(0xff0D202E),
              radius: 28,
              child: Icon(
                icon,
                size: 40,
                color: isSelected ? Color(0xFFE26127) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
