import 'package:flutter/material.dart';
import 'package:movies_app/providers/provider_search.dart';
import 'package:movies_app/home/home_screen.dart';
import 'package:movies_app/mythemdata.dart';
import 'package:movies_app/seartch/search_screen.dart';
import 'package:movies_app/utilities/components.dart';
import 'package:movies_app/utilities/widgets/watched_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'details/detail_screen.dart';
import 'geners/geners_screen.dart';
import 'geners/genrs_descovery_list.dart';
import 'home/home_bottombar.dart';
import 'model/movie.dart';
import 'providers/provider_watch_list.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProviderSqlMovie()),
          ChangeNotifierProvider(create: (context) => SearchProvider(),)
        ],
          child:
      const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',
      theme: MyThemeData.movieDarkMode,
      initialRoute: routeNameHomeStartBottomBar,
      routes: {
        routeNameHomeScreen : (context)=> HomeScreen(),
        routeNameHomeStartBottomBar: (context)=> HomeStartBottomBar(),
        routeNameDetailScreen : (context)=> DetailScreen(),
        routeNameSearchScreen : (context)=> SearchScreen(),
        routeNameGenersScreen : (context)=> GenersScreen(),
        routeNameGenresDescoveryList : (context) => GenresDescoveryList()
      },

    );
  }
}
