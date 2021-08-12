import 'dart:async';
import 'dart:ui';

import 'package:fastfill/bloc/applicationBloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fastfill/views/components/gasPage.dart';
import 'package:fastfill/views/components/petrolPage.dart';
import 'package:fastfill/models/stations.dart';
import 'package:fastfill/models/stations-api.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:fastfill/models/place.dart';

class Homepage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
  double value = 0;
  double CAMERA_ZOOM = 15;
  double CAMERA_TILT = 80;
  class _HomePageState extends State<Homepage>{

    
    Completer<GoogleMapController> _mapController = Completer();
    StreamSubscription locationSubscription;
    StreamSubscription boundsSubscription;
    final _locationController = TextEditingController();

  @override
  void initState() {
    final applicationBloc =
        Provider.of<Applicationbloc>(context, listen: false);


    //Listen for selected Location
    locationSubscription = applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }



  @override
  void dispose() {
    final applicationBloc =
        Provider.of<Applicationbloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

 







  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final applicationBloc = Provider.of<Applicationbloc>(context);

    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
            children: [
               Container(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                            height: height * 0.5,
                            child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                      applicationBloc.currentLocation.latitude,
                                      applicationBloc.currentLocation.longitude,
                                    ),
                                    zoom: CAMERA_ZOOM,
                                    tilt: CAMERA_TILT),
                                    onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                          },
                          markers: Set<Marker>.of(applicationBloc.markers),))
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(0.0, -(height * 0.3 - height * 0.26)),
                      child: Container(
                        width: width,
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: <Widget>[
                                TabBar(
                                    labelColor: Colors.black,
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    unselectedLabelColor: Colors.grey[400],
                                    unselectedLabelStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorColor: Colors.transparent,
                                    tabs: <Widget>[
                                      Tab(
                                        child: Text("Petrol"),
                                      ),
                                      Tab(
                                        child: Text("Gas"),
                                      )
                                    ]),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: TextField(
                                    controller: _locationController,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 3),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Icon(
                                            Icons.search,
                                            size: 30,
                                          ),
                                        ),
                                        hintText: "Where To",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors.grey[400]),),),
                                    onChanged: (value) =>
                                        applicationBloc.searchPlaces(value),
                                        onTap: () {
                                          applicationBloc.clearSelectedLocation();
                                        },
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: height * 0.6,
                                      child: TabBarView(children: <Widget>[
                                        PetrolPage(),
                                        GasPage(),
                                      ]),
                                    ),
                                    if (applicationBloc.searchResults != null &&
                                        applicationBloc.searchResults.length != 0)
                                      Container(
                                          height: height * 0.5,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(.6),
                                              backgroundBlendMode:
                                              BlendMode.darken)),
                                    if (applicationBloc.searchResults != null)
                                      Container(
                                        height: height * 0.5,
                                        child: ListView.builder(
                                          itemCount:
                                          applicationBloc.searchResults.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                applicationBloc.searchResults[index]
                                                    .description,
                                                style:
                                                TextStyle(color: Colors.black,
                                              ),
                                            ));
                                          },
                                        ),
                                      ),
                                  ],
                                ),

                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
              
            ),
    );
  }
    Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }
}

// void mapCreated(controller) {
//   setState(() {
//     _controller = controller;
//   });
// }

void setState(Null Function() param0) {}
