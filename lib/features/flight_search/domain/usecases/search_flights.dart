import '../entities/flight.dart';
import '../repositories/flight_repository.dart';

class SearchFlights {
  final FlightRepository repository;

  SearchFlights(this.repository);

  Future<List<Flight>> call({
    required String from,
    required String to,
    required DateTime date,
  }) async {
    return await repository.searchFlights(from: from, to: to, date: date);
  }
}
