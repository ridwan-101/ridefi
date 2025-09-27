class Flight {
  final String? id;
  final String airline;
  final String flightNumber;
  final String departureAirport;
  final String arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final double price;
  final String? aircraft;
  final int? duration;
  final int? stops;
  final String? airlineLogo;

  Flight({
    this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    this.aircraft,
    this.duration,
    this.stops,
    this.airlineLogo,
  });

  String get durationFormatted {
    if (duration == null) return 'N/A';
    final hours = duration! ~/ 60;
    final minutes = duration! % 60;
    return '${hours}h ${minutes}m';
  }
}
