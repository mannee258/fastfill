import 'package:flutter/material.dart';
import 'package:fastfill/views/pages/homePage.dart';
import 'package:fastfill/views/pages/splash_page.dart';
import 'package:fastfill/views/pages/mappage.dart';
import 'package:fastfill/bloc/applicationBloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Applicationbloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FastFill',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
      ),
    );
  }
}
