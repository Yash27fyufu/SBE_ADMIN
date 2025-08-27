// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Home',
        theme: whiteAmberBlackTheme,
        home: Home(title: "Home"));
  }
}

ThemeData whiteAmberBlackTheme = ThemeData(
  primarySwatch: Colors.amber,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.amber,
    foregroundColor: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
    titleLarge: TextStyle(color: Colors.black87),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.amber,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
  cardColor: Colors.white,
  dividerColor: Colors.grey[300],
  iconTheme: const IconThemeData(color: Colors.black),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.black87),
    hintStyle: TextStyle(color: Colors.black54),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
  ),
);

/*

showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Update"),
                      content: Text("Do you want to update the app now ?"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text("No"),
                        ),
                        FlatButton(
                            onPressed: () {
                              http
                                  .get(Uri.parse(
                                      "https://vehicle-8c2b1-default-rtdb.firebaseio.com/UpdateUrl.json"))
                                  .then((resp) {
                                launch(json.decode(resp.body));
                              });
                            },
                            child: Text("Yes "))
                      ],
                    );
                  });

*/
