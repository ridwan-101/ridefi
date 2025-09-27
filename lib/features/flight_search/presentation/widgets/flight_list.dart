import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';
import 'flight_card.dart';

class FlightList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FlightProvider>(
      builder: (context, flightProvider, child) {
        if (flightProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (flightProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  'Error: ${flightProvider.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    flightProvider.clearError();
                  },
                  child: Text('Try Again'),
                ),
              ],
            ),
          );
        }

        if (flightProvider.flights.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flight, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No flights found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  'Try different search criteria',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: flightProvider.flights.length,
          itemBuilder: (context, index) {
            final flight = flightProvider.flights[index];
            return FlightCard(flight: flight);
          },
        );
      },
    );
  }
}
