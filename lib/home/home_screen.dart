import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/DetailData.dart';
import 'package:movies_app/model/movie.dart';
import 'package:provider/provider.dart';
import '../data/api/api_home.dart';
import '../data/database/sql_database.dart';
import '../data/repo/data_sources/local/local_data_home_imp.dart';
import '../data/repo/data_sources/remote/remote_data_home_imp.dart';
import '../data/repo/repo_home.dart';
import '../data/repo/repo_home_impl.dart';
import '../providers/provider_watch_list.dart';
import '../utilities/components.dart';
import '../utilities/widgets/future_waiting_error.dart';
import '../utilities/widgets/image_stack_widget.dart';
import 'home_widget.dart';
import 'home_top_bar_widget.dart';

class HomeScreen extends StatelessWidget {

  RepoHome repo = RepoHomeImpl(LocalDataHomeIMPL(), RemoteDataHomeIMPL());

  SQLiteDB sqLiteDB = SQLiteDB();
  Movie? movie;

  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderSqlMovie>(context);
    provider.flagListCheckOrNot();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30),

            //Top Rated Movie
            FutureBuilder<List<Movie>>(
                future: repo.getTopRatedMovie(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingballScaleRippleMultiple();
                  } else if (snapshot.hasError) {
                    return noInternetConnection(context);
                  }
                  print(snapshot.data!);
                  return Container(
                      height: 235,
                      width: double.infinity,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 400.0,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          enableInfiniteScroll: true,
                          reverse: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        //Iterable List Of Movie
                        items: snapshot.data?.map((topRatedMovie) {
                          return Builder(builder: (context) {
                            provider.flagListCheckOrNot();

                            //print(snapshot.data!.results![index]);
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      "DetailScreen",
                                      arguments: topRatedMovie);
                                },
                                child: HomeTopBarMovie(
                                    title: topRatedMovie.title,
                                    isWatched: provider.watchedList
                                        .contains(topRatedMovie.id),
                                    id: topRatedMovie.id,
                                    posterPath: topRatedMovie.posterPath,
                                    backgroundImage:
                                        topRatedMovie.backdropPath));
                          });
                        }).toList(),
                      ));
                }),

            SizedBox(
              height: 6,
            ),
            //latest
            Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Popular Movie",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  FutureBuilder<List<Movie>>(
                      //repo if  internet On.. bring data from Api -
                      // If it's Off bring data From Local Sql
                      future: repo.getPopularMovie(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return loadingballScaleRippleMultiple();
                        } else if (snapshot.hasError) {
                          return noInternetConnection(context);
                        }
                        print(snapshot.data);
                        return Container(
                          height: 195,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var movieList = snapshot.data![index];
                                var movieProviderWatchedList =
                                    provider.watchedList;

                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        routeNameDetailScreen,
                                        arguments: movieList);
                                  },
                                  child: HomeCardWidget(
                                    title: movieList.title,
                                    voteAverage: movieList.voteAverage,
                                    posterPath: movieList.posterPath,
                                    movieId: movieList.id,
                                    id: movieList.id,
                                    overview: movieList.overview,
                                    date: movieList.releaseDate,
                                    isWatched: movieProviderWatchedList
                                        .contains(movieList.id),
                                  ),
                                );
                              }),
                        );
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            //related
            Container(
                color: Theme.of(context).canvasColor,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Latest Movie",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      FutureBuilder<DetailData>(
                          future: ApiHome.getLatestMovies(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return loadingballScaleRippleMultiple();
                            } else if (snapshot.hasError) {
                              return noInternetConnection(context);
                            }
                            //because latest movie api return just one movie so keep it in loop
                            List<DetailData> movieList = [];
                            return Container(
                              height: 195,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    for (int i = 0; i < 10; i++) {
                                      movieList.add(snapshot.data!);
                                    }

                                    var movieData = snapshot.data!;
                                    print("movieList.status ${movieData.status}");
                                    return HomeCardWidget(
                                      title: movieData.title,
                                      voteAverage: movieData.voteAverage,
                                      posterPath: movieData.posterPath,
                                      isRelased: false,
                                      status: movieData.status,
                                      id: movieData.id,
                                      overview: movieData.overview,
                                      date: movieData.releaseDate,
                                    );
                                  }),
                            );
                          }),
                    ]))
          ],
        ),
      ),
    );
  }
}
