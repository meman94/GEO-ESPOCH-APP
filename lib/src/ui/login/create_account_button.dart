import 'package:flutter/material.dart';
import 'package:geo_espoch/src/repository/user_repository.dart';
import 'package:geo_espoch/src/ui/register/register_screen.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.only(
          bottom: 5, // Space between underline and text
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color(0xFF148C41),
          width: 1.0, // Underline thickness
        ))),
        child: Text(
          "Eres nuevo? Crea una cuenta aquí.",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RegisterScreen(
            userRepository: _userRepository,
          );
        }));
      },
    );
  }
}
