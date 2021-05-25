import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skinx_siravit/config/theme/base_theme.dart';
import 'package:flutter_skinx_siravit/providers/create_party_provider.dart';
import 'package:flutter_skinx_siravit/providers/register_provicer.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
import 'package:flutter_skinx_siravit/view/create_party.dart';
import 'package:flutter_skinx_siravit/view/login.dart';
import 'package:flutter_skinx_siravit/providers/login_provider.dart';
import 'package:flutter_skinx_siravit/view/party.dart';
import 'package:flutter_skinx_siravit/view/register.dart';
import 'package:flutter_skinx_siravit/view/splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        return SizedBox();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 847),
      builder: () {
        return MultiProvider(
          providers: [
            Provider(
              create: (_) => LoginProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => RegisterChangeNotifierProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CreatePartyChnageNotifierProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: baseTheme,
            navigatorKey: NavigationService.instance.navigationKey,
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child!),
            initialRoute: "createParty",
            routes: {
              "splash": (_) => SplashScreen(),
              "login": (_) => LoginPage(),
              "register": (_) => RegisterPage(),
              "party": (_) => PartyPage(),
              "createParty": (_) => CreatePartyPage(),
            },
          ),
        );
      },
    );
  }
}
