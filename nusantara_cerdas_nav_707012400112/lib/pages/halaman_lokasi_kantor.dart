
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HalamanLokasiKantor extends StatefulWidget {
  const HalamanLokasiKantor({super.key});

  @override
  State<HalamanLokasiKantor> createState() =>
      _HalamanLokasiKantorState();
}

class _HalamanLokasiKantorState
    extends State<HalamanLokasiKantor> {
  static const LatLng _pusatPeta =
      LatLng(-6.9747, 107.6300);

  late final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('kantor_pusat'),
      position: LatLng(-6.9747, 107.6300),
      infoWindow: InfoWindow(
        title: 'Kantor Pelayanan Terpadu',
        snippet: 'Pusat pelayanan masyarakat',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor_kesehatan'),
      position: LatLng(-6.9685, 107.6250),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Kesehatan',
        snippet: 'Informasi layanan kesehatan',
      ),
    ),
    const Marker(
      markerId: MarkerId('kantor_perizinan'),
      position: LatLng(-6.9800, 107.6380),
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Perizinan',
        snippet: 'Informasi layanan perizinan',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF145DA0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(height: 8),
              Text(
                'Lokasi Kantor Pelayanan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Pilih penanda pada peta untuk melihat '
                'informasi kantor.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        Expanded(
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _pusatPeta,
              zoom: 13,
            ),
            markers: _markers,
            mapToolbarEnabled: true,
            zoomControlsEnabled: true,
          ),
        ),
      ],
    );
  }
}
