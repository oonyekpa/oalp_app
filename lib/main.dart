import 'package:flutter/material.dart';
import 'package:oalp_app/office_screen.dart';
import 'package:oalp_app/time_screen.dart';
import 'package:oalp_app/accelerate_screen.dart';
import 'package:oalp_app/email_screen.dart';
import 'package:oalp_app/imanage_screen.dart';
import 'package:oalp_app/intranet_screen.dart';
import 'package:oalp_app/splash_screen.dart'; // Import the splash screen file you created.


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Aztanavida',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[700], // Set the AppBar background to transparent.
          elevation: 0,
          titleTextStyle: const TextTheme(
            headline6: TextStyle(
              fontFamily: 'Aztanavida',
              fontSize: 20,
              color: Colors.white,
            ),
          ).headline6,
          iconTheme: const IconThemeData(
            color: Colors.grey, // Set the icon color.
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Set the splash screen as the initial route.
      routes: {
        // Define your routes here. For example:
        '/home': (context) => const HomeScreen(),
      }
    );
  }
}

// Create your HomeScreen or main screen widget here.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const IntranetScreen(),
    const EmailScreen(),
    const OfficeScreen(),
    const TimeScreen(),
    const ImanageScreen(),
    const AccelerateScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        IndexedStack(index: _currentIndex, children: _pages,),
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 14,
        selectedIconTheme: const IconThemeData(color: Colors.greenAccent),
        selectedItemColor: Colors.greenAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Aztanavida',),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Aztanavida',),
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: 'Intranet',
            backgroundColor: Colors.blueGrey[700],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.email),
            label: 'Email',
            backgroundColor: Colors.blueGrey[700],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month_outlined),
            label: 'Office',
            backgroundColor: Colors.blueGrey[700],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.timer_sharp),
            label: 'Time',
            backgroundColor: Colors.blueGrey[700],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.timeline),
            label: 'iManage',
            backgroundColor: Colors.blueGrey[700],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.move_down_rounded),
            label: 'Accelerate',
            backgroundColor: Colors.blueGrey[700],
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}


