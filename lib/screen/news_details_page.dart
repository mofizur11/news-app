import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsDetails extends StatefulWidget {
  static const routeName = "/newsDetails";
  const NewsDetails({Key? key}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    final publishAt = ModalRoute.of(context)!.settings.arguments as String;
    final currenData =
        Provider.of<NewsProvider>(context).sortByDate(date: publishAt);

    //final currentNews =  Provider.of<NewsProvider>(context).findByDate(publishAt: publishedAt);
    return Scaffold(
     appBar: AppBar(
      title: Text("${currenData.author}"),
     ),

     body: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
         Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(image:NetworkImage("${currenData.urlToImage}")),
          ),
          child: Image.network("${currenData.urlToImage}",fit: BoxFit.cover,),
         ),

         Text('${currenData.content}')
        ],
      ), 
     ),



    );
  }
}
