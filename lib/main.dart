import 'package:flutter/material.dart';
import 'package:flutter_ai_images_app/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tflite/flutter_tflite.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Tflite.loadModel(
    /// This Code To Load Model
    model: "assets/model_unquant.tflite",
    labels: "assets/labels.txt",
  );


  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}