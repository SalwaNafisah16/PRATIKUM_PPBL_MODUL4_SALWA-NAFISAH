import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorit_model.dart';
import 'models/pengajuan_model.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoritModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PengajuanModel(),
        ),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusantara Cerdas Mobile',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),

      initialRoute: AppRoutes.beranda,
      routes: AppRoutes.daftarRoute(),
      onGenerateRoute: AppRoutes.bentukRoute,
      onUnknownRoute: AppRoutes.routeTidakDikenal,
    );
  }
}