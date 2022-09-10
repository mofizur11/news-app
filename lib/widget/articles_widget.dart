import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screen/news_details_page.dart';

class ArticlesWidget extends StatelessWidget {
  Articles? article;
  ArticlesWidget(this.article);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final article=Provider.of<Article>(context);

    //final article = Provider.of<Article>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetailsScreen(date: article.publishedAt.toString(),)));
            // Navigate to the in app details screen
            /* Navigator.pushNamed(context, NewsDetails.routeName,
                arguments: article.publishedAt
            );*/

            Navigator.of(context).pushNamed(NewsDetails.routeName,
                arguments: article!.publishedAt);
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Colors.red,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: "${article!.publishedAt}",
                        child: FancyShimmerImage(
                            height: size.height * 0.12,
                            width: size.height * 0.12,
                            boxFit: BoxFit.fill,
                            errorWidget: Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf_tAveEhVLVMnpUaQ6psC-SJ8oPz-LnGQKw&usqp=CAU'),
                            imageUrl: "${article!.urlToImage}"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${article!.title} ' * 100,
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            //style: smallTextStyle,
                          ),
                          // const VerticalSpacing(5),
                          const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              ' ',
                              //   style: smallTextStyle,
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    /*  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: NewsDetailsWebView(
                                            url: '${article!.url} ',
                                          ),
                                          inheritTheme: true,
                                          ctx: context),
                                    );*/
                                  },
                                  icon: const Icon(
                                    Icons.link,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  '${article!.publishedAt} ',
                                  maxLines: 1,
                                  //    style: smallTextStyle,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
