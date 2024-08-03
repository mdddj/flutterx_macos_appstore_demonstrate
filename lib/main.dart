import 'package:dd_check_plugin/dd_check_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// todo: Set to FlutterX app foot bar IP and port
  DdCheckPlugin().init(dio,initHost: "192.168.199.81",port: 9999,version: DataFormatVersions.appleApp,defaultProjectName: "App");
  saveTestData();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CupertinoButton.filled(child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.link),
              Text("Test Dio Request"),
            ],
          ), onPressed: () {
            dio.get("https://google.com").catchError((_){});
            dio.get("https://baidu.com").catchError((_){});
          }),
          const SizedBox(height: 12)
        ],
      ),
    ));
  }
}


void saveTestData(){
  SharedPreferences.getInstance().then((value) {
    value.setString("Hi", "hello world");
  },);
}