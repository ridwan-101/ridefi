import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ridefi_assessment/features/flight_search/domain/entities/flight.dart';
import 'package:ridefi_assessment/features/flight_search/domain/repositories/flight_repository.dart';
import 'package:ridefi_assessment/features/flight_search/domain/usecases/search_flights.dart';

class MockFlightRepository extends Mock implements FlightRepository {}

void main() {
  late SearchFlights usecase;
  late MockFlightRepository mockFlightRepository;

  setUp(() {
    mockFlightRepository = MockFlightRepository();
    usecase = SearchFlights(mockFlightRepository);
  });

  final tFlights = [
    Flight(
      airline: 'Test Airline',
      flightNumber: 'TA123',
      departureAirport: 'JFK',
      arrivalAirport: 'LAX',
      departureTime: DateTime.now(),
      arrivalTime: DateTime.now().add(Duration(hours: 5)),
      price: 299.99,
    ),
  ];

  test('should get flights from the repository', () async {
    // arrange
    final testDate = DateTime.now();
    when(
      mockFlightRepository.searchFlights(
        from: 'JFK',
        to: 'LAX',
        date: testDate,
      ),
    ).thenAnswer((_) async => tFlights);

    // act
    final result = await usecase(from: 'JFK', to: 'LAX', date: testDate);

    // assert
    expect(result, equals(tFlights));
    verify(
      mockFlightRepository.searchFlights(
        from: 'JFK',
        to: 'LAX',
        date: testDate,
      ),
    );
    verifyNoMoreInteractions(mockFlightRepository);
  });
}
