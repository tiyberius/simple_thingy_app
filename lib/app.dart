import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:simple_thingy_app/navigation/router.dart';
import 'package:flutter/material.dart';

class SimpleThingyApp extends StatelessWidget {
  const SimpleThingyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp.router(
        routerConfig: router,
        builder: Authenticator.builder(),
      ),
    );
  }
}
