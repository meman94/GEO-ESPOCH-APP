import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_espoch/src/bloc/authentication_bloc/bloc.dart';
import 'package:geo_espoch/src/bloc/login_bloc/bloc.dart';
import 'package:geo_espoch/src/repository/user_repository.dart';
import 'package:geo_espoch/src/util/customSnackBar.dart';
import 'create_account_button.dart';
import 'login_button.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    print('isLoginButtonEnabled state: $state, isPopulated: $isPopulated');
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      // tres casos, tres if:
      if (state.isFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            CustomSnackBar(
              content: Text('${state.textState}'),
              behavior: SnackBarBehavior.floating,
            ),
          );
      }
      if (state.isSubmitting) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            CustomSnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Cargando datos, por favor espere'),
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 20,
                    height: 20,
                  )
                ],
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
      }
      if (state.isSuccess) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            CustomSnackBar(
              content: Text('Correcto.!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        Navigator.of(context).pop();
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Iniciar sesión",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      fillColor: Color(0xFF148C41),
                      icon: Icon(Icons.email),
                      labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.always,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isEmailValid
                        ? 'Correo electrónico inválido'
                        : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      fillColor: Color(0xFF148C41),
                      icon: Icon(Icons.lock),
                      labelText: 'Contraseña'),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.always,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPasswordValid
                        ? 'Contraseña invalida'
                        : null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: MediaQuery.of(context).size.width / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Tres botones:
                      // LoginButton
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(height: 45),
                        child: LoginButton(
                            onPressed: isLoginButtonEnabled(state)
                                ? _onFormSubmitted
                                : null),
                      ),
                      // GoogleLoginButton
                      //GoogleLoginButton(),
                      // CreateAccountButton
                      SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(height: 45),
                        child: CreateAccountButton(
                          userRepository: _userRepository,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
