class Errors {
  static String stringError(String error) {
    if (error ==
        'The password is invalid or the user does not have a password.')
      error = 'La contraseña no es válida o el usuario no tiene contraseña.';

    if (error == 'The email address is already in use by another account.')
      error =
          'La dirección de correo electrónico ya está siendo utilizada por otra cuenta.';
    return error.toString();
  }
}
