import 'package:flutter/material.dart';

class AvatarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          // Lo encapsulo dentro de un contenedor para poder aplicarle
          // el padding para que se vea bien
          Container(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pm1.narvii.com/6312/5162c9652d486cdbef4803376c7d6926acaac852_hq.jpg'),
              radius: 20.0,
            ),
          ),

          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('YG'),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage(
              'https://3.bp.blogspot.com/-w33yq_y5KhI/V4l32ZGMKiI/AAAAAAAAZ5c/zdvfOCGTAM4A3WSrKFx-By8BTmcnOPF8QCLcB/s1600/starlord-promo-719ba.jpg'),
          placeholder: AssetImage('assets/original_tits.jpg'),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
