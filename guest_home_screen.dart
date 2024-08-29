
import 'package:baiti_residential_services/view/guestScreens/account_screen.dart';
import 'package:baiti_residential_services/view/guestScreens/explore_screen.dart';
import 'package:baiti_residential_services/view/guestScreens/inbox_screen.dart';
import 'package:baiti_residential_services/view/guestScreens/saved_listings_screen.dart';
import 'package:baiti_residential_services/view/guestScreens/trips_screen.dart';
import 'package:flutter/material.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> 
{
  int selectedIndex = 0;

  final List<String> screenTitles = [
    'Explore',
    'Saved',
    'Tripes',
    'Inbox',
    'Profile'
  ];

   final List<Widget> screens = [
    ExploreScreen(),
    SavedListingsScreen(),
    TripsScreen(),
    InboxScreen(),
    AccountScreen(),
   ];
    

  BottomNavigationBarItem customNavigationBarItem(int index, IconData iconData, String title)
  {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: Colors.black,
        ),
        activeIcon: Icon(
          iconData,
          color: Colors.deepPurple,
        ),
        label: title,
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange,
              Colors.deepOrangeAccent,
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 0),
            stops: [0, 1],
            tileMode: TileMode.clamp,
          ),
        ),
        ),
        title: Text(
          screenTitles[selectedIndex],
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i)
        {
          setState(() {
            selectedIndex = i;
          });
        },
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          customNavigationBarItem(0, Icons.search, screenTitles[0]),
          customNavigationBarItem(1, Icons.favorite_border, screenTitles[1]),
          customNavigationBarItem(2, Icons.hotel, screenTitles[2]),
          customNavigationBarItem(3, Icons.message, screenTitles[3]),
          customNavigationBarItem(4, Icons.person_outlined, screenTitles[4]),
        ],
        ),
    );
  }
}