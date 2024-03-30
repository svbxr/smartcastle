import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_6/weather_api.dart';
import 'package:http/http.dart' as http;

class WeatherInfo extends StatefulWidget {
  String cityName;
  WeatherInfo({super.key, required this.cityName});

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  dynamic temp = 0.0;
  String status = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  Future getWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${widget.cityName}&appid=1369dd6b5ae78fc9952261ab9aa236b4&units=metric'));

    if (response.statusCode == 200) {
      WeatherModal weatherModal =
          WeatherModal.fromJson(jsonDecode(response.body));

      setState(() {
        temp = weatherModal.main!.temp!;
        status = weatherModal.weather!.first.main!;
      });
    } else if (response.statusCode == 404){

      setState(() {
        temp = jsonDecode(response.body)['cod'];
        status = jsonDecode(response.body)['message'];
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.cityName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '$temp°',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              status,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
