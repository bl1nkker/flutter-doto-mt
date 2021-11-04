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
        DetailsPage.routeName: (context) => const DetailsPage(),
      },
      title: 'Дота Герои',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'мобильное приложение еееее'),
    );
  }
}

// Home Page
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('heroes').snapshots(),
          builder: (BuildContext bc, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const Text('Nothing is here...');
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext bc, int index) {
                  final docData = snapshot.data!.docs[index].data() as Map;
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailsPage.routeName,
                        arguments: Restaurant(
                            docData['name'],
                            docData['description'],
                            // docData['image'],
                            docData['abilities']),
                      );
                    },
                    child: Card(
                      child: Text(docData["name"]),
                    ),
                  );
                });
          },
        ));
  }
}
