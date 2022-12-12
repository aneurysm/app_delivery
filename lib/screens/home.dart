import 'package:app_delivery/screens/home/methods/bottom_sheet.dart';
import 'package:app_delivery/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // Future<void> requestPermission() async {
  //   await Permission.location.request();
  // }

  @override
  Widget build(BuildContext context) {
    // requestPermission();
    final _screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: EdgeInsets.only(left: _screensize.width * 0.11),
            // padding: EdgeInsets.symmetric(horizontal: _screensize.width * 0.15),
            child: GestureDetector(
              child: Row(
                children: const [
                  Text('Nueva direccion'),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
              onTap: () => showModalBottom(context),
            )),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none))
        ],
      ),
      drawer: const SideMenu(),
      body: Column(
          // children: [
          //   ElevatedButton(
          //     onPressed: () {
          //       showModalBottom(context);
          //     },
          //     child: const Text("Show Bottom Sheet"),
          //   )
          // ],
          ),
    );
  }
}
