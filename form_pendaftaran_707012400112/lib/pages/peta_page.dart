
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetaPage extends StatelessWidget {
  const PetaPage({super.key});

  static const LatLng lokasiKegiatan = LatLng(
    -6.9747,
    107.6305,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Lokasi Kegiatan'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: lokasiKegiatan,
          zoom: 15,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('lokasi_kegiatan'),
            position: lokasiKegiatan,
            infoWindow: InfoWindow(
              title: 'Lokasi Kegiatan',
              snippet: 'Area Telkom University',
            ),
          ),
        },
      ),
    );
  }
}
