import 'package:fluter_ui/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class BurgerTab extends StatelessWidget {
  final Function(int, double) onAddToCart;
  final List burguerOnSale = [
    // [ donutFlavor, donutStore, donutPrice, donutColor, imageName ]
    [
      "Juice Burger",
      "Burger King",
      "65",
      Colors.orange,
      "lib/images/Juiceburger.png"
    ],
    [
      "Double Meat",
      "Burger King",
      "45",
      Colors.red,
      "lib/images/Doblecarne.png"
    ],
    [
      "Jhony Burger",
      "Johnny rockets",
      "66",
      Colors.yellow,
      "lib/images/jhonybur.png"
    ],
    ["Mr. Bacon", "McDonalds", "82", Colors.brown, "lib/images/mr.bacon.png"],
    ["Wakey wakey!!", "McDonalds", "75", Colors.yellow, "lib/images/wakey.png"],
    ["ALL IN", "Burger King", "80", Colors.brown, "lib/images/todoonada.png"],
    [
      "Green Burger",
      "Johny rockets",
      "65",
      Colors.green,
      "lib/images/green.png"
    ],
    ["Mini Dini", "McDonalds", "78", Colors.blue, "lib/images/mini.png"],
  ];
  BurgerTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        //Cúantos elementos tiene
        itemCount: burguerOnSale.length,
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
              donutFlavor: burguerOnSale[index][0],
              donutStore: burguerOnSale[index][1],
              donutPrice: burguerOnSale[index][2],
              donutColor: burguerOnSale[index][3],
              imageName: burguerOnSale[index][4],
              onAddToCart: onAddToCart);
        });
  }
}