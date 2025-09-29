import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vinno_foods/core/generated/assets.dart';


class LoadingScreenOrganism extends StatefulWidget {
  const LoadingScreenOrganism({Key? key}) : super(key: key);

  @override
  _LoadingScreenOrganismState createState() => _LoadingScreenOrganismState();
}

class _LoadingScreenOrganismState extends State<LoadingScreenOrganism>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;
  double anchoLienzo = 0;
  double altoLienzo = 0;
  double anchoLogo = 0;
  double altoLogo = 0;
  double anchoVinno = 0;
  double altoVinno = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;

    double ratio = (pageSize.width / 360);

    setState(() {
      anchoLienzo = (ratio * 100);
      altoLienzo = anchoLienzo * 0.4;
      anchoLogo = anchoLienzo;
      altoLogo = altoLienzo;

      anchoVinno = ratio * 400;
      altoVinno = (anchoVinno * 95.98) / 400;

      sequenceAnimation = SequenceAnimationBuilder()
          .addAnimatable(
            animatable: ColorTween(begin: Colors.white, end: Colors.grey),
            from: const Duration(milliseconds: 600),
            to: const Duration(milliseconds: 1800),
            tag: "color",
            curve: Curves.linear,
          )
          .addAnimatable(
            animatable: Tween<double>(begin: anchoLienzo - anchoVinno, end: 0),
            from: const Duration(milliseconds: 1800),
            to: const Duration(milliseconds: 3600),
            tag: "positionX",
            curve: Curves.linear,
          )
          .addAnimatable(
            animatable: Tween<double>(begin: altoLienzo, end: -10),
            from: const Duration(milliseconds: 1800),
            to: const Duration(milliseconds: 3600),
            tag: "positionY",
            curve: Curves.linear,
          )
          .animate(controller);
    });

    controller.forward();

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              Center(
                child: Container(
                  color: sequenceAnimation["color"].value,
                  width: anchoLienzo,
                  height: altoLienzo,
                  child: Stack(
                    children: [
                      Positioned(
                        top: sequenceAnimation["positionY"].value,
                        right: sequenceAnimation["positionX"].value,
                        width: anchoVinno,
                        height: altoVinno,
                        child: SvgPicture.asset(Assets.imagesLiquido),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: anchoLienzo + 5,
                  height: altoLienzo + 2,
                  child: SvgPicture.asset(
                    Assets.imagesVinno,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
