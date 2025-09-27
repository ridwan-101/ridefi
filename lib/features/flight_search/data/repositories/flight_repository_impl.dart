import 'package:ridefi_assessment/features/flight_search/domain/entities/flight.dart';
import 'package:ridefi_assessment/features/flight_search/domain/repositories/flight_repository.dart';
import '../datasources/flight_remote_data_source.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;

  FlightRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Flight>> searchFlights({
    required String from,
    required String to,
    required DateTime date,
  }) async {
    final flights = await remoteDataSource.searchFlights(
      from: from,
      to: to,
      date: date,
    );
    return flights;
  }
}
