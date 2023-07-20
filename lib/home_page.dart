import 'package:flutter/material.dart';
import 'package:bookstore/app_color.dart' as AppColors;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: const SafeArea(
        child: Scaffold(
body: Column(
  children: [
    Row(
      children: [
        ImageIcon(AssetImage("img/menu.png"), size: 24,,color: Colors.black,)
      ],
    )
  ],
),
        )),
    );
  }
}