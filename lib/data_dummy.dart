import 'package:google_maps_flutter/google_maps_flutter.dart';

// Marker dengan kategori
class MarkerData {
  final Marker marker;
  final String category; // "Kuliner", "Wisata", "Ibadah", "Perkantoran"
  
  MarkerData({required this.marker, required this.category});
}

// Semua marker data
List<MarkerData> allMarkersData = [
  MarkerData(
    marker: Marker(
      markerId: const MarkerId("imaStudio"),
      position: const LatLng(-6.195303, 106.7926562),
      infoWindow: const InfoWindow(title: "ImaStudio", snippet: "Training Mobile App"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
    ),
    category: "Perkantoran",
  ),
  MarkerData(
    marker: Marker(
      markerId: const MarkerId("monas"),
      position: const LatLng(-6.1753871, 106.8249587),
      infoWindow: const InfoWindow(title: "Monumen Nasional", snippet: "Wisata Sejarah"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
    ),
    category: "Wisata",
  ),
  MarkerData(
    marker: Marker(
      markerId: const MarkerId("Masjid Istiqlal"),
      position: const LatLng(-6.1699883, 106.8287337),
      infoWindow: const InfoWindow(title: "Masjid Istiqlal", snippet: "Masjid Terbesar se-Asia Tenggara"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
    ),
    category: "Ibadah",
  ),
  MarkerData(
    marker: Marker(
      markerId: const MarkerId("Istana Merdeka"),
      position: const LatLng(-6.1701812, 106.8219803),
      infoWindow: const InfoWindow(title: "Istana Merdeka", snippet: "Istana Kepresidenan"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
    ),
    category: "Perkantoran",
  ),
];

// Function untuk get marker berdasarkan filter
Set<Marker> getFilteredMarkers(String filter) {
  if (filter == "Semua") {
    return allMarkersData.map((e) => e.marker).toSet();
  }
  return allMarkersData
      .where((e) => e.category == filter)
      .map((e) => e.marker)
      .toSet();
}