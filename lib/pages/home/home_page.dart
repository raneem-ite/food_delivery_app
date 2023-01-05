import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/styles/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = const [
    MainFoodPage(),
    Center(child: Text("next")),
    Center(child: Text("next")),
    Center(child: Text("next"))
  ];
  int _currentIndex = 0;
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: _onTap,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              label: "Home", icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(
              label: "history", icon: Icon(Icons.archive_outlined)),
          BottomNavigationBarItem(
              label: "cart", icon: Icon(Icons.shopping_cart_outlined)),
          BottomNavigationBarItem(
              label: "Me", icon: Icon(Icons.person_outline)),
        ],
      ),
    );
  }
}
