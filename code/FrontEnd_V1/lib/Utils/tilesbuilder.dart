


import 'package:flutter/material.dart';

import 'glossary.dart';



class TileOfTiles{
  final  title;
  final List<TileOfTiles> tiles;

  const TileOfTiles({
    required this.title,
    this.tiles = const [],
  });
}



final  homeExpndable = <TileOfTiles> [
  const TileOfTiles(
    title:'About This App',
    tiles: [
      TileOfTiles(title:"Getting a medical evaluation for every minor skin blemish can be a costly and time-consuming hassle that many individuals simply cannot afford. However, the consequences of neglecting skin health can be dire, as even small changes in the appearance or texture of the skin may indicate the presence of skin cancers or diseases. Unfortunately, not everyone has access to medical facilities or the necessary knowledge to identify such conditions. That's where SPOT steps in as a game-changing solution – a cutting-edge AI-powered medical diary that provides users with a comprehensive and accurate assessment of their skin's health status. By utilizing advanced artificial intelligence technology, SPOT offers a quick, easy, and affordable alternative to traditional medical evaluations. Users can simply upload images of their skin blemishes or areas of concern, and SPOT's algorithms will analyze them to identify any potential skin cancers or diseases. With SPOT, you can have peace of mind knowing that your skin health is being monitored by advanced technology, providing you with accurate and reliable evaluations. Although SPOT's assessment is not a substitute for professional medical advice, it empowers users to take informed action and seek professional assistance where necessary. By taking control of your skin health with SPOT, you can make informed decisions and take proactive steps towards maintaining your overall well-being.")
    ]),
    TileOfTiles (
    title: "Glossary",
    tiles: getGlossary(),
    ),
      
     
];

List<TileOfTiles> getGlossary() {
  List<TileOfTiles> glosseryMaker =[];
  glossaryTerms.forEach((key, value) {
    glosseryMaker.add( 
      TileOfTiles(title: key,
       tiles: [
       TileOfTiles(title:value ),
       ]
        ) );


  });
  return glosseryMaker;
}

Widget buildTile(TileOfTiles tile, {double leftPadding = 16 })
{
if (tile.tiles.isEmpty)
{
 
 return ListTile(
  contentPadding: EdgeInsets.only(left: leftPadding),
  title: Text(tile.title),
 );
 

}
else
{
return ExpansionTile(
  tilePadding: EdgeInsets.only(left: leftPadding),
  title: Text(tile.title),
  children: tile.tiles.map((tile)=> buildTile(tile,leftPadding: 16+leftPadding)).toList(),
  );
}
}




