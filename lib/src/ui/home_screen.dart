import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_espoch/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:geo_espoch/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _value = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Text('Bienvenido ${widget.name}!'),
          ),
          SizedBox(
            height: 50,
          ),
          SfSliderTheme(
            data: SfSliderThemeData(
              thumbRadius: 20,
            ),
            child: SfSlider(
              activeColor: Color.fromARGB(255, 248, 247, 242),
              value: _value,
              min: 1.0,
              max: 40.0,
              thumbIcon: Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
                color: Color.fromARGB(255, 7, 99, 114),
              ),
              onChanged: (dynamic value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
