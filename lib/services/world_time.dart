import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String ?location; //location name for the UI
  String ?time; //the time in that location
  String ?flag; //url to the asset flag icon
  String ?url; //location url for api endpoints
  bool ?isDaytime; //true or false if day or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{

    try {

      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from jason
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      //create datetime object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDaytime = now.hour > 0 && now.hour < 12 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch (e){
     print('Caught ERROR!!: $e');
     time = 'Could not get time data';
    }


  }

}

