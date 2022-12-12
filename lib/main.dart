import 'package:app_delivery/providers/google_provider.dart';
import 'package:app_delivery/screens/home.dart';
import 'package:app_delivery/screens/home/add_direction.dart';
import 'package:app_delivery/screens/home/maps/map_android.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GoogleProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PRUEBA',
        routes: {
          'home': (_) => const Home(),
          'adddirection': (_) => const AddDirection(),
          'mapandroid': (_) => const MapAndroid(),
        },
        initialRoute: 'home',
      ),
    );
  }
}
