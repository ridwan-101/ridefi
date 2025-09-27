import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ridefi_assessment/features/flight_search/domain/entities/flight.dart';
import 'package:ridefi_assessment/features/flight_search/presentation/pages/flight_details_page.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;

  const FlightCard({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Icon(Icons.flight, color: Colors.blue),
        ),
        title: Text(
          flight.airline,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${flight.flightNumber} • ${flight.aircraft ?? "N/A"}'),
            SizedBox(height: 4),
            Row(
              children: [
                Text(DateFormat('HH:mm').format(flight.departureTime)),
                Icon(Icons.arrow_forward, size: 16),
                Text(DateFormat('HH:mm').format(flight.arrivalTime)),
                SizedBox(width: 8),
                Text('(${flight.durationFormatted})'),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${flight.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            if (flight.stops != null && flight.stops! > 0)
              Text(
                '${flight.stops} stop${flight.stops! > 1 ? 's' : ''}',
                style: TextStyle(fontSize: 12),
              ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlightDetailsPage(flight: flight),
            ),
          );
        },
      ),
    );
  }
}
