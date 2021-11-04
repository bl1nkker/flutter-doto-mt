import 'package:flutter/material.dart';

// Restaurant class
class Restaurant {
  final String name;
  final String description;
  final String img_directory_path;
  final String img_hero_path;
  final String hero_type;
  // final String image;
  final List<dynamic> abilities;

  Restaurant(this.name, this.description, this.hero_type,
      this.img_directory_path, this.img_hero_path, this.abilities);
}

// Details Widget
class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    // Arguments from parent widget
    final args = ModalRoute.of(context)!.settings.arguments as Restaurant;
    print(args.abilities);
    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage(
                      'images/${args.img_directory_path}/${args.img_hero_path}')),
              Text(args.name, style: TextStyle(fontSize: 32)),
              SizedBox(height: 50.0),
              Text(args.description,
                  style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...args.abilities.map((ability) => Column(
                        children: [
                          Text(ability['ability_name']),
                          Text(ability['ability_description']),
                          Text(ability['ability_image'])
                        ],
                      ))
                ],
              )
            ],
          )),
    );
  }
}
