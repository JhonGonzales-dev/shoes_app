import 'package:app_shoes/nike_shoes_model.dart';
import 'package:app_shoes/nike_shopping_cart.dart';
import 'package:flutter/material.dart';

class NikeShoesDetail extends StatefulWidget {
  const NikeShoesDetail(this.shoes, {super.key});
  final NikeShoes shoes;

  @override
  State<NikeShoesDetail> createState() => _NikeShoesDetailState();
}

class _NikeShoesDetailState extends State<NikeShoesDetail> {
  final isBottomVisible = ValueNotifier(false);

  final pageController = PageController(initialPage: 0);
  int currentPage = 0;

  void listener() {
    setState(() {
      currentPage = pageController.page!.round();
    });
  }

  void goShoppingCart() async {
    isBottomVisible.value = false;
    await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: NikeShoppingCart(widget.shoes),
          );
        }));
    isBottomVisible.value = true;
  }

  @override
  void initState() {
    pageController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isBottomVisible.value = true;
    });
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("assets/nike_logo.png", height: 50),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ListView(
            children: [
              Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                clipBehavior: Clip.antiAlias,
                child: Container(
                    color: Color(widget.shoes.color),
                    height: size.height * 0.6,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -40,
                          left: 0,
                          right: 0,
                          height: 250,
                          child: FittedBox(
                            child: Hero(
                              tag: "${widget.shoes.modelNumber}",
                              child: Material(
                                color: Colors.transparent,
                                child: TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 200),
                                  tween: Tween(begin: 1, end: 0),
                                  curve: Curves.bounceInOut,
                                  builder: (_, value, Widget? child) {
                                    return Transform.translate(
                                      offset: Offset(0, value),
                                      child: Text(
                                        '${widget.shoes.modelNumber}',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.04),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        PageView.builder(
                            controller: pageController,
                            itemCount: widget.shoes.images.length,
                            itemBuilder: (_, index) {
                              final image = widget.shoes.images[index];
                              final model = widget.shoes.model;
                              final tag =
                                  index == 0 ? "image$model" : "image$index";
                              return Container(
                                alignment: Alignment.center,
                                child: Hero(
                                  tag: tag,
                                  child: Image.asset(
                                    image,
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                              );
                            }),
                        Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: DotsSlide(
                              currentSlide: currentPage,
                              numSlides: widget.shoes.images.length,
                            ))
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.decelerate,
                      tween: Tween(begin: 1, end: 0),
                      builder: (_, value, __) {
                        return Transform.translate(
                          offset: Offset(100 * value, 0),
                          child: Row(
                            children: [
                              Text(
                                widget.shoes.model,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$ ${widget.shoes.oldPrice}",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    "\$ ${widget.shoes.currentePrice}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'AVAILABLE SIZES',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizeShoe(6),
                        SizeShoe(7),
                        SizeShoe(8),
                        SizeShoe(9),
                        SizeShoe(10)
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'DESCRIPTION',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"),
                    const SizedBox(height: 70)
                  ],
                ),
              )
            ],
          ),
          ValueListenableBuilder(
              valueListenable: isBottomVisible,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    FloatingActionButton(
                      heroTag: "favorite",
                      onPressed: () {},
                      child: const Icon(Icons.favorite_border),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      heroTag: "cart",
                      onPressed: () => goShoppingCart(),
                      child: const Icon(Icons.shopping_cart),
                    )
                  ],
                ),
              ),
              builder: (_, value, child) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  bottom: value ? 0 : -kToolbarHeight * 2,
                  left: 0,
                  right: 0,
                  child: child!,
                );
              })
        ],
      ),
    );
  }
}

class SizeShoe extends StatelessWidget {
  const SizeShoe(this.size, {super.key});
  final int size;

  @override
  Widget build(BuildContext context) {
    return Text(
      "US $size",
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class DotsSlide extends StatelessWidget {
  const DotsSlide({
    super.key,
    required this.numSlides,
    required this.currentSlide,
  });
  final int numSlides;
  final int currentSlide;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            numSlides,
            (index) => Container(
                  margin: const EdgeInsets.all(8),
                  height: currentSlide == index ? 13 : 11,
                  width: currentSlide == index ? 13 : 25,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: currentSlide == index
                        ? Colors.black
                        : Colors.grey.withOpacity(0.5),
                  ),
                )));
  }
}
