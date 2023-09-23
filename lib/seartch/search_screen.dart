
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/providers/provider_search.dart';
import 'package:movies_app/geners/discovery_widget.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/seartch/search_click_icon_widget.dart';
import 'package:movies_app/seartch/search_result_list.dart';
import '../utilities/widgets/future_waiting_error.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  bool isSearch = false;


  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<SearchProvider>(context);
    prov.searchTitle;

    return Scaffold(
        appBar: (
            isSearch == false ? searchFalse()
                : searchTrue()
        ),
        body: ChangeNotifierProvider(
          create: (context) => SearchProvider(),
          child: StreamBuilder(
              stream: prov.streamSearchTitle,
              builder: (BuildContext buildContext,
                  AsyncSnapshot<List<Movie>?> snapshot) {

              if(!snapshot.hasData){
                Text("OOOPPPPSS",style: TextStyle(color: Colors.white),);
              }

                if (snapshot == null) {

                  return Container();
                }
                return snapshot.connectionState == ConnectionState.waiting
                    ?  Center(
                  child: loadingballScaleRippleMultiple()
                )

                    :
                SearchResultsLists(movie: snapshot.data);
              }),
        )
    );

  }

  AppBar searchFalse(){
    return AppBar(
        actions: [IconButton(icon: Icon(Icons.search),
          onPressed: _startSearch,)]);
  }
  AppBar searchTrue(){
    return AppBar(
      title: SearchIconClickWidget(controller: controller,) ,
      actions: [
        IconButton(icon: Icon(Icons.close),
          onPressed: (){
            stopSearch();
            Navigator.pop(context);
          },
        )
      ],);
  }

  void _startSearch(){
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    isSearch = true;
    setState(() {
    });
  }

  void stopSearch() {
    setState(() {
      isSearch = false;
      controller.clear();
    });
  }


}

