import 'package:firebase_auth/firebase_auth.dart';
import '../core/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutterchallenge/views/my_home_page.dart';
import '../repositories/auth_repository.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple[400],
        child: Center(
            child: Card(
          color: Colors.white,
          elevation: 5,
          child: FlatButton(
            child:
                Text('Login com google', style: TextStyle(color: Colors.grey)),
            onPressed: () async => await AuthRepository(FirebaseAuth.instance)
                .doLoginGoogle()
                .then((response) {
                  print(response.status);
              if (response.status == ResponseStatus.Success) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()));
              }
            }),
          ),
        )),
      ),
    );
  }
}
