import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  final String iconPath;
  const MyTab({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 50,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16)
        ),
        child: Image.asset(
          //"lib/icons/donut.png"
          iconPath,
          color: const Color.fromARGB(255, 62, 61, 61),
        ),
      ),
    );
      
  }
}