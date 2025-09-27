import 'package:flutter/material.dart';
import 'package:ridefi_assessment/features/flight_search/domain/entities/flight.dart';
import 'package:ridefi_assessment/features/flight_search/domain/usecases/search_flights.dart';

class FlightProvider with ChangeNotifier {
  final SearchFlights searchFlights;

  FlightProvider({required this.searchFlights});

  List<Flight> _flights = [];
  Flight? _selectedFlight;
  bool _isLoading = false;
  String? _error;

  List<Flight> get flights => _flights;
  Flight? get selectedFlight => _selectedFlight;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> search({
    required String from,
    required String to,
    required DateTime date,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _flights = await searchFlights(from: from, to: to, date: date);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _flights = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectFlight(Flight flight) {
    _selectedFlight = flight;
    notifyListeners();
  }

  void clearSelection() {
    _selectedFlight = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
