import 'package:diseno_app/src/models/layout_model.dart';
import 'package:diseno_app/src/pages/launcher_page.dart';
import 'package:diseno_app/src/pages/launcher_tablet_page.dart';
import 'package:diseno_app/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new ThemeChanger(2),
        ),
        ChangeNotifierProvider(
          create: (_) => new LayoutModel(),
        ),
      ],
      child: MyApp(),
    ));

// void main() => runApp(ChangeNotifierProvider(
//       create: (_) => ThemeChanger(2),
//       child: MyApp(),
//     ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return MaterialApp(
        theme: currentTheme,
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            // print('$orientation');

            final screenSize = MediaQuery.of(context).size;

            if (screenSize.width > 500) {
              return LauncherTabletPage();
            } else {
              return LauncherPage();
            }
            // return LauncherPage();
          },
        ));
  }
}
