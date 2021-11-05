// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dota_app/card_entity.dart';

void main() async {
  // Firebase Init
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HeroPage.routeName: (context) => const HeroPage(),
      },
      title: 'Дота Герои',
      home: const HomePage(title: 'Dota 2 All Heroes'),
    );
  }
}

// Home Page
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.redAccent,
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('heroes').snapshots(),
          builder: (BuildContext _, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const Text('No heroes');
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext bc, int index) {
                  final d = snapshot.data!.docs[index].data() as Map;
                  final Color color = d['hero_type'] == 'strength'
                      ? Colors.red
                      : d['hero_type'] == 'intelligence'
                          ? Colors.blue
                          : Colors.green;
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: color,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          HeroPage.routeName,
                          arguments: DotaHero(
                              d['name'],
                              d['description'],
                              d['hero_type'],
                              d['directory_path'],
                              d['image_h_path'],
                              d['abilities']),
                        );
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(
                                'images/${d['directory_path']}/${d['image_i_path']}'),
                            width: 36,
                            height: 36,
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            d["name"],
                            style: TextStyle(fontSize: 32, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
