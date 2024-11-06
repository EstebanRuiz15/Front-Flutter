
import 'package:flutter_app/src/features/screens/AgeScreen.dart';
import 'package:flutter_app/src/features/screens/bmi_screen.dart';
import 'package:flutter_app/src/features/screens/home_screen.dart';
import 'package:flutter_app/src/features/screens/zodiac_screen.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter {
  static GoRouter router= GoRouter(
    routes:[
    GoRoute (path: '/',builder: (context, state)=>HomeScreen()),
    GoRoute (path: '/bmi',builder: (context, state)=>BmiScreen()),
    GoRoute (path: '/age',builder: (context, state)=>AgeScreen()),
    GoRoute (path: '/zodiac',builder: (context, state)=>ZodiacScreen()),


    ]);
  }