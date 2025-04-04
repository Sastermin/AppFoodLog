import 'package:fluter_ui/tabs/burger_tab.dart';
import 'package:fluter_ui/tabs/donut_tab.dart';
import 'package:fluter_ui/tabs/pancakes_tab.dart';
import 'package:fluter_ui/tabs/pizza_tab.dart';
import 'package:fluter_ui/tabs/smoothie_tab.dart';
import 'package:fluter_ui/utils/my_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final bool isGuest; // Define la variable

  const HomePage({super.key, required this.isGuest}); // Así la almacenas en la clase

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  //Lista de Tabs
  List<Widget> myTabs = [
    //DonutTab
    MyTab(iconPath: "lib/icons/donut.png"),
    //BurgerTab
    MyTab(iconPath: "lib/icons/burger.png"),
    //PizzaTab
    MyTab(iconPath: "lib/icons/pizza.png"),
    //SmoothieTab
    MyTab(iconPath: "lib/icons/smoothie.png"),
    //PancakesTab
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //Icono de la izquierda
          leading: Icon(
            Icons.menu,
            color: Colors.grey[800],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Icon(Icons.person),
            )
          ],
        ),
        body: Column(
          children: [
            //Texto "I want to eat"
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 18.0),
              child: Row(
                children: [
                  Text(
                    "I want to ",
                    style: TextStyle(fontSize: 32),
                  ),
                  Text(
                    "Eat",
                    style: TextStyle(
                        // Tamaño de letra
                        fontSize: 32,
                        // Negritas
                        fontWeight: FontWeight.bold,
                        // Subrayado
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
            ),

            //Tab bar
            TabBar(tabs: myTabs),
            //Tab bar view
            Expanded(
                child: TabBarView(children: [
              DonutTab(onAddToCart: updateCart),
              BurgerTab(onAddToCart: updateCart),
              PizzaTab(onAddToCart: updateCart),
              SmoothieTab(onAddToCart: updateCart),
              PancakesTab(onAddToCart: updateCart)
            ])),
            //Carrito
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$totalItems Items | \$$totalPrice',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12)),
                      child: const Text(
                        'View Cart',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
