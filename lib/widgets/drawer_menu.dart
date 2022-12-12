import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            _DrawerHeader(),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: const Text('Mis direcciones'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Mis pedidos'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Mis favoritos'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Invita a tus amigos'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.receipt_outlined),
              title: const Text('Mis cupones'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Mi cuenta'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Libro de reclamaciones'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  DrawerHeader _DrawerHeader() {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/logox1.png')),
      ),
    );
  }
}
