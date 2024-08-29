import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '3e0e2a7481d5681e9fb3cffd90534f66';
const openweathermapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation(); //
    NetworkHelper networkHelper = NetworkHelper(
        '$openweathermapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherData = await networkHelper.getData();
    print('updated');
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openweathermapURL?q=$cityName&appid=$apikey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }
}
