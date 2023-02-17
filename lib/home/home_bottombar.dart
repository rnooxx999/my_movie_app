
import 'package:flutter/material.dart';
import 'package:movies_app/geners/geners_screen.dart';
import 'package:movies_app/seartch/search_screen.dart';

import '../watched_list/watched_list_screen.dart';
import 'home_screen.dart';

class HomeStartBottomBar extends StatefulWidget {

  @override
  State<HomeStartBottomBar> createState() => _HomeStartBottomBarState();
}

class _HomeStartBottomBarState extends State<HomeStartBottomBar> {
  int selectedIndex = 0;


  List<Widget> tabs = [
    HomeScreen() , SearchScreen() , GenersScreen(), WatchedListScreen()
  ];


  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
          body: tabs[selectedIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Theme.of(context).primaryColor),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home)
                    ,label: "Home"
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search)
                  ,label: "Search",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.open_in_browser_outlined)
                    ,label: "Browes"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.heart_broken)
                    ,label: "whatchList"
                ),

              ],
            ),
          ),
        );
  }

}
