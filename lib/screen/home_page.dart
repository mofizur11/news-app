import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widget/articles_widget.dart';
import 'package:news_app/widget/const.dart';
import 'package:news_app/widget/error_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Articles> newsList = [];

/*  @override
  void didChangeDependencies() async {
    newsList = await NewsApiService().fetchNewsData();
    setState(() {});
    super.didChangeDependencies();
  }*/
  String sortBy = SortNews.popularity.name;

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<NewsProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
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
                    paginationButton(
                        onTap: () {
                          setState(() {
                            currentIndex--;
                          });
                        },
                        title: "Prev"),
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
                    paginationButton(
                        onTap: () {
                          setState(() {
                            currentIndex++;
                          });
                        },
                        title: "Next"),
                  ],
                ),
              ),
              DropdownButton<String>(
                  value: sortBy,
                  items: [
                    DropdownMenuItem(
                      child: Text("${SortNews.popularity.name}"),
                      value: SortNews.popularity.name,
                    ),
                    DropdownMenuItem(
                      child: Text("${SortNews.publishedAt.name}"),
                      value: SortNews.publishedAt.name,
                    ),
                    DropdownMenuItem(
                      child: Text("${SortNews.relevancy.name}"),
                      value: SortNews.relevancy.name,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                    });
                  }),
              FutureBuilder<List<Articles>>(
                future: providerData.getNewsData(
                    page: currentIndex, sortBy: sortBy),
                /* future: NewsApiService.fetchNewsData(
                    page: currentIndex, sortBy: sortBy),*/
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const ErrorScreen();
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ArticlesWidget(snapshot.data![index]);
                      });
                },
              ),
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

enum SortNews { publishedAt, popularity, relevancy }
