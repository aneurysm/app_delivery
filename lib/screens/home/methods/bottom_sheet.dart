import 'package:flutter/material.dart';

showModalBottom(BuildContext context) {
  var tamano = MediaQuery.of(context).size;
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
    ),
    // isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(5),
        height: tamano.height * 0.4,
        child: Column(
          children: [
            const Icon(Icons.horizontal_rule),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15, right: 15),
              // height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Elige una direccion',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'adddirection'),
                    child: Row(
                      children: [
                        const Icon(Icons.add_location),
                        const SizedBox(width: 10),
                        SizedBox(
                            width: tamano.width - 80,
                            child: const Text('Nueva direccion'))
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
            // SizedBox(height: 125),
          ],
        ),
      );
    },
  );
}
