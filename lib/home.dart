import 'package:app_shoes/nike_shoes_detail.dart';
import 'package:flutter/material.dart';

import 'card_nike_shoe.dart';
import 'nike_shoes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isBottomVisible = ValueNotifier(true);
  void onPressCard(NikeShoes shoes) async {
    isBottomVisible.value = false;
    await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, animtaion1, animation2) => FadeTransition(
              opacity: animtaion1,
              child: NikeShoesDetail(shoes),
            )));
    isBottomVisible.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset("assets/nike_logo.png", height: 50),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            ListView.separated(
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                itemCount: shoes.length,
                itemBuilder: (_, index) {
                  final shoeItem = shoes[index];
                  return CardNikeShoe(
                    onPress: () => onPressCard(shoeItem),
                    shoe: shoeItem,
                  );
                }),
            ValueListenableBuilder(
              valueListenable: isBottomVisible,
              child: Container(
                color: Colors.white.withOpacity(0.7),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.home),
                    Icon(Icons.search),
                    Icon(Icons.favorite_border),
                    Icon(Icons.shopping_cart),
                  ],
                ),
              ),
              builder: (_, bool value, Widget? child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  left: 0,
                  bottom: value ? 0 : -kToolbarHeight,
                  right: 0,
                  height: kToolbarHeight,
                  child: child!,
                );
              },
            ),
          ],
        ));
  }
}
