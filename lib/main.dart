// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:klinikapp/ui/beranda.dart';
//import 'package:klinikapp/ui/beranda.dart';
import 'package:klinikapp/ui/login.dart';
import 'package:klinikapp/ui/pegawai_page.dart';
//import '/ui/pegawai_page.dart';
// import '/helpers/user_info.dart';
// import '/ui/beranda.dart';
// import '/ui/login.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   var token = await UserInfo().getToken();
//   print(token);
//   runApp(MaterialApp(
//     title: "Klinik APP",
//     debugShowCheckedModeBanner: false,
//     home: token == null ? Login() : Beranda(),
//   ));
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinik App',
      debugShowCheckedModeBanner: false,
      home: PegawaiPage(),
    );
  }
}
