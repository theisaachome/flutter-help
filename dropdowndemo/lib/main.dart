import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

final catList = [
  "Biographies & Memory",
  "Education & Referennce",
  "History",
  "Literature & Fiction",
  "Sci-Fi & Fantasy",
  "Science & Math",
  "Teen & Young Adult",
  "Best Sellers",
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Text(
              "Libray Category",
              style: TextStyle(fontSize: 20, color: Colors.blueGrey),
            ),
            Divider(),
            DropdownButton(
              value: selectedCategory,
              items: catList
                  .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              hint: Text("Categories"),
              icon: Icon(Icons.category),
              onChanged: (e) {
                setState(() {
                  selectedCategory = e;
                });
              },
              onTap: () {
                print("Tap");
              },
            ),
            Divider(),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "You Select $selectedCategory ",
                style: TextStyle(fontSize: 20, color: Colors.blueGrey),
              ),
            )),
          ],
        ));
  }
}
