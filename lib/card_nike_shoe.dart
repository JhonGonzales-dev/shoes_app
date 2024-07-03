import 'package:flutter/material.dart';

import 'nike_shoes_model.dart';

class CardNikeShoe extends StatelessWidget {
  const CardNikeShoe({
    super.key,
    required this.shoe,
    required this.onPress,
  });
  final NikeShoes shoe;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPress,
        child: Container(
            color: Color(shoe.color),
            height: 320,
            child: Stack(
              children: [
                Positioned(
                  top: -40,
                  left: 0,
                  right: 0,
                  height: 250,
                  child: FittedBox(
                    child: Hero(
                      tag: "${shoe.modelNumber}",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          '${shoe.modelNumber}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.04),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 100,
                  child: Hero(
                    tag: "image${shoe.model}",
                    child: Image.asset(
                      shoe.images.first,
                      height: 200,
                    ),
                  ),
                ),
                const Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border),
                        Spacer(),
                        Icon(Icons.shopping_cart)
                      ],
                    )),
                Positioned(
                    left: 0,
                    bottom: 20,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          shoe.model,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$ ${shoe.oldPrice}',
                          style: const TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '\$ ${shoe.currentePrice}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
