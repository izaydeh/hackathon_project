import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_app/data_base.dart';
import 'package:project_app/pages/sub_pages_for_trans/add_trans_dialog.dart';
import 'package:project_app/pages/sub_pages_for_trans/card_display_page.dart';
import 'package:project_app/pages/sub_pages_for_trans/show_trip_details.dart';
import 'package:project_app/pages/sub_pages_for_trans/search_bar.dart';

class TransportPage extends StatefulWidget {
  const TransportPage({super.key});

  @override
  _TransportPageState createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> {
  final List<Map<String, String>> _cards = [];
  List<Map<String, String>> _filteredCards = [];
  final TextEditingController _searchController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadSavedTrips(); // Load trips from the database on initialization
  }

  // Load trips from the database
  Future<void> _loadSavedTrips() async {
    final List<Map<String, dynamic>> savedTrips =
        await _databaseHelper.fetchTrips();
    setState(() {
      _cards.clear();
      for (var trip in savedTrips) {
        _cards.add({
          'name': trip['name'],
          'pickUp': trip['pickUp'],
          'mobile': trip['mobile'],
          'timeToGo': trip['timeToGo'],
          'timeToLeave': trip['timeToLeave'],
        });
      }
      _filteredCards = List.from(_cards); // Initialize the filtered list
    });
  }

  // Save a new trip to the database and add it to the list
  Future<void> _addCard(String name, String pickUp, String mobile,
      String timeToGo, String timeToLeave) async {
    print(
        "Inserting trip into database: $name, $pickUp, $mobile, $timeToGo, $timeToLeave");

    await _databaseHelper.insertTrip({
      'name': name,
      'pickUp': pickUp,
      'mobile': mobile,
      'timeToGo': timeToGo,
      'timeToLeave': timeToLeave,
    });

    print("Trip inserted. Reloading all trips from database...");
    await _loadSavedTrips(); // Reload to ensure data persistence
  }

  void _filterCards(String query) {
    setState(() {
      _filteredCards = _cards
          .where((card) => card['pickUp']!
              .toLowerCase()
              .contains(query.toLowerCase())) // Search by pick-up point
          .toList();
      print("Filtered trips: $_filteredCards");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Banner with Circular Border at the bottom and Dark Overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/map_image.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Dark Overlay
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.black.withOpacity(0.4), // Darken the image
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Text(
                  "Find Your Partner",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.libreBaskerville(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Handle back navigation
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search Bar
          SearchB(
              searchController: _searchController, filterCards: _filterCards),
          const SizedBox(height: 16),

          // Card List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _filteredCards.length,
              itemBuilder: (context, index) {
                return TripCard(
                  card: _filteredCards[index],
                  onTap: () => _showTripDetails(_filteredCards[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTransDialog(addCard: _addCard),
          );
        },
        label: const Text(
          "Add Trip",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 166, 198, 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showTripDetails(Map<String, String> card) {
    showDialog(
      context: context,
      builder: (context) => TripDialog(card: card),
    );
  }
}
