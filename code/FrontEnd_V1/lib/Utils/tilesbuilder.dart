


import 'package:flutter/material.dart';



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
    title: "Glossery",
    tiles: getGlossery(),
    ),
      
     
];

List<TileOfTiles> getGlossery() {
  List<TileOfTiles> glosseryMaker =[];
  glosseryTerms.forEach((key, value) {
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


const  Map<String,String> glosseryTerms = 
{
  "Actinic keratoses": "Actinic keratoses are rough, scaly patches that appear on skin that has been exposed to the sun. They are usually found on the face, scalp, ears, neck, hands, and forearms. They are not cancerous but can sometimes develop into squamous cell carcinoma, a type of skin cancer. Treatment for actinic keratoses includes cryotherapy, topical medications, and photodynamic therapy.",
  "Basal cell carcinoma": "Basal cell carcinoma is the most common type of skin cancer. It appears as a raised, pearly bump on the skin that may bleed or develop a crust. It is usually found on areas of the skin that are frequently exposed to the sun, such as the face and neck. Treatment for basal cell carcinoma includes surgical removal, radiation therapy, and topical medications.",
  "Benign keratosis-like lesions":  "Benign keratosis-like lesions are rough, scaly patches that are not cancerous but may be cosmetically undesirable. They are usually found on the face, scalp, ears, neck, hands, and forearms. Treatment for these lesions may include cryotherapy, topical medications, or surgical removal.",
  "Dermatofibroma": "Dermatofibroma is a common benign skin growth that appears as a small, firm bump on the skin. It is usually found on the legs and may be brown or reddish-brown in color. Treatment is not necessary, but some people may choose to have them removed for cosmetic reasons.",
  "Melanoma": "Melanoma is a type of skin cancer that develops from melanocytes, the cells that produce pigment in the skin. It appears as a new or changing mole on the skin that is asymmetrical, has irregular borders, has different colors, is larger than a pencil eraser, or is evolving in shape, size, or color. Treatment for melanoma includes surgical removal, radiation therapy, chemotherapy, and immunotherapy.",
  "Melanocytic nevi": "Melanocytic nevi, also known as moles, are common benign skin growths that appear as brown or black spots on the skin. They can appear anywhere on the body and vary in size and shape. Most melanocytic nevi do not require treatment, but some may be removed for cosmetic reasons or if they show signs of changing.",
  "Vascular lesions": "Vascular lesions are abnormalities in the blood vessels of the skin. They can appear as red or purple spots or patches on the skin, and may be flat or raised. Types of vascular lesions include hemangiomas, port-wine stains, and spider veins. Treatment for vascular lesions may include laser therapy, surgical removal, or sclerotherapy.",
  "Benign": "Benign skin conditions are non-cancerous growths or conditions that typically do not pose a threat to one's health. These can include skin tags, warts, moles, and seborrheic keratosis. While they may be aesthetically unpleasing, they are usually not harmful and do not require treatment unless they cause discomfort or irritation.",
  "Malignant":"Malignant skin conditions refer to cancerous growths or conditions that can be life-threatening if left untreated. These can include melanoma, squamous cell carcinoma, and basal cell carcinoma. These conditions require prompt diagnosis and treatment to prevent the cancer from spreading and causing severe harm to one's health. Treatment options can vary depending on the type and severity of cancer but may include surgery, radiation therapy, chemotherapy, or immunotherapy.",
};

