import 'package:customeappbar/api.dart';
import 'package:customeappbar/models/model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController tabController;
  List<CategoryModel> categories;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    fetchDat();
  }

  fetchDat() async {
    return await fetchCategories().then((catList) {
      categories = catList;
      tabController = TabController(length: categories.length, vsync: this);
    }).catchError((onError) {
      print("Can't Fetch Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text("Japanses Restaurant"),
                titlePadding: EdgeInsets.all(20),
                background: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80")),
              ),
            ),
            SliverPersistentHeader(
                delegate: MyCustomAppBar(
                    color: Colors.black,
                    tabBar: TabBar(
                      onTap: (value) {},
                      isScrollable: true,
                      controller: tabController,
                      tabs: categories
                          .map<Tab>((e) => Tab(
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                      color: e.colorCode != null
                                          ? Color(int.parse("0xff" +
                                              e.colorCode.replaceAll("#", "")))
                                          : Colors.white),
                                ),
                              ))
                          .toList(),
                    ))),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: categories
              .map<Container>((cat) => Container(
                    child: Center(
                      child: Text(cat.name),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class MyCustomAppBar extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color color;

  MyCustomAppBar({this.tabBar, this.color});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: tabBar,
      color: color,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
