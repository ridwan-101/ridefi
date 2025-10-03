import 'package:flutter/material.dart';
import 'flight_results_page.dart';

class FlightSearchPage extends StatefulWidget {
  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  final _formKey = GlobalKey<FormState>();
  String _from = '';
  String _to = '';
  DateTime _departureDate = DateTime.now();
  String _tripType = 'One way';
  bool _directFlightsOnly = false;
  bool _includeNearbyAirports = false;
  String _travelClass = 'Economy';
  int _passengers = 1;

  final List<String> cities = [
    'JFK',
    'LAX',
    'ORD',
    'DFW',
    'DEN',
    'SFO',
    'SEA',
    'MIA',
    'ATL',
    'BOS',
  ];

  final List<String> tripTypes = ['One way', 'Round trip', 'Multi-City'];
  final List<String> travelClasses = [
    'Economy',
    'Premium Economy',
    'Business',
    'First'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _departureDate) {
      setState(() {
        _departureDate = picked;
      });
    }
  }

  void _searchFlights() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();

      // Navigate to flight results page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FlightResultsPage(
            from: _from,
            to: _to,
            date: _departureDate,
            passengers: _passengers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search Flights',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // From field
              _buildInputField(
                label: 'From',
                value: _from,
                onTap: () => _showCityPicker('From'),
                icon: Icons.swap_vert,
              ),
              SizedBox(height: 16),

              // To field
              _buildInputField(
                label: 'To',
                value: _to,
                onTap: () => _showCityPicker('To'),
                icon: Icons.swap_vert,
              ),
              SizedBox(height: 20),

              // Trip type selector
              _buildTripTypeSelector(),
              SizedBox(height: 20),

              // Departure date field
              _buildInputField(
                label: 'Departure Date',
                value: _formatDate(_departureDate),
                onTap: () => _selectDate(context),
                isDate: true,
              ),
              SizedBox(height: 30),

              // Optional Filters section
              Text(
                'Optional Filters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),

              // Direct flights toggle
              _buildToggleRow('Direct Flights Only', _directFlightsOnly,
                  (value) {
                setState(() {
                  _directFlightsOnly = value;
                });
              }),
              SizedBox(height: 16),

              // Include nearby airports toggle
              _buildToggleRow('Include Nearby Airports', _includeNearbyAirports,
                  (value) {
                setState(() {
                  _includeNearbyAirports = value;
                });
              }),
              SizedBox(height: 16),

              // Travel class
              _buildSelectionRow(
                  'Travel Class', _travelClass, () => _showTravelClassPicker()),
              SizedBox(height: 16),

              // Passengers
              _buildSelectionRow('Passengers', _passengers.toString(),
                  () => _showPassengersPicker()),
              SizedBox(height: 40),

              // Search button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _searchFlights,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Search Flights',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String value,
    required VoidCallback onTap,
    IconData? icon,
    bool isDate = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: value.isEmpty ? Colors.grey[600] : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (value.isNotEmpty)
                    Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
            if (icon != null)
              Icon(icon, color: Colors.grey[600], size: 20)
            else if (isDate)
              Icon(Icons.calendar_today, color: Colors.grey[600], size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTripTypeSelector() {
    return Row(
      children: tripTypes.map((type) {
        bool isSelected = _tripType == type;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _tripType = type;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[200] : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey[600],
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildToggleRow(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildSelectionRow(String title, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showCityPicker(String field) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select ${field}'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cities[index]),
                onTap: () {
                  setState(() {
                    if (field == 'From') {
                      _from = cities[index];
                    } else {
                      _to = cities[index];
                    }
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showTravelClassPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Travel Class'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: travelClasses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(travelClasses[index]),
                onTap: () {
                  setState(() {
                    _travelClass = travelClasses[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showPassengersPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Passengers'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Passengers'),
                Row(
                  children: [
                    IconButton(
                      onPressed: _passengers > 1
                          ? () {
                              setState(() {
                                _passengers--;
                              });
                            }
                          : null,
                      icon: Icon(Icons.remove),
                    ),
                    Text('$_passengers'),
                    IconButton(
                      onPressed: _passengers < 9
                          ? () {
                              setState(() {
                                _passengers++;
                              });
                            }
                          : null,
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}
