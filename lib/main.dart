import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/main_page.dart';
import 'Provider/coin_data_page_provider.dart';
import 'Provider/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<CoinDataPageProvider>(
            create: (context) => CoinDataPageProvider()),
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: context.watch<ThemeProvider>().currentTheme,
      home: const MainPage(),
    );
  }
}
