import 'package:flutter/material.dart';

// Restaurant class
class Restaurant {
  final String name;
  final String description;
  // final String image;
  final List<dynamic> abilities;

  Restaurant(
      this.name,
      this.description,
      // this.image,
      this.abilities);
}

// Details Widget
class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    // Arguments from parent widget
    final args = ModalRoute.of(context)!.settings.arguments as Restaurant;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(args.name, style: TextStyle(fontSize: 32)),
              SizedBox(height: 50.0),
              Text(args.description,
                  style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text('Menu',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    ...args.abilities.map((food) => Text(food)).toList()
                  ]),
                  Column(children: [
                    Text('Popular',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    ...args.abilities.map((food) => Text(food)).toList()
                  ])
                ],
              )
            ],
          )),
    );
  }
}
