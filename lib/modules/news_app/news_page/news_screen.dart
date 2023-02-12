import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/status.dart';

class newsScreen extends StatelessWidget {

  final Map model;

  newsScreen({
    required this.model,
});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit,newsStates>(
        builder: (context,state)  {
          newsCubit cubit = newsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search)
                ),
                IconButton(
                  onPressed: (){
                    cubit.changeMode();
                  },
                  icon: cubit.isDark ? Icon(Icons.light_mode) : Icon(Icons.dark_mode),
                ),
              ],
            ),
            body: Column(
              children: [
                GestureDetector(
                  child: Hero(
                    tag: 'my-news-image',
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            image: NetworkImage(model['urlToImage'] ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWvnSGn0Sz9fq2q8diNPsaVcgfXcq4Lb3L8w&usqp=CAU'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(
                      appBar: AppBar(backgroundColor: Colors.transparent,elevation:0,title: Text("news image",style: Theme.of(context).textTheme.headline1,),),
                      body: Hero(
                        tag: 'my-news-image',
                        child: PhotoView(
                          minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered,
                            imageProvider: NetworkImage(model['urlToImage'] ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWvnSGn0Sz9fq2q8diNPsaVcgfXcq4Lb3L8w&usqp=CAU')),

                      ),
                    )));
                  },
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child:Column(
                    children: [
                      Text(
                        model['title'],
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: 20,),
                      Text(model['description'] ?? 'no data',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Icon(Icons.location_history,color: Colors.grey,),
                                TextButton(
                                  child: BuildCondition(
                                    condition: model['author'].toString().contains('<a href') == true,
                                    builder:(context) => Text('News Website',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    fallback: (context) => Text(model['author'] ?? 'unknown',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onPressed: (){},
                                ),

                              ],
                            ),
                          ),
                          Text(model['publishedAt'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),)
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          );
        },
        listener: (context,state) {}
    );
  }
}
