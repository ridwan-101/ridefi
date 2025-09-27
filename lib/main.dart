import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:ridefi_assessment/injection_container.dart' as di;
import 'package:ridefi_assessment/features/flight_search/presentation/pages/flight_search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Warning: .env file not found. Using default values.");
  }
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: di.providers,
      child: MaterialApp(
        title: 'Flight Search App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FlightSearchPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
