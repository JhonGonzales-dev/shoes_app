class NikeShoes {
  final String model;
  final double oldPrice;
  final double currentePrice;
  final List<String> images;
  final int modelNumber;
  final int color;

  NikeShoes({
    required this.model,
    required this.oldPrice,
    required this.currentePrice,
    required this.images,
    required this.modelNumber,
    required this.color,
  });
}

final shoes = [
  NikeShoes(
    model: "AIR MAX 90 EZ BLACK",
    oldPrice: 299,
    currentePrice: 149,
    images: [
      "assets/shoes1_1.png",
      "assets/shoes1_2.png",
      "assets/shoes1_3.png"
    ],
    modelNumber: 90,
    color: 0XFFF6F6F6,
  ),
  NikeShoes(
    model: "AIR MAX 95 RED",
    oldPrice: 399,
    currentePrice: 249,
    images: [
      "assets/shoes2_1.png",
      "assets/shoes2_2.png",
      "assets/shoes2_3.png"
    ],
    modelNumber: 95,
    color: 0XFFFCF5EB,
  ),
  NikeShoes(
    model: "AIR MAX 270 GOLD",
    oldPrice: 299,
    currentePrice: 399,
    images: [
      "assets/shoes3_1.png",
      "assets/shoes3_2.png",
      "assets/shoes3_3.png"
    ],
    modelNumber: 270,
    color: 0XFFFEEFEF,
  ),
  NikeShoes(
    model: "AIR MAX 98 FREE",
    oldPrice: 299,
    currentePrice: 149,
    images: [
      "assets/shoes4_1.png",
      "assets/shoes4_2.png",
      "assets/shoes4_3.png"
    ],
    modelNumber: 98,
    color: 0XFFEDF3FE,
  )
];
