import 'package:flutter/material.dart';

class FlightDetailsPage extends StatelessWidget {
  final String airline;
  final String flightNumber;
  final String aircraft;
  final String price;
  final String travelClass;
  final String duration;
  final String stops;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;

  const FlightDetailsPage({
    Key? key,
    required this.airline,
    required this.flightNumber,
    required this.aircraft,
    required this.price,
    required this.travelClass,
    required this.duration,
    required this.stops,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Flight Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flight Overview Section
                  _buildFlightOverview(),
                  SizedBox(height: 30),

                  // Flight Information Section
                  _buildSectionTitle('Flight Information'),
                  SizedBox(height: 16),
                  _buildInfoRow(Icons.chair, 'Seat Class', travelClass),
                  _buildInfoRow(Icons.schedule, 'Total Duration', duration),
                  _buildInfoRow(Icons.location_on, 'Layovers and Stops', stops),

                  SizedBox(height: 30),

                  // Baggage Information Section
                  _buildSectionTitle('Baggage Information'),
                  SizedBox(height: 16),
                  _buildInfoRow(
                      Icons.luggage, 'Checked Baggage', '1 checked bag'),
                  _buildInfoRow(
                      Icons.shopping_bag, 'Carry-on Baggage', '1 carry-on'),

                  SizedBox(height: 30),

                  // Policies Section
                  _buildSectionTitle('Policies'),
                  SizedBox(height: 16),
                  _buildInfoRow(Icons.description, 'Cancellation Policy', ''),
                  _buildInfoRow(Icons.description, 'Refund Policy', ''),

                  SizedBox(height: 30),

                  // Amenities Section
                  _buildSectionTitle('Amenities'),
                  SizedBox(height: 16),
                  _buildInfoRow(Icons.tv, 'In-flight Entertainment', ''),
                  _buildInfoRow(Icons.wifi, 'Wi-Fi', ''),
                  _buildInfoRow(Icons.restaurant, 'Meals', ''),

                  SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),

          // Continue to Book Button
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildFlightOverview() {
    return Column(
      children: [
        // Airline Information
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xFF1E3A8A),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.public,
                color: Color(0xFFFEF3C7),
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    airline,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Flight Number: $flightNumber',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        // Aircraft Type
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.flight,
                color: Colors.black,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aircraft Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    aircraft,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue[400],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Redirecting to booking...'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text(
              'Continue to Book',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
