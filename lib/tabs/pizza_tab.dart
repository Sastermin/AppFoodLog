import 'package:fluter_ui/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class PizzaTab extends StatelessWidget {
  final Function(int, double) onAddToCart;
  final List pizzaOnSale = [
    // [ donutFlavor, donutStore, donutPrice, donutColor, imageName ]
    ["Hawaiii", "Dominos", "68", Colors.orange, "lib/images/hawai.png"],
    ["Extra extra", "Dominos", "45", Colors.red, "lib/images/extra.png"],
    ["Veggie", "Little Cesars", "84", Colors.purple, "lib/images/vegie.png"],
    ["Pepperoni", "Little Cesars", "95", Colors.brown, "lib/images/pepe.png"],
    ["Margarita", "Dominos", "60", Colors.brown, "lib/images/marga.png"],
    ["Carnívora", "Little Cesars", "78", Colors.purple, "lib/images/carni.png"],
    ["Napolitana", "Little Cesars", "99", Colors.purple, "lib/images/napo.png"],
    ["Champ", "Dominos", "81", Colors.blue, "lib/images/champi.png"],
  ];
  PizzaTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        //Cúantos elementos tiene
        itemCount: pizzaOnSale.length,
        padding: const EdgeInsets.all(12),
        //Encargado de organizar la cuadrícula
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //Determinar número de columnas
            crossAxisCount: 2,
            //Relación de aspecto
            childAspectRatio: 1 / 1.35),
        itemBuilder: (context, index) {
          //Elemento individual de la cuadrícula
          return DonutTile(
              donutFlavor: pizzaOnSale[index][0],
              donutStore: pizzaOnSale[index][1],
              donutPrice: pizzaOnSale[index][2],
              donutColor: pizzaOnSale[index][3],
              imageName: pizzaOnSale[index][4],
              onAddToCart: onAddToCart);
        });
  }
}