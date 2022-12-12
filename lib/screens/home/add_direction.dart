import 'package:app_delivery/providers/google_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AddDirection extends StatelessWidget {
  const AddDirection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final googleDirections = Provider.of<GoogleProvider>(context);
    googleDirections.setLatLon();
    // TextEditingController searchController = TextEditingController();
    return WillPopScope(
      onWillPop: () async {
        googleDirections.limpiarAutoComplete();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Nueva dirección',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                // controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Direccion o punto de referencia',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                style: const TextStyle(height: 0.8),
                onChanged: (value) => getDirections(value, context),
              ),
              if (googleDirections.nearDirections.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    // shrinkWrap: true,
                    itemCount: googleDirections.nearDirections.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            googleDirections.nearDirections[index].description),
                        onTap: () => abrirMapa(
                          context,
                          googleDirections.nearDirections[index].description,
                        ),
                      );
                    },
                  ),
                ),
              if (!googleDirections.nearDirections.isNotEmpty)
                const Text('No encontramos sugerencias'),
            ],
          ),
        ),
      ),
    );
  }

  getDirections(String value, BuildContext context) {
    final googleProvider = Provider.of<GoogleProvider>(context, listen: false);
    if (value.length > 3) {
      final ff = googleProvider.getGoogleDirecctions(value);
      print(googleProvider.nearDirections);
    } else {
      googleProvider.limpiarAutoComplete();
    }
  }

  abrirMapa(BuildContext context, String direction) async {
    final googleDirections =
        Provider.of<GoogleProvider>(context, listen: false);

    googleDirections.setDirection(direction);
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      Navigator.pushNamed(context, 'mapandroid');
    }
  }
}
