import 'package:flutter/material.dart';

import 'nike_shoes_model.dart';

class NikeShoppingCart extends StatefulWidget {
  const NikeShoppingCart(this.shoes, {super.key});
  final NikeShoes shoes;

  @override
  State<NikeShoppingCart> createState() => _NikeShoppingCartState();
}

class _NikeShoppingCartState extends State<NikeShoppingCart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animationMoveIn;
  late Animation<double> _animationMoveOut;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _animation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2)));
    _animationMoveIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: const Interval(0.45, 0.55)));
    _animationMoveOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1, curve: Curves.elasticIn)));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(color: Colors.black87)),
              if (_animationMoveIn.value != 1)
                Positioned(
                  left: 0,
                  right: 0,
                  top: size.height * 0.5 +
                      (_animationMoveIn.value * size.height * 0.395),
                  child: TweenAnimationBuilder<double>(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 200),
                    tween: Tween(begin: 1, end: 0),
                    builder: (_, value, __) {
                      return Transform.translate(
                        offset: Offset(0, 200 * value),
                        child: Center(
                          child: Container(
                            padding:
                                EdgeInsets.all(_animation.value == 1 ? 20 : 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(30),
                                  topRight: const Radius.circular(30),
                                  bottomLeft: Radius.circular(
                                      _animation.value == 1 ? 0 : 30),
                                  bottomRight: Radius.circular(
                                      _animation.value == 1 ? 0 : 30),
                                )),
                            width: (size.width * _animation.value)
                                .clamp(45, size.width),
                            height: (size.height * 0.5 * _animation.value)
                                .clamp(45, size.height * 0.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: _animation.value == 1
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: (120 * _animation.value)
                                          .clamp(40, 120),
                                      child: Image.asset(
                                        widget.shoes.images.first,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    if (_animation.value == 1) ...[
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            widget.shoes.model,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            '\$ ${widget.shoes.currentePrice}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ]
                                  ],
                                ),
                                if (_animation.value == 1) ...[
                                  const Divider(),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/feet.png",
                                          width: 30, height: 30),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Select Size",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  )
                                ]
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Positioned(
                bottom: 40 - (_animationMoveOut.value * 100),
                left: 0,
                right: 0,
                child: TweenAnimationBuilder<double>(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 200),
                  tween: Tween(begin: 1, end: 0),
                  builder: (_, value, __) {
                    return Transform.translate(
                      offset: Offset(0, 200 * value),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            _controller.forward();
                          },
                          child: Container(
                              width: (200 * _animation.value).clamp(45, 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  if (_animation.value == 1) ...[
                                    const SizedBox(width: 10),
                                    const Text(
                                      "ADD TO CART",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ]
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
