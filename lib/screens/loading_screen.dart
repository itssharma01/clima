import 'dart:ffi';
import 'package:weathercheck/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:weathercheck/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {
  String cityName='';
  double cityTemp=0.0;
  String cityWeather='';
  String cityDescription='';
  double cityWindspeed=0.0;
  static const String apiKey = '70b5b6e650ef88b0cb8764af84d6ba8d';
  TextEditingController editingController = TextEditingController();
  double lat=0.0 ;
  double lon=0.0 ;

  void getLocation() async{
    Location location = Location();
    location.getCurrentLocation();
    lat = location.latitude;
    lon = location.longitude;
  }
  @override
  void initState() {
    //getLocation();    //will get the user's current location
    //getData();  //will get the weather data
  }
  @override
  void deactivate() {
    print('Samajh gaye be');
  }

  void getData(String city) async {
    String url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      String data =response.body;
      print(data);
      cityTemp = jsonDecode(data)['main']['temp'];
     // print(jsonDecode(data)['weather'][0]['id']);
      cityDescription=jsonDecode(data)['weather'][0]['main'];
      //print(jsonDecode(data)['name']);
      cityWindspeed = jsonDecode(data)['wind']['speed'];
    } else {
      print(response.statusCode);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: editingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the City',
                    hintText: 'Enter the City',
                ),
                autofocus: false,
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  //Get the current location
                  // getLocation();
                  if(editingController.text.isNotEmpty){
                    //do the desire verification
                    cityName = editingController.text;
                    getData(cityName);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LocationScreen(),),
                    );
                  }
                  else {
                    //pop a message to enter a text.
                    // print('Enter a valid String');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Center(
                      child: Text('Please Enter a City!!',
                      style: TextStyle(
                        color: Colors.black87,
                        backgroundColor: Colors.white,
                      ),
                      ),
                    ),
                    ));
                  }
                },
                child: Text('Get Location'),
              ),
              // Text('$cityTemp'),
              // SizedBox(height: 25),
              // Text('$cityDescription'),
              // SizedBox(height: 25),
              // Text('$cityWindspeed'),
            ],
          ),
        ),
      ),
    );
  }
}
