import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/geners/genrs_descovery_list.dart';

import '../data/api/api_category.dart';
import '../model/Genres.dart';
import '../utilities/components.dart';
import '../utilities/widgets/future_waiting_error.dart';

class GenersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Text(
            "rtvsefvscev",
            style: Theme.of(context).textTheme.headline3,
          ),
          FutureBuilder<GenresData>(
              future: CategoryApi.getMoviesGenersList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingballScaleRippleMultiple();
                } else if (snapshot.hasError) {
                  return noInternetConnection( context );
                }

                return Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: snapshot.data?.genres?.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data?.genres![3].name);
                          return categoryListWidget(context,
                              snapshot.data!.genres![index],

                          );
                        }));
              }),
        ],
      ),
    );
  }
}

Widget categoryListWidget(context, Genres genres ) {
  return InkWell(
    onTap: (){
      Navigator.of(context).pushNamed(routeNameGenresDescoveryList
      ,arguments: genres
      );
    },
    child: Container(
      height: 20,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/categ.jpeg",
              ))),
      child: Center(
          child: Text(
            genres.name ?? "",
        style: Theme.of(context).textTheme.headline3,
      )),
    ),
  );
}
