import 'package:fluter_ui/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class PancakesTab extends StatelessWidget {
  final Function(int, double) onAddToCart;
  final List pancakesOnSale = [
    // [ donutFlavor, donutStore, donutPrice, donutColor, imageName ]
    ["Natural", "I-HOP", "36", Colors.yellow, "lib/images/natural.png"],
    ["Strawberry", "I-HOP", "45", Colors.red, "lib/images/fresahot.png"],
    ["Chocolate", "I-HOP", "84", Colors.brown, "lib/images/chocolate.png"],
    ["Hot-Banana", "I-HOP", "95", Colors.yellow, "lib/images/hotplatano.png"],
    ["Hot-Tower", "I HOP", "60", Colors.brown, "lib/images/hotower.png"],
    ["Hot-Cupcake", "I-HOP", "78", Colors.purple, "lib/images/colores.png"],
    ["Hot-Pay", "I-HOP", "99", Colors.purple, "lib/images/pay.png"],
    ["Hot-Hershey", "I-HOP", "81", Colors.yellow, "lib/images/hershey.png"],
  ];
  PancakesTab({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        //Cúantos elementos tiene
        itemCount: pancakesOnSale.length,
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
              donutFlavor: pancakesOnSale[index][0],
              donutStore: pancakesOnSale[index][1],
              donutPrice: pancakesOnSale[index][2],
              donutColor: pancakesOnSale[index][3],
              imageName: pancakesOnSale[index][4],
              onAddToCart: onAddToCart);
        });
  }
}
