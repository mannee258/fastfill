import 'package:fastfill/models/stations.dart';
import 'package:http/http.dart' as http;

Future<List<Stations>> fetchStations() async {
  String url = "https://mapx.gr33nium.com/Super/stationapi.php";
  final response = await http.get(Uri.parse(url));
  return stationsFromJson(response.body);
}
