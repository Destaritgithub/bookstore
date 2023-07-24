// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:convert';

import 'package:bookstore/my_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:bookstore/app_color.dart' as AppColors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<dynamic> _popularBooks = [];
  ScrollController? _scrollController;
  TabController? _tabController;
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("json/popularBooks.json");
    final Data = await json.decode(response);
    setState(() {
      _popularBooks = Data["popularBooks"];
    });
  }
//    List<dynamic> popularBooks = [];
//  Future<void> ReadData()async {
//     await DefaultAssetBundle.of(context).loadString("json/popularBooks").then((s) {
//       setState(() {
//         popularBooks = json.decode(s);
//       });
//     });
//   }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();

    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    AssetImage("assets/menu1.png"),
                    size: 24,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.notifications),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Popular Books",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  // ignore: unnecessary_null_comparison
                  itemCount: _popularBooks == null ? 0 : _popularBooks.length,
                  itemBuilder: (_, index) {
                    return Container(
                      key: ValueKey(_popularBooks[index]["id"]),
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(_popularBooks[index]["img"]),
                            fit: BoxFit.fill),
                      ),
                    );
                  }),
            ),
            Expanded(
                child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool isScroll) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: true,
                    bottom: PreferredSize(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20, left: 10),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(right: 10),
                            isScrollable: true,
                            controller: _tabController,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: const Offset(0, 0))
                                ]),
                            tabs: const [
                              AppTabs(
                                color: Colors.red,
                                text: "New",
                              ),
                              AppTabs(
                                color: Colors.blue,
                                text: "Popular",
                              ),
                              AppTabs(
                                color: Colors.grey,
                                text: "Trading",
                              ),
                            ],
                          ),
                        ),
                        preferredSize: const Size.fromHeight(50)),
                  )
                ];
              },
              body: TabBarView(
                  controller: _tabController,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    ListView.builder(
                        itemCount:
                            _popularBooks == null ? 0 : _popularBooks.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),
                                    )
                                  ]),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  _popularBooks[i]["img"]))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 24,
                                              color: Colors.yellow,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _popularBooks[i]["rating"],
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          _popularBooks[i]["title"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _popularBooks[i]["author"],
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Container(
                                          width: 60,
                                          height: 15,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.blue,
                                          ),
                                          child: Text(
                                            "Love",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    const Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                    const Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                  ]),
            ))
          ],
        ),
      )),
    );
  }
}
