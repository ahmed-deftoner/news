import 'package:flutter/material.dart';
import 'package:news/models/news_info.dart';
import 'package:news/services/api_manager.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Future<Welcome> _newsModel;

  @override
  void initState() {
    // TODO: implement initState
    _newsModel = API_manager().getNews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: Container(
        child: FutureBuilder<Welcome>(
          future: _newsModel,
          builder: (context,snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context,index){
                    var articles = snapshot.data.articles[index];
                return Container(
                  height: 100,
                  child: Row(
                    children: <Widget>[
                       Card(
                  clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(articles.urlToImage,
                          fit: BoxFit.cover,
                        )),
                  ),
                       Flexible(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Text(
                               articles.title,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                               ),
                             ),
                             Text(
                               articles.description,
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                             )
                           ],
                         ),
                       )
                    ],
                  ),
                );
              });
            }
            else
              return Center(
               child: CircularProgressIndicator()
              );
          },
        )
      ),
    );
  }
}
