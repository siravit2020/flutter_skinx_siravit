
import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/servicers/authentication_service.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
import 'package:flutter_skinx_siravit/widgets/logo.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: AuthenticationServices().checkUserSigned(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          print(snapshot.hasData);

          if (snapshot.hasData) {
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              if (snapshot.data!)
                NavigationService.instance.navigateToReplacement('home');
              else
                NavigationService.instance.navigateToReplacement('login');
            });
          } else if (snapshot.hasError) {
            return _ErrorWidget(
              errorMessage: snapshot.error,
            );
          }
          return Logo();
        },
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final Object? errorMessage;

  const _ErrorWidget({Key? key, required this.errorMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: colorRed,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error: $errorMessage'),
        )
      ],
    );
  }
}


