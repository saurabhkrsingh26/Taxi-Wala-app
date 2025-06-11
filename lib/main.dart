import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/InCity/Testing.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/Route/Rroutes.dart';
import 'package:taxiwala/res/provider/aurthProvider.dart';
import 'package:taxiwala/res/provider/carBookingProvider.dart';
import 'package:taxiwala/res/provider/car_live_provider.dart';
import 'package:taxiwala/res/provider/carTypeProvider.dart';
import 'package:taxiwala/res/provider/profile_provider.dart';
import 'package:taxiwala/res/provider/updateProfile_provider.dart';
import 'package:taxiwala/res/provider/userViewProvider.dart';
import 'package:taxiwala/res/provider/verificationProvider.dart';
import 'package:taxiwala/res/provider/whatsapp_view_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (context)=>AuthProvider()),
         ChangeNotifierProvider(create: (context)=>UserViewProvider()),
         ChangeNotifierProvider(create: (context)=>VerificationProvider()),
         ChangeNotifierProvider(create: (context)=>ProfileProvider()),
         ChangeNotifierProvider(create: (context)=>UpdateProfile()),
         ChangeNotifierProvider(create: (context)=>CarTypeProvider()),
         ChangeNotifierProvider(create: (context)=>CarBookingProvider()),
         ChangeNotifierProvider(create: (context)=>CarLiveProvider()),
         ChangeNotifierProvider(create: (context)=>WhatsappViewProvider()),
       ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        routes: Routers.routes,
       // home: Testing(),
      ),
    );
    }
}