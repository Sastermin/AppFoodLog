import 'package:fluter_ui/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class SmoothieTab extends StatelessWidget {
  final Function(int, double) onAddToCart;
  final List smoothieOnSale = [
    // [ donutFlavor, donutStore, donutPrice, donutColor, imageName ]
    ["Mango", "Starbucks", "36", Colors.yellow, "lib/images/mango.png"],
    ["Strawberry", "Italian Coffee", "45", Colors.pink, "lib/images/fresa.png"],
    [
      "Banana",
      "Starbucks",
      "84",
      Colors.yellow,
      "lib/images/smoothplatano.png"
    ],
    [
      "Peanut Butter",
      "Italian Coffe",
      "95",
      Colors.brown,
      "lib/images/peanut.png"
    ],
    ["Oreo", "Italian Coffee", "60", Colors.brown, "lib/images/oreo.png"],
    ["Piña-Colada", "Starbucks", "78", Colors.yellow, "lib/images/colada.png"],
    ["Choco", "Starbucks", "99", Colors.brown, "lib/images/choco.png"],
    ["Chamoy", "Dairy Queen", "81", Colors.orange, "lib/images/chamoy.png"],
  ];
  SmoothieTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        //Cúantos elementos tiene
        itemCount: smoothieOnSale.length,
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
              donutFlavor: smoothieOnSale[index][0],
              donutStore: smoothieOnSale[index][1],
              donutPrice: smoothieOnSale[index][2],
              donutColor: smoothieOnSale[index][3],
              imageName: smoothieOnSale[index][4],
              onAddToCart: onAddToCart);
        });
  }
}