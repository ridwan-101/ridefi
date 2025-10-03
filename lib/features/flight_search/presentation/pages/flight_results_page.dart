import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'flight_details_page.dart';

class FlightResultsPage extends StatefulWidget {
  final String from;
  final String to;
  final DateTime date;
  final int passengers;

  const FlightResultsPage({
    Key? key,
    required this.from,
    required this.to,
    required this.date,
    required this.passengers,
  }) : super(key: key);

  @override
  _FlightResultsPageState createState() => _FlightResultsPageState();
}

class _FlightResultsPageState extends State<FlightResultsPage> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  // Sample flight data
  final List<List<FlightResult>> flightPages = [
    [
      FlightResult(
        airline: 'Alaska',
        price: 320,
        travelClass: 'Economy',
        stops: 1,
        stopsText: '1 Stop',
        departureTime: '1:00 PM',
        arrivalTime: '4:00 PM',
        duration: '6h 0m',
        color: Color(0xFF2D5A6B),
      ),
      FlightResult(
        airline: 'American',
        price: 245,
        travelClass: 'Economy',
        stops: 0,
        stopsText: 'Non-stop',
        departureTime: '12:00 PM',
        arrivalTime: '3:30 PM',
        duration: '5h 30m',
        color: Color(0xFFF5F5F5),
        textColor: Colors.black,
      ),
      FlightResult(
        airline: 'United',
        price: 380,
        travelClass: 'Economy',
        stops: 1,
        stopsText: '1 Stop',
        departureTime: '2:15 PM',
        arrivalTime: '5:45 PM',
        duration: '6h 30m',
        color: Color(0xFF4A90A4),
      ),
    ],
    [
      FlightResult(
        airline: 'Delta',
        price: 295,
        travelClass: 'Economy',
        stops: 0,
        stopsText: 'Non-stop',
        departureTime: '8:30 AM',
        arrivalTime: '12:00 PM',
        duration: '5h 30m',
        color: Color(0xFF3B7B8E),
      ),
      FlightResult(
        airline: 'JetBlue',
        price: 265,
        travelClass: 'Economy',
        stops: 1,
        stopsText: '1 Stop',
        departureTime: '10:45 AM',
        arrivalTime: '2:15 PM',
        duration: '5h 30m',
        color: Color(0xFF2D5A6B),
      ),
      FlightResult(
        airline: 'Southwest',
        price: 220,
        travelClass: 'Economy',
        stops: 0,
        stopsText: 'Non-stop',
        departureTime: '7:00 AM',
        arrivalTime: '10:30 AM',
        duration: '5h 30m',
        color: Color(0xFFE8F4F8),
        textColor: Colors.black,
      ),
    ],
    [
      FlightResult(
        airline: 'Spirit',
        price: 180,
        travelClass: 'Economy',
        stops: 1,
        stopsText: '1 Stop',
        departureTime: '11:20 AM',
        arrivalTime: '3:50 PM',
        duration: '6h 30m',
        color: Color(0xFF4A90A4),
      ),
      FlightResult(
        airline: 'Frontier',
        price: 195,
        travelClass: 'Economy',
        stops: 0,
        stopsText: 'Non-stop',
        departureTime: '4:15 PM',
        arrivalTime: '7:45 PM',
        duration: '5h 30m',
        color: Color(0xFF3B7B8E),
      ),
      FlightResult(
        airline: 'Alaska',
        price: 310,
        travelClass: 'Economy',
        stops: 1,
        stopsText: '1 Stop',
        departureTime: '3:30 PM',
        arrivalTime: '7:00 PM',
        duration: '6h 30m',
        color: Color(0xFF2D5A6B),
      ),
    ],
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
          'Flights',
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
          // Search Parameters Section
          _buildSearchParameters(),

          // Sort & Filter Section
          _buildSortFilterSection(),

          // Flight Results
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: flightPages.length,
              itemBuilder: (context, pageIndex) {
                return _buildFlightPage(flightPages[pageIndex]);
              },
            ),
          ),

          // Page Indicators
          _buildPageIndicators(),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchParameters() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              // From
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.from,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      _getCityName(widget.from),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[300],
                      ),
                    ),
                  ],
                ),
              ),

              // Swap button
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.flight,
                  color: Colors.black,
                  size: 20,
                ),
              ),

              // To
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.to,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      _getCityName(widget.to),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[300],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Date and passengers
          Row(
            children: [
              Text(
                DateFormat('EEE, MMM d').format(widget.date),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' • ${widget.passengers} ${widget.passengers == 1 ? 'Adult' : 'Adults'}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSortFilterSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _showSortOptions,
            child: Text(
              'Sort & Filter',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: _showFilterOptions,
            child: Icon(
              Icons.tune,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightPage(List<FlightResult> flights) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: flights.map((flight) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  right: flights.indexOf(flight) < flights.length - 1 ? 16 : 0),
              child: _buildFlightCard(flight),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFlightCard(FlightResult flight) {
    return GestureDetector(
      onTap: () {
        // Navigate to flight details
        _showFlightDetails(flight);
      },
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          color: flight.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Price and class badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${flight.price} • ${flight.travelClass}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              Spacer(),

              // Airline name
              Text(
                flight.airline,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: flight.textColor ?? Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 8),

              // Stops
              Text(
                flight.stopsText,
                style: TextStyle(
                  fontSize: 14,
                  color: flight.textColor ?? Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 4),

              // Flight details
              Text(
                '${widget.from} ${flight.departureTime} • ${widget.to} ${flight.arrivalTime} • ${flight.duration}',
                style: TextStyle(
                  fontSize: 12,
                  color: flight.textColor ?? Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(flightPages.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage ? Colors.blue : Colors.grey[300],
          ),
        );
      }),
    );
  }

  String _getCityName(String airportCode) {
    final cityMap = {
      'JFK': 'New York',
      'LAX': 'Los Angeles',
      'ORD': 'Chicago',
      'DFW': 'Dallas',
      'DEN': 'Denver',
      'SFO': 'San Francisco',
      'SEA': 'Seattle',
      'MIA': 'Miami',
      'ATL': 'Atlanta',
      'BOS': 'Boston',
    };
    return cityMap[airportCode] ?? airportCode;
  }

  void _showFlightDetails(FlightResult flight) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FlightDetailsPage(
          airline: flight.airline,
          flightNumber: '${flight.airline.substring(0, 2).toUpperCase()} 123',
          aircraft: 'Boeing 737',
          price: flight.price.toString(),
          travelClass: flight.travelClass,
          duration: flight.duration,
          stops: flight.stopsText,
          from: widget.from,
          to: widget.to,
          departureTime: flight.departureTime,
          arrivalTime: flight.arrivalTime,
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort by',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildSortOption('Price (Low to High)', () {
              Navigator.pop(context);
              _sortFlightsByPrice();
            }),
            _buildSortOption('Price (High to Low)', () {
              Navigator.pop(context);
              _sortFlightsByPriceDesc();
            }),
            _buildSortOption('Duration (Shortest)', () {
              Navigator.pop(context);
              _sortFlightsByDuration();
            }),
            _buildSortOption('Departure Time', () {
              Navigator.pop(context);
              _sortFlightsByDeparture();
            }),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter by',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildFilterOption('Non-stop flights only', () {
              Navigator.pop(context);
              _filterNonStop();
            }),
            _buildFilterOption('1 stop or fewer', () {
              Navigator.pop(context);
              _filterOneStopOrLess();
            }),
            _buildFilterOption('Under \$300', () {
              Navigator.pop(context);
              _filterUnder300();
            }),
            _buildFilterOption('Clear all filters', () {
              Navigator.pop(context);
              _clearFilters();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildFilterOption(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }

  void _sortFlightsByPrice() {
    setState(() {
      for (int i = 0; i < flightPages.length; i++) {
        flightPages[i].sort((a, b) => a.price.compareTo(b.price));
      }
    });
  }

  void _sortFlightsByPriceDesc() {
    setState(() {
      for (int i = 0; i < flightPages.length; i++) {
        flightPages[i].sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  void _sortFlightsByDuration() {
    setState(() {
      for (int i = 0; i < flightPages.length; i++) {
        flightPages[i].sort((a, b) => a.duration.compareTo(b.duration));
      }
    });
  }

  void _sortFlightsByDeparture() {
    setState(() {
      for (int i = 0; i < flightPages.length; i++) {
        flightPages[i]
            .sort((a, b) => a.departureTime.compareTo(b.departureTime));
      }
    });
  }

  void _filterNonStop() {
    setState(() {
      for (int i = 0; i < flightPages.length; i++) {
        flightPages[i].removeWhere((flight) => flight.stops > 0);
      }
    });
  }

  void _filterOneStopOrLess() {
    setState(() {
      for (int i = 0; i < flightPages.length; i++) {
        flightPages[i].removeWhere((flight) => flight.stops > 1);
      }
    });
  }

  void _filterUnder300() {
    setState(() {
      for (int i = 0; i < flightPages.length; i++) {
        flightPages[i].removeWhere((flight) => flight.price >= 300);
      }
    });
  }

  void _clearFilters() {
    setState(() {
      // Reset to original data
      flightPages.clear();
      flightPages.addAll([
        [
          FlightResult(
            airline: 'Alaska',
            price: 320,
            travelClass: 'Economy',
            stops: 1,
            stopsText: '1 Stop',
            departureTime: '1:00 PM',
            arrivalTime: '4:00 PM',
            duration: '6h 0m',
            color: Color(0xFF2D5A6B),
          ),
          FlightResult(
            airline: 'American',
            price: 245,
            travelClass: 'Economy',
            stops: 0,
            stopsText: 'Non-stop',
            departureTime: '12:00 PM',
            arrivalTime: '3:30 PM',
            duration: '5h 30m',
            color: Color(0xFFF5F5F5),
            textColor: Colors.black,
          ),
          FlightResult(
            airline: 'United',
            price: 380,
            travelClass: 'Economy',
            stops: 1,
            stopsText: '1 Stop',
            departureTime: '2:15 PM',
            arrivalTime: '5:45 PM',
            duration: '6h 30m',
            color: Color(0xFF4A90A4),
          ),
        ],
        [
          FlightResult(
            airline: 'Delta',
            price: 295,
            travelClass: 'Economy',
            stops: 0,
            stopsText: 'Non-stop',
            departureTime: '8:30 AM',
            arrivalTime: '12:00 PM',
            duration: '5h 30m',
            color: Color(0xFF3B7B8E),
          ),
          FlightResult(
            airline: 'JetBlue',
            price: 265,
            travelClass: 'Economy',
            stops: 1,
            stopsText: '1 Stop',
            departureTime: '10:45 AM',
            arrivalTime: '2:15 PM',
            duration: '5h 30m',
            color: Color(0xFF2D5A6B),
          ),
          FlightResult(
            airline: 'Southwest',
            price: 220,
            travelClass: 'Economy',
            stops: 0,
            stopsText: 'Non-stop',
            departureTime: '7:00 AM',
            arrivalTime: '10:30 AM',
            duration: '5h 30m',
            color: Color(0xFFE8F4F8),
            textColor: Colors.black,
          ),
        ],
        [
          FlightResult(
            airline: 'Spirit',
            price: 180,
            travelClass: 'Economy',
            stops: 1,
            stopsText: '1 Stop',
            departureTime: '11:20 AM',
            arrivalTime: '3:50 PM',
            duration: '6h 30m',
            color: Color(0xFF4A90A4),
          ),
          FlightResult(
            airline: 'Frontier',
            price: 195,
            travelClass: 'Economy',
            stops: 0,
            stopsText: 'Non-stop',
            departureTime: '4:15 PM',
            arrivalTime: '7:45 PM',
            duration: '5h 30m',
            color: Color(0xFF3B7B8E),
          ),
          FlightResult(
            airline: 'Alaska',
            price: 310,
            travelClass: 'Economy',
            stops: 1,
            stopsText: '1 Stop',
            departureTime: '3:30 PM',
            arrivalTime: '7:00 PM',
            duration: '6h 30m',
            color: Color(0xFF2D5A6B),
          ),
        ],
      ]);
    });
  }
}

class FlightResult {
  final String airline;
  final int price;
  final String travelClass;
  final int stops;
  final String stopsText;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final Color color;
  final Color? textColor;

  FlightResult({
    required this.airline,
    required this.price,
    required this.travelClass,
    required this.stops,
    required this.stopsText,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.color,
    this.textColor,
  });
}
