import 'package:ridefi_assessment/features/flight_search/domain/entities/flight.dart';

class FlightModel extends Flight {
  FlightModel({
    required super.airline,
    required super.flightNumber,
    required super.departureAirport,
    required super.arrivalAirport,
    required super.departureTime,
    required super.arrivalTime,
    required super.price,
    super.id,
    super.aircraft,
    super.duration,
    super.stops,
    super.airlineLogo,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      id: json['id']?.toString(),
      airline: json['airline']['name'] ?? 'Unknown Airline',
      flightNumber: json['flight']['number']?.toString() ?? 'N/A',
      departureAirport: json['departure']['airport'] ?? 'Unknown Airport',
      arrivalAirport: json['arrival']['airport'] ?? 'Unknown Airport',
      departureTime: DateTime.parse(json['departure']['scheduled']),
      arrivalTime: DateTime.parse(json['arrival']['scheduled']),
      price: (json['price'] ?? 0.0).toDouble(),
      aircraft: json['aircraft']['model']?.toString(),
      duration: json['duration']?.toInt(),
      stops: json['stops']?.toInt(),
      airlineLogo: json['airline']['logo'],
    );
  }
}
