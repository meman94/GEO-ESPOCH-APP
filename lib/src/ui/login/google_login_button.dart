import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_espoch/src/bloc/login_bloc/bloc.dart';
import 'package:geo_espoch/src/util/flushbar.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleSignInButton(
      text: 'Inicia sesión con Google',
      darkMode: true,
      onPressed: () {
        CustomFlushbar(
                context: context,
                icon: Icon(Icons.hourglass_empty),
                message: 'Por favor espere',
                title: 'Cargando datos.')
            .floatingFlushbarLoading();
        /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Loggin in...'),
            CircularProgressIndicator(),
          ],
        ))); */
        BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
      },
    );
  }
}
