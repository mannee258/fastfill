import 'package:flutter/material.dart';
import 'package:fastfill/models/petrolmodel.dart';
import 'package:fastfill/views/components/listItemcard.dart';
import 'package:fastfill/models/stations.dart';
import 'package:fastfill/models/stations-api.dart';




class PetrolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder (
          future: fetchStations(),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index){
                  Stations stations = snapshot.data[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${stations.station}', style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent),),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ));
  }
}


// class PetrolPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: ListView.builder(
//           itemCount: menu.length,
//           itemBuilder: (context, int key) {
//             return ListItemCard(index: key);
//           },
//         ));
//   }
// }
