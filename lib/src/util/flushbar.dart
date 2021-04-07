import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushbar {
  final String title;
  final String message;
  final BuildContext context;
  final Icon icon;

  CustomFlushbar(
      {@required this.title,
      @required this.message,
      @required this.context,
      @required this.icon});

  floatingFlushbar() {
    return Flushbar(
      titleText: Text(title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 17)),
      messageText:
          Text(message, style: TextStyle(color: Colors.black.withOpacity(0.6))),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      icon: icon,
      backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.repeated,
          colors: [
            Color(0xFFDD170E),
            Color(0xFFF2F1EF),
            Color(0xFFF2F1EF),
            Color(0xFF148C41)
          ]),
      boxShadows: [
        BoxShadow(
          color: Color(0xFF0B060A),
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
      duration: Duration(milliseconds: 2500),
      isDismissible: true,
    )..show(context);
  }

  floatingFlushbarLoading() {
    return Flushbar(
      titleText: Text(title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: 17)),
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(message, style: TextStyle(color: Colors.black.withOpacity(0.6))),
          Transform.scale(
            scale: 0.7,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black.withOpacity((0.6))),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      icon: icon,
      backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.repeated,
          colors: [
            Color(0xFFDD170E),
            Color(0xFFF2F1EF),
            Color(0xFFF2F1EF),
            Color(0xFF148C41)
          ]),
      boxShadows: [
        BoxShadow(
          color: Color(0xFF0B060A),
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
      duration: Duration(milliseconds: 2500),
      isDismissible: true,
    )..show(context);
  }
}
