import 'package:geolocator/geolocator.dart';

class Location{
  double latitude=0,longitude=0;

  void getCurrentLocation() async{
    try {
      Position position;
      LocationPermission permission;
      permission= await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
      }
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      print(latitude);
      print(longitude);
    } catch (e) {
      print(e);
    }
  }

}