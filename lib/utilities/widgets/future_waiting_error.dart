

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

Widget loadingballScaleRippleMultiple(){
  return Center(
    child: Container(
      height: 30,
      child: LoadingIndicator(
          indicatorType: Indicator.ballScaleRippleMultiple, /// Required, The loading type of the widget
          colors: const [Colors.white],       /// Optional, The color collections
          strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
          pathBackgroundColor: Colors.black26
      ),
    ),
  );
}


Widget noInternetConnection(BuildContext context){
  return  Center(
    child: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      color: Colors.blueAccent.withOpacity(0.7),
      child: Column(children: [
        Icon(Icons.wifi_off , color: Colors.white,),
        Text("No Internt Connection!!!!",style: Theme.of(context).textTheme.headline1,),

      ],),
    ),
  );
}