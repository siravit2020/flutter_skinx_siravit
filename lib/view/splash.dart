import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/servicers/authentication_service.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                NavigationService.instance.navigateTo('party');
              else
                NavigationService.instance.navigateTo('login');
            });
          } else if (snapshot.hasError) {
            return _ErrorWidget(
              errorMessage: snapshot.error,
            );
          }
          return _Logo();
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
          color: Colors.red,
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

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/logo/goose.svg',
            height: 0.15.sh,
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            'Party\nGoose',
            style: theme.headline1,
          ),
        ],
      ),
    );
  }
}
