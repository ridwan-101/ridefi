import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ridefi_assessment/features/flight_search/domain/entities/flight.dart';

class FlightDetailsPage extends StatelessWidget {
  final Flight flight;

  const FlightDetailsPage({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            SizedBox(height: 20),
            _buildFlightTimeline(),
            SizedBox(height: 20),
            _buildPriceCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Icon(Icons.flight, color: Colors.blue),
              ),
              title: Text(
                flight.airline,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('Flight ${flight.flightNumber}'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.airplanemode_active),
              title: Text('Aircraft'),
              trailing: Text(flight.aircraft ?? 'N/A'),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Duration'),
              trailing: Text(flight.durationFormatted),
            ),
            ListTile(
              leading: Icon(Icons.layers),
              title: Text('Stops'),
              trailing: Text(flight.stops?.toString() ?? '0'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightTimeline() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTimelineItem(
              'Departure',
              flight.departureAirport,
              DateFormat('EEE, MMM d, y • HH:mm').format(flight.departureTime),
              Icons.flight_takeoff,
              Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            _buildTimelineItem(
              'Arrival',
              flight.arrivalAirport,
              DateFormat('EEE, MMM d, y • HH:mm').format(flight.arrivalTime),
              Icons.flight_land,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    String title,
    String subtitle,
    String time,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle),
            ],
          ),
        ),
        Text(time, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildPriceCard() {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${flight.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
