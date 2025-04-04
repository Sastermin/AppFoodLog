import 'package:fluter_ui/tabs/burger_tab.dart';
import 'package:fluter_ui/tabs/donut_tab.dart';
import 'package:fluter_ui/tabs/pancakes_tab.dart';
import 'package:fluter_ui/tabs/pizza_tab.dart';
import 'package:fluter_ui/tabs/smoothie_tab.dart';
import 'package:fluter_ui/utils/my_tab.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fluter_ui/pages/login_page.dart'; // Asegúrate de importar tu página de login

class HomePage extends StatefulWidget {
  final bool isGuest;

  const HomePage({super.key, required this.isGuest});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> myTabs = [
    MyTab(iconPath: "lib/icons/donut.png"),
    MyTab(iconPath: "lib/icons/burger.png"),
    MyTab(iconPath: "lib/icons/pizza.png"),
    MyTab(iconPath: "lib/icons/smoothie.png"),
    MyTab(iconPath: "lib/icons/pancakes.png"),
  ];

  int totalItems = 0;
  double totalPrice = 0.0;

  void updateCart(int items, double price) {
    setState(() {
      totalItems += items;
      totalPrice += price;
    });
  }

  // Método para cerrar sesión y regresar a la pantalla de login
  Future<void> _signOut() async {
    await Supabase.instance.client.auth.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()), // Usa tu LoginPage existente
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.menu, color: Colors.grey[800]),
          actions: [
            if (!widget.isGuest)
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.red),
                tooltip: 'Cerrar sesión',
                onPressed: _signOut,
              ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.person),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 18.0),
              child: Row(
                children: [
                  const Text("I want to ", style: TextStyle(fontSize: 32)),
                  Text(
                    "Eat",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
            ),
            TabBar(tabs: myTabs),
            Expanded(
              child: TabBarView(children: [
                DonutTab(onAddToCart: updateCart),
                BurgerTab(onAddToCart: updateCart),
                PizzaTab(onAddToCart: updateCart),
                SmoothieTab(onAddToCart: updateCart),
                PancakesTab(onAddToCart: updateCart),
              ]),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$totalItems Items | \$$totalPrice',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Delivery Charges Included',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'View Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}