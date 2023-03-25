import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationPickerFormField extends StatefulWidget {
  final String hintText;

  LocationPickerFormField({required this.hintText});

  @override
  _LocationPickerFormFieldState createState() =>
      _LocationPickerFormFieldState();
}

class _LocationPickerFormFieldState extends State<LocationPickerFormField> {
  TextEditingController _textEditingController = TextEditingController();
  Position? _position;

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _position = position;
      });
      String address = await _getAddressFromLatLng(position.latitude, position.longitude);
      _textEditingController.text = address;
    } catch (e) {
      print(e);
    }
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    String apiKey = 'YOUR_API_KEY_HERE';
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = json.decode(response.body);
      return decoded['results'][0]['formatted_address'];
    } else {
      throw Exception('Failed to get address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Select ${widget.hintText}',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        onTap: () {
          _getCurrentLocation();
        },
      ),
    );
  }
}
