import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListenScreen extends StatelessWidget {
  const ListenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "إستمع للقرآن الأن",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20,),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            crossAxisCount: 2,
            children: List.generate(
              5,
              (index) => buildListenItem(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListenItem() => InkWell(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.library_music_rounded,
                size: 50,
                color: HexColor('00ADB5'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Mp3 Quran',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: HexColor('00ADB5')),
              ),
            ],
          ),
        ),
        onTap: () {
          print('taped');
        },
      );
}
