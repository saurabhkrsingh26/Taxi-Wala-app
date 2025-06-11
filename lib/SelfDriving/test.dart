import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

void main() {
  runApp(test());
}

class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Picker Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Location Picker Demo'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: LocationTextField(),
          ),
        ),
      ),
    );
  }
}

class LocationTextField extends StatefulWidget {
  @override
  _LocationTextFieldState createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      onTap: () async {
        // Show Google Places Autocomplete widget
        Prediction? prediction = await PlacesAutocomplete.show(
          context: context,
          apiKey: 'YOUR_GOOGLE_PLACES_API_KEY',
          language: 'en',
        );

        // Retrieve selected place and set the text field value
        if (prediction != null) {
          PlacesDetailsResponse details = await GoogleMapsPlaces(apiKey: 'YOUR_GOOGLE_PLACES_API_KEY')
              .getDetailsByPlaceId(prediction.placeId!);
          setState(() {
            _controller.text = details.result!.formattedAddress!;
          });
        }
      },
      decoration: InputDecoration(
        labelText: 'Location',
        hintText: 'Enter location',
        prefixIcon: Icon(Icons.location_on),
      ),
    );
  }
}
