import 'package:card_scroll/helper/animated_interpolation.dart';
import 'package:card_scroll/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:interpolate/interpolate.dart';

const double MARGIN = 16;
const double ratio = 228 / 362;

class Item extends StatefulWidget {
  final CardModel card;
  final int index;
  final double y;
  final Size size;

  Item({this.card, this.y, this.index, this.size});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  double CARD_HEIGHT = 0;
  double defaultCardHeight = 0;

  double isTop = 0;
  double isBottom = 0;
  double height = 0;
  double isAppearing = 0;
  double isDisappear = 0;

  double positionRealWhenScroll = 0;

  InterpolationTween ipTranslationY;
  InterpolationTween ipPosition;
  InterpolationTween ipScale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defaultCardHeight = widget.size.width * ratio;
    CARD_HEIGHT = defaultCardHeight + MARGIN * 2;

    height = widget.size.height;
    isDisappear = -CARD_HEIGHT;
    isTop = 0;

    isBottom = height - CARD_HEIGHT;
    isAppearing = height - 64;

    initInterpolation();
  }

  initInterpolation() {
    ipTranslationY = InterpolationTween(
        inputRange: [0, widget.index * CARD_HEIGHT],
        outputRange: [0, -widget.index * CARD_HEIGHT],
        extrapolateRight: ExtrapolateType.clamp);

    ipScale = InterpolationTween(
        inputRange: [isDisappear, isTop, isBottom, isAppearing],
        outputRange: [0.5, 1, 1, 0.5],
        extrapolate: ExtrapolateType.clamp);
    ipPosition = InterpolationTween(
        inputRange: [isBottom, isAppearing],
        outputRange: [0, -CARD_HEIGHT / 4],
        extrapolate: ExtrapolateType.clamp);
  }

  @override
  Widget build(BuildContext context) {
    positionRealWhenScroll = widget.index * CARD_HEIGHT - widget.y;
    double translateY = (ipTranslationY.transform(widget.y) +
        widget.y +
        ipPosition.transform(positionRealWhenScroll));
    double scale = ipScale.transform(positionRealWhenScroll);
    print("index " + widget.index.toString());
    print("positionRealWhenScroll " + positionRealWhenScroll.toString());
    return Transform.translate(
      offset: Offset(0, translateY),
      child: Transform.scale(
        scale: scale,
        child: Container(
          height: defaultCardHeight,
          margin: EdgeInsets.all(MARGIN),
          child: Stack(
            children: [
              Positioned.fill(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.card.picture,
                  fit: BoxFit.cover,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
