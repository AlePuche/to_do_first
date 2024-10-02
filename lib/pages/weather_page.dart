import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('38c41484c252e1bbe9602e400afa7efe');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final _weather = await _weatherService.getWeather(cityName);
      setState(() {
        this._weather = _weather;
      });
    }
    catch (error) {
      print('Error fetching weather: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'Loading city...'),

            Text('${_weather?.temperature.round()} + ºC'),        ],
        )
      )
    );
  }
}

