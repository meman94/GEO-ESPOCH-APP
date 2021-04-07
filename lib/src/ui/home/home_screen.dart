import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:geo_espoch/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:geo_espoch/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:geo_espoch/src/util/location.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapBoxOptions _options;
  MapBoxNavigation _directions;

  Position position;

  final _stop = WayPoint(
      name: "Way Point 2",
      latitude: -1.6566607754834128,
      longitude: -78.67826568081152);

  @override
  void initState() {
    super.initState();
    initialize();
    determinePosition();
  }

  Future<void> initialize() async {
    _directions = MapBoxNavigation();
    _options = MapBoxOptions(
        initialLatitude: -1.6566607754834128,
        initialLongitude: -78.67826568081152,
        zoom: 16.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: true,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "es");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.grey,
          child: MapBoxNavigationView(
            options: _options,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.5), spreadRadius: 3),
              ],
            ),
            child: Expanded(
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text("Iniciar A a B"),
                    onPressed: () async {
                      Position position = await determinePosition();
                      print(position == null
                          ? 'Unknown'
                          : position.latitude.toString() +
                              ', ' +
                              position.longitude.toString());

                      WayPoint _origin = WayPoint(
                          name: "Way Point 1",
                          latitude: position.latitude,
                          longitude: position.longitude);

                      // ignore: deprecated_member_use
                      var wayPoints = List<WayPoint>();
                      wayPoints.add(_origin);
                      wayPoints.add(_stop);

                      await _directions.startNavigation(
                          wayPoints: wayPoints,
                          options: MapBoxOptions(
                              mode: MapBoxNavigationMode.walking,
                              simulateRoute: true,
                              language: "es",
                              units: VoiceUnits.metric));
                    },
                  ),
                  ElevatedButton(
                    child: Text("Cerrar sesión"),
                    onPressed: () async {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
