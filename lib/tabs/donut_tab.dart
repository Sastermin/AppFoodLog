import 'package:fluter_ui/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class DonutTab extends StatelessWidget {
  final Function(int, double) onAddToCart;
  final List donutOnSale = [
    // [ donutFlavor, donutStore, donutPrice, donutColor, imageName ]
    [
      "Ice Cream",
      "Krispy Cream",
      "36",
      Colors.blue,
      "lib/images/icecream_donut.png"
    ],
    [
      "Strawberry",
      "Dunkin Donuts",
      "45",
      Colors.red,
      "lib/images/strawberry_donut.png"
    ],
    [
      "Grape Ape",
      "Krispy Cream",
      "84",
      Colors.purple,
      "lib/images/grape_donut.png"
    ],
    [
      "Choco",
      "Donkey Donut",
      "95",
      Colors.brown,
      "lib/images/chocolate_donut.png"
    ],
    [
      "Sugar",
      "Dunkin Donuts",
      "32",
      Colors.orangeAccent,
      "lib/images/sugar_donut.png"
    ],
    [
      "Extra Chocolate",
      "Krispy Cream",
      "38",
      Colors.brown,
      "lib/images/extrachoco_donut.png"
    ],
    ["Carlos V", "Krispy Cream", "99", Colors.brown, "lib/images/carlos.png"],
    ["Crunchy", "Krispy Cream", "81", Colors.orange, "lib/images/crunch.png"],
  ];
  DonutTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        //Cúantos elementos tiene
        itemCount: donutOnSale.length,
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
              donutFlavor: donutOnSale[index][0],
              donutStore: donutOnSale[index][1],
              donutPrice: donutOnSale[index][2],
              donutColor: donutOnSale[index][3],
              imageName: donutOnSale[index][4],
              onAddToCart: onAddToCart);
        });
  }
}