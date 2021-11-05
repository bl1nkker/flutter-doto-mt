// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DotaHero {
  final String name;
  final String description;
  final String img_directory_path;
  final String img_hero_path;
  final String hero_type;
  final List<dynamic> abilities;

  DotaHero(this.name, this.description, this.hero_type, this.img_directory_path,
      this.img_hero_path, this.abilities);
}

class HeroPage extends StatelessWidget {
  const HeroPage({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final a = ModalRoute.of(context)!.settings.arguments as DotaHero;
    final Color color = a.hero_type == 'strength'
        ? Colors.red
        : a.hero_type == 'intelligence'
            ? Colors.blue
            : Colors.green;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          a.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: color,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black, color])),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                    'images/${a.img_directory_path}/${a.img_hero_path}'),
                width: 144,
                height: 144,
              ),
              Text(a.name, style: TextStyle(fontSize: 24, color: Colors.white)),
              Text(a.description,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center),
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...a.abilities.map((ability) => Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'images/${a.img_directory_path}/${ability['ability_image']}.jpg'),
                              width: 64,
                              height: 64,
                            ),
                            SizedBox(width: 30.0),
                            Container(
                              width: 250.0,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5.0),
                              child: Column(
                                children: [
                                  Text(ability['ability_name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      maxLines: 20),
                                  Text(
                                    ability['ability_description'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              )
            ],
          )),
    );
  }
}
