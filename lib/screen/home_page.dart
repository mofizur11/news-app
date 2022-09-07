import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news_api_service.dart';
import 'package:news_app/widget/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> newsList = [];

  @override
  void didChangeDependencies() async {
    newsList = await NewsApiService().fetchNewsData();
    setState(() {});
    super.didChangeDependencies();
  }

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          "News App",
          style: myStyle(18, Colors.black, FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All News",
                style: myStyle(18, Colors.black, FontWeight.w700),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    paginationButton(onTap: () {}, title: "Prev"),
                    Flexible(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: MaterialButton(
                                  color: index + 1 == currentIndex
                                      ? Colors.blue
                                      : Colors.white12,
                                  minWidth: 30,
                                  onPressed: () {
                                    setState(() {
                                      currentIndex = index + 1;
                                    });
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text("${index + 1}"),
                                ),
                              );
                            })),
                    paginationButton(onTap: () {}, title: "Next"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${newsList[index].urlToImage}"))),
                              )),
                          Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Text("${newsList[index].title}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("${newsList[index].publishedAt}"),
                                ],
                              ))
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton paginationButton({VoidCallback? onTap, String? title}) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(
          "$title",
          style: myStyle(14, Colors.white),
        ));
  }
}
