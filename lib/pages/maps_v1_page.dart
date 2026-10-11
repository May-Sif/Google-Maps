import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_map/data_dummy.dart';
import 'package:google_map/map_type_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsV1Page extends StatefulWidget {
  const MapsV1Page({super.key});

  @override
  State<MapsV1Page> createState() => _MapV1PageState();
}

class _MapV1PageState extends State<MapsV1Page> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  double latitude = -6.198415050563709;
  double longitude = 106.79999550685112;
  var mapType = MapType.normal;
  String selectedFilter = "Semua"; 
  Set<Marker> get markers => getFilteredMarkers(selectedFilter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps V1"),
        actions: [
          PopupMenuButton(
            onSelected: onSelectedMapType,
            itemBuilder: (context) {
              return googleMapTypes.map(
                (typeGoogle) {
                  return PopupMenuItem (
                    value: typeGoogle.type,
                    child: Text(typeGoogle.type.name)
                  );
                },
              ).toList();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          // google maps
          _buildGoogleMaps(),

          // filter chips 
          _buildFilterChips(),
          
          // kartu tempat
          _buildDetailCard(),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    List<String> filters = ["Semua", "Wisata", "Ibadah", "Perkantoran"];
    
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            String filter = filters[index];
            bool isSelected = selectedFilter == filter;
            
            return FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  selectedFilter = filter;
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.blue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGoogleMaps() {
  return GoogleMap(
    key: ValueKey(selectedFilter), // INI PENTING! Memaksa rebuild saat filter berubah
    mapType: mapType,
    initialCameraPosition: CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 17
    ),
    onMapCreated: (GoogleMapController controller) {
      _controller.complete(controller);
    },
    markers: markers,
  );
}

  void onSelectedMapType(Type value) {
    setState(() {
      switch (value) {
        case Type.Normal:
          mapType = MapType.normal;
          break;
        case Type.Hybrid:
          mapType = MapType.hybrid;
          break;
        case Type.Terrain:
          mapType = MapType.terrain;
          break;
        case Type.Satellite:
          mapType = MapType.satellite;
          break;
        default:
      }
    });
  }

  _buildDetailCard() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
              "https://media.licdn.com/dms/image/v2/C510BAQFf34Qwa01mTA/company-logo_200_200/company-logo_200_200/0/1630588873540?e=2147483647&v=beta&t=DbQF4sV_SE9V9yJ0o7QQg3DeDi8unx1Am4dAjX3nvcc",
              "ImaStudio",
              -6.1952988,
              106.7926625
            ),
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSleGrQ4nlDTUSrTIqyit6FTnWelYWKmMOGoA&s",
              "Monas",
              -6.1753871,
              106.8249587
            ),
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
              "https://upload.wikimedia.org/wikipedia/id/2/25/Masjid_Istiqlal_-_Panoramio.jpg",
              "Masjid Istiqlal",
              -6.1702229,
              106.8293614
            ),
            const SizedBox(
              width: 10,
            ),
            _displayPlaceCard(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThMef75bMKuORdTV4ZF3A0TqkOqKeaz-b8wg&s",
              "Istana Merdeka",
              -6.1701238,
              106.8219881
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  _displayPlaceCard(String imageUrl, String name, double lat, double lgn) {
    return GestureDetector(
      onTap: () {
        _onClickPlaceCard(lat, lgn);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 90,
        margin: const EdgeInsets.only(bottom: 30),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          elevation: 10,
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "4.9",
                          style: TextStyle(fontSize: 15),
                        ),
                        Row(
                          children: stars(),
                        )
                      ],
                    ),
                    const Text(
                      "Indonesia \u00B7 Jakarta Barat",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Expanded(
                      child: Text(
                        "Closed \u00B7 Open 09.00 Monday",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> stars() {
    List<Widget> list1 = [];
    for (var i = 0; i < 5; i++) {
      list1.add(const Icon(
        Icons.star,
        color: Colors.orange,
        size: 15,
      ));
    }
    return list1;
  }

  void _onClickPlaceCard(double lat, double lgn) async {
    setState(() {
      latitude = lat;
      longitude = lgn;
    });

    GoogleMapController controller = await _controller.future;
    final cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 17,
      bearing: 192,
      tilt: 55
    );
    final cameraUpdate = CameraUpdate.newCameraPosition(
      cameraPosition
    );
    controller.animateCamera(cameraUpdate);
  }
}