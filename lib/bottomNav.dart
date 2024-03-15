import 'package:flutter/material.dart';
import 'package:skylightDemo/core/colors.dart';
import 'package:skylightDemo/features/home/pages/home.dart';

Widget bottomNavigation(
    {required BuildContext context,
    required int selectedIndex,
    required var onItemTapped}) {
  return Container(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: Container(
      decoration: BoxDecoration(      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
  ,color: AppColors.primaryAppColor,
),
      
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.secondaryLightColor,
        unselectedItemColor: Colors.white,
        backgroundColor: AppColors.primaryHardColor,
        iconSize: 30,
        onTap: (value) => onItemTapped(value),
        elevation: 30,
      ),
    ),
  );
}



class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {

  int selectedIndex = 0;
 void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var pages = [
      HomePage(),
     // ProfilePage(),
    ];
    return Scaffold(
      body: pages[selectedIndex],
       bottomNavigationBar: bottomNavigation(
              context: context,
              selectedIndex: selectedIndex,
              onItemTapped: _onItemTapped),
    );
  }
}
