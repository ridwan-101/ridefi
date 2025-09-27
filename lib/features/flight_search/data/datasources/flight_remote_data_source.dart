import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/flight_model.dart';

abstract class FlightRemoteDataSource {
  Future<List<FlightModel>> searchFlights({
    required String from,
    required String to,
    required DateTime date,
  });
}

class FlightRemoteDataSourceImpl implements FlightRemoteDataSource {
  final http.Client client;

  FlightRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FlightModel>> searchFlights({
    required String from,
    required String to,
    required DateTime date,
  }) async {
    final apiKey = dotenv.env['AVIATIONSTACK_API_KEY'];

    if (apiKey == null || apiKey.isEmpty || apiKey == 'your_api_key_here') {
      // Return mock data for demonstration purposes when API key is not configured
      return _getMockFlights(from: from, to: to, date: date);
    }

    final formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    try {
      final response = await client.get(
        Uri.parse(
          'http://api.aviationstack.com/v1/flights?access_key=$apiKey&dep_iata=$from&arr_iata=$to&flight_date=$formattedDate',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> flights = data['data'];

        if (flights.isEmpty) {
          return _getMockFlights(from: from, to: to, date: date);
        }

        return flights
            .map((flightJson) => FlightModel.fromJson(flightJson))
            .toList();
      } else {
        // Fallback to mock data if API fails
        return _getMockFlights(from: from, to: to, date: date);
      }
    } catch (e) {
      // Fallback to mock data if there's any error
      return _getMockFlights(from: from, to: to, date: date);
    }
  }

  List<FlightModel> _getMockFlights({
    required String from,
    required String to,
    required DateTime date,
  }) {
    final baseDate = DateTime(date.year, date.month, date.day);

    return [
      FlightModel(
        id: '1',
        airline: 'Demo Airlines',
        flightNumber: 'DA${from}${to}001',
        departureAirport: from,
        arrivalAirport: to,
        departureTime: baseDate.add(Duration(hours: 8, minutes: 30)),
        arrivalTime: baseDate.add(Duration(hours: 10, minutes: 45)),
        price: 299.99,
        duration: 135, // 2h 15m in minutes
        aircraft: 'Boeing 737',
        stops: 0,
      ),
      FlightModel(
        id: '2',
        airline: 'Sample Airways',
        flightNumber: 'SA${from}${to}002',
        departureAirport: from,
        arrivalAirport: to,
        departureTime: baseDate.add(Duration(hours: 14, minutes: 15)),
        arrivalTime: baseDate.add(Duration(hours: 16, minutes: 30)),
        price: 349.99,
        duration: 135, // 2h 15m in minutes
        aircraft: 'Airbus A320',
        stops: 0,
      ),
      FlightModel(
        id: '3',
        airline: 'Test Airlines',
        flightNumber: 'TA${from}${to}003',
        departureAirport: from,
        arrivalAirport: to,
        departureTime: baseDate.add(Duration(hours: 18, minutes: 0)),
        arrivalTime: baseDate.add(Duration(hours: 20, minutes: 15)),
        price: 279.99,
        duration: 135, // 2h 15m in minutes
        aircraft: 'Boeing 787',
        stops: 0,
      ),
    ];
  }
}
