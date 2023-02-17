import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider_search.dart';

class SearchIconClickWidget extends StatelessWidget {
  TextEditingController controller ;
  //String ? typing;
   SearchIconClickWidget({required this.controller }) ;

  @override
  Widget build(BuildContext context) {

    var prov = Provider.of<SearchProvider>(context);


    return TextField(
      cursorColor: CupertinoColors.lightBackgroundGray,
      style: Theme.of(context).textTheme.headline1,
      controller: controller,
      decoration: InputDecoration(
        hintText: "type Search",
        hintStyle: TextStyle(color: Colors.grey.shade300),
        border: InputBorder.none,

      ),
      onChanged: (searchTypingChar){
        prov.getSearchQueryWithResult(searchTypingChar);
      },
    );
  }
}
