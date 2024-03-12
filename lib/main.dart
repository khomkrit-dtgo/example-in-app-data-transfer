import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    debugPrint('init State');
    controller.clearCache();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.addJavaScriptChannel('getUserProfile',
        onMessageReceived: (JavaScriptMessage message) {
      //
      debugPrint(message.message);

      try {
        final json = jsonDecode(message.message);
        debugPrint(json['clientId'].toString());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(json['clientId'])),
        );
      } catch (error) {
        debugPrint(error.toString());
        return;
      }

      final customerProfile = {
        "is_verified": true,
        "is_ownerships": true,
        "customer_id": "0011m00000SOVeaAAH",
        "uuid": "e19c13dc-cf6b-4793-8251-b04affb919d8",
        "titlename_th": "คุณ",
        "titlename_en": "Khun",
        "firstname_th": "Salah",
        "firstname_en": "Salah",
        "midname_th": "",
        "midname_en": "",
        "lastname_th": "Mohamed",
        "lastname_en": "Mohamed",
        "nickname_th": "",
        "nickname_en": "",
        "nickname_other": "",
        "phone_number": "0882535174",
        "phone_number_secondary": [],
        "id_card": "3100123460009",
        "passport_id": "",
        "email": "khomkrit_sr@dtgo.com",
        "email_secondary": [],
        "birthday": "1987-11-04",
        "gender": "Male",
        "nationality": "Thai",
        "wealth_status": "",
        "emergency_call_1": "",
        "emergency_call_2": "",
        "emergency_call_3": "",
        "emergency_firstname_1": "",
        "emergency_firstname_2": "",
        "emergency_firstname_3": "",
        "emergency_relation_1": "",
        "emergency_relation_2": "",
        "emergency_relation_3": "",
        "ownerships": [
          {
            "project_id": "WE",
            "company_id": "WS",
            "project_name_en": "Whizdom Essence Sukhumvit",
            "project_name_th": "วิสซ์ดอม เอสเซ้นส์ สุขุมวิท",
            "units": [
              {
                "unit_id": "1cc0671e-9b68-4661-bd6d-d41efdb231ce",
                "unit_number": "27AA10",
                "house_number": "5/361",
                "contract_id": "WS-BS/1805/000014",
                "resident_type": "Owner",
                "default_contract": true,
                "stage": "Contract",
                "is_active": true
              }
            ],
            "place_id": "13c93410-77a3-4e29-b1ad-849d3b760c7a"
          },
          {
            "project_id": "MO",
            "company_id": "IS",
            "project_name_en": "The ICONSIAM Superlux Residence",
            "project_name_th": "ดิ ไอคอนสยาม ซูเปอร์ลักซ์ เรสซิเดนซ์",
            "units": [
              {
                "unit_id": "68f26734-ed34-4db7-b297-f0387d919135",
                "unit_number": "09BA03",
                "house_number": "289/13",
                "contract_id": "",
                "resident_type": "Owner",
                "default_contract": true,
                "stage": "Transfer",
                "is_active": true
              }
            ],
            "place_id": "ac1fb8dd-ab3b-45f0-b01e-6891f3a33c76"
          }
        ]
      };

      final basicCustomerProfile = {
        "uuid": "e19c13dc-cf6b-4793-8251-b04affb919d8",
        "project_id": "WE",
        "project_name_en": "Whizdom Essence Sukhumvit",
        "project_name_th": "วิสซ์ดอม เอสเซ้นส์ สุขุมวิท",
        "resident_type": "Owner",
        "unit_number": "09BA03",
        "house_number": "289/13",
      };

      controller.runJavaScript(
        "window.currentUserProfile(${jsonEncode(basicCustomerProfile)});",
      );
    });

    controller.loadRequest(
      Uri.parse('https://809f-49-237-201-197.ngrok-free.app'),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: WebViewWidget(controller: controller)),
    );
  }
}
