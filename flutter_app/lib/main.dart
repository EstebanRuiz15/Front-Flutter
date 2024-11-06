import 'package:flutter/material.dart';
import 'package:flutter_app/src/routes/my_app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: MyAppRouter.router,
    );
  }
}