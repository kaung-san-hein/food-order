import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/providers/app.dart';
import 'package:food_order/src/providers/auth.dart';
import 'package:food_order/src/providers/category.dart';
import 'package:food_order/src/providers/product.dart';
import 'package:food_order/src/providers/restaurant.dart';
import 'package:food_order/src/screens/home.dart';
import 'package:food_order/src/screens/login.dart';
import 'package:food_order/src/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider.initialize()),
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Order Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: ScreensController(),
      ),
    );
  }
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (context.watch<AuthProvider>().status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Authenticating:
      case Status.Unauthenticated:
        return Login();
      case Status.Authenticated:
        return Home();
      default:
        return Login();
    }
  }
}
