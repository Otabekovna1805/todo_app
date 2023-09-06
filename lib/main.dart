import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit/counter_cubit/counter_cubit.dart';
 import 'package:todo_app/cubit/mode/theme_mode_cubit.dart';
import 'package:todo_app/pages/counter_page.dart';
import 'package:todo_app/pages/detail_page.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/service/sql_service.dart';

import 'cubit/detail_cubit/detail_cubit.dart';
import 'cubit/home/home_cubit.dart';

final sql = SQLService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();

  final databasePath = await getDatabasesPath();
  final path = join(databasePath, "TodoApp");
  await sql.open(path);
  runApp(
    EasyLocalization(
      path: "assets/translation",
      supportedLocales: const [
        Locale("en", "US"),
        Locale("ru", "RU"),
        Locale("uz", "UZ"),
      ],
      fallbackLocale: const Locale("en", "US"),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
          BlocProvider<DetailCubit>(create: (context) => DetailCubit()),
          BlocProvider<ThemeModeCubit>(create: (context) => ThemeModeCubit()),
          BlocProvider<CounterCubitt>(create: (context) => CounterCubitt()),
        ],
         child: Builder(
           builder: (context) {
             return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light(useMaterial3: true),
                darkTheme: ThemeData.dark(useMaterial3: true),
                themeMode: context.watch<ThemeModeCubit>().state.mode,
                initialRoute: "/",
                routes: {
                  "/": (context) => const HomePage(),
                  "/detail": (context) => DetailPage(),
                  "/counter": (context) => const CounterPage(),
                },
              );
           }
         ),
    );
  }
}
