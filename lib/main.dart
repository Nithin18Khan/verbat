import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:verbat/model/extension/colors.dart';
import 'package:verbat/model/extension/config.dart';
import 'package:verbat/route.dart';
import 'package:verbat/viewmodel/styles/app_scroll_behaviour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  getHiveDataLocation();
  await Hive.openBox('farmer_data');
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(
    ProviderScope(child: MyApp()),
  );
}

void getHiveDataLocation() async {
  var directory = await getApplicationDocumentsDirectory();

  print("Hive data is saved at: ${directory.path}");
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final MainColors mainColors = MainColors();

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: MaterialApp(
      theme: mainColors.toThemeData(),
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: RouteGen.generateRoute,
    ));
  }

  String get initialRoute => Routes.loginScreen;
}
