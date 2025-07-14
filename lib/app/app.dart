export 'constants/constants.dart';
export 'routes/routes.dart';
export 'themes/themes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/core.dart';
import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {},
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ACProvider()),
          ChangeNotifierProvider(create: (_) => ScheduleProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp(
              initialRoute: RouteNames.auth,
              onGenerateRoute: AppRouter.generateRoute,
              debugShowCheckedModeBanner: false,
              theme: themeProvider.themeData,
            );
          },
        ),
      ),
    );
  }
}
