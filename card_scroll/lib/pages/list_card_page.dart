

import 'package:card_scroll/models/card_model.dart';
import 'package:card_scroll/pages/item.dart';
import 'package:flutter/material.dart';

class ListCardPage extends StatefulWidget {
  @override
  _ListCardPageState createState() => _ListCardPageState();
}

class _ListCardPageState extends State<ListCardPage> {
  ScrollController _scrollController;
  double y=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController=ScrollController(
    );
    _scrollController.addListener(() {
      setState(() {
        y=_scrollController.position.pixels;
        // print("y "+y.toString());
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallet",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          child: Column(


            children: [
              for (int i = 0; i < cards.length; i++)
               Item(card: cards[i],y:y,index: i,size:size ,)
            ],
          ),
        ),
      ),
    );
  }
}
