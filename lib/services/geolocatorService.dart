import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCuttentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
