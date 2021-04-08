class CardModel{
  int index;
  String picture;
  CardModel({this.picture,this.index});
}

List<CardModel> cards=[
  new CardModel(picture: "assets/card1.png",index: 0),
  new CardModel(picture: "assets/card2.png",index: 1),
  new CardModel(picture: "assets/card3.png",index: 2),
  new CardModel(picture: "assets/card4.png",index: 3),
  new CardModel(picture: "assets/card5.png",index: 4),
  new CardModel(picture: "assets/card6.png",index: 5),
];