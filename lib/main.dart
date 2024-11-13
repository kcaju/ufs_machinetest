import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ufs_machinetest/controller/detailscreen_controller.dart';
import 'package:ufs_machinetest/controller/homescreen_controller.dart';
import 'package:ufs_machinetest/view/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DetailscreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomescreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
