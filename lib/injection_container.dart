import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:ridefi_assessment/features/flight_search/data/datasources/flight_remote_data_source.dart';
import 'package:ridefi_assessment/features/flight_search/data/repositories/flight_repository_impl.dart';
import 'package:ridefi_assessment/features/flight_search/domain/repositories/flight_repository.dart';
import 'package:ridefi_assessment/features/flight_search/domain/usecases/search_flights.dart';
import 'package:ridefi_assessment/features/flight_search/presentation/providers/flight_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Use cases
  sl.registerLazySingleton(() => SearchFlights(sl<FlightRepository>()));

  // Repository
  sl.registerLazySingleton<FlightRepository>(
    () => FlightRepositoryImpl(remoteDataSource: sl<FlightRemoteDataSource>()),
  );

  // Data sources
  sl.registerLazySingleton<FlightRemoteDataSource>(
    () => FlightRemoteDataSourceImpl(client: sl<http.Client>()),
  );
}

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<FlightProvider>(
    create: (_) => FlightProvider(searchFlights: sl<SearchFlights>()),
  ),
];
