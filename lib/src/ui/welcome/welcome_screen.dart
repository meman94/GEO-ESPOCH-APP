import 'package:flutter/material.dart';
import 'package:geo_espoch/src/repository/user_repository.dart';
import 'package:geo_espoch/src/ui/login/login_screen.dart';
import 'package:geo_espoch/src/ui/register/register_screen.dart';
import 'package:geo_espoch/src/util/custom_buttom.dart';

class WelcomeScreen extends StatefulWidget {
  final UserRepository _userRepository;

  WelcomeScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/espochWallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(.5)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/logoWhite.png",
                  height: 200.0,
                  width: 200.0,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomButton(
                      backgroundColor: Color(0xFF148C41),
                      height: 50,
                      textColor: Colors.white,
                      text: "INICIAR SESIÓN",
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen(
                            userRepository: widget._userRepository,
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      backgroundColor: Colors.transparent,
                      height: 50,
                      textColor: Colors.white,
                      text: "REGÍSTRATE",
                      decoration: TextDecoration.underline,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(
                            userRepository: widget._userRepository,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
