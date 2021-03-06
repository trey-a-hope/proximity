import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:proximity/models/user.dart';
import 'package:proximity/services/auth_service.dart';
import 'package:proximity/widgets/drawer.dart';
import 'package:proximity/widgets/spinner.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Geoflutterfire geo = Geoflutterfire();
  Firestore _firestore = Firestore.instance;
  LocationData currentLocation;
  var location = Location();
  double longitude = 0.0;
  double latitude = 0.0;
  double radius = 20;
  final GetIt getIt = GetIt.I;
  bool _isLoading = false;
  User user;
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition position = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    _load();
    _createStream();
  }

  _load() async {
    user = await getIt<AuthService>().getCurrentUser();

    setState(() {});

    //Determine if location services are turned on.
    bool hasPermission = await location.hasPermission();
    if (hasPermission) {
      //Continue with app.
    } else {
      bool success = await location.requestPermission();
      if (success) {
        //Continue with app.
      } else {
        //Show message saying this app won't work without permission.
      }
    }

    // //Determine if location services are turned on.
    // bool serviceEnabled = await location.serviceEnabled();
    // if (serviceEnabled) {
    //   //Continue with app.
    // } else {
    //   bool success = await location.requestService();
    //   if (success) {
    //     //Continue with app.
    //   } else {
    //     //Show message saying this app won't work without permission.
    //   }
    // }
  }

  void _updateLocation() async {
    try {
      setState(() {
        _isLoading = true;
      });

      //Retrieve user's current location.
      currentLocation = await location.getLocation();

      //Create geo point based on location.
      GeoFirePoint myLocation = geo.point(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);

      //Update location in database.
      _firestore
          .collection('Users')
          .document('pEZfU7gpbjRVrUryQlcz')
          .updateData({
        'firstName': 'Trey',
        'lastName': 'Hope',
        'position': myLocation.data
      });

      //Update UI of new location coordinates.
      setState(() {
        longitude = currentLocation.longitude;
        latitude = currentLocation.latitude;
        _isLoading = false;
      });
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print(e);
      }
      currentLocation = null;
    }
  }

  void _createStream() async {
    // Create a geoFirePoint
    GeoFirePoint center = geo.point(latitude: 39, longitude: -84);

    // Fetch users who are currently following leader X.
    Query collectionRef =
        _firestore.collection('Users').where('leaderID', isEqualTo: "f");

    //TODO: For some reason the 'where' clause is making the query return 0 results. Without it, it works perfectly fine.

    String field = 'position';

    // DocumentSnapshot d = (await collectionRef.getDocuments()).documents.first;
    // print(d.documentID);

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionRef)
        .within(center: center, radius: radius, field: field);

    stream.listen((List<DocumentSnapshot> documentList) {
      if (documentList.isEmpty) {
        print('No one within $radius km');
      } else {
        for (var i = 0; i < documentList.length; i++) {
          print(documentList[i].documentID);
        }
      }
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _goToMyLocation() async {
    setState(() {
      _isLoading = true;
    });

    //Retrieve user's current location.
    currentLocation = await location.getLocation();

    //Create geo point based on location.
    GeoFirePoint myLocation = geo.point(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude);

    position = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 14.4746,
    );

    // final GoogleMapController controller = await _controller.future;
    // await controller.animateCamera(CameraUpdate.newCameraPosition(position));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Proximity',
          style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: DrawerWidget(page: 'Home', user: user),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToMyLocation,
        label: Text('Update My Location'),
        icon: Icon(Icons.location_on),
      ),
      body: _isLoading
          ? Spinner(
              text: 'Updating location...',
            )
          : ListView(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: position,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                // Text('Longitude: $longitude'),
                // Text('Latitude: $latitude'),
                // RaisedButton(
                //   child: Text('Update My Location'),
                //   onPressed: _updateLocation,
                // ),
                Divider(),
                ListTile(
                  title: Text('Radius: ${radius.toInt()}'),
                  subtitle: Text('Kilometers'),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // activeTrackColor: Colors.red,
                    // inactiveTrackColor: Colors.black,
                    // trackHeight: 3.0,
                    // thumbColor: Colors.yellow,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayColor: Colors.purple.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
                  ),
                  child: Slider(
                      value: radius,
                      min: 0.0,
                      max: 50.0,
                      onChanged: (value) {
                        setState(() {
                          radius = value;
                        });
                      }),
                ),
              ],
            ),
    );
  }
}
