import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_app/pages/sub_pages_books/add_book_dialog.dart';
import 'package:project_app/pages/sub_pages_books/card_display_page.dart';
import 'package:project_app/pages/sub_pages_books/show_book_details.dart';
import 'package:project_app/pages/sub_pages_books/search_bar.dart';

class UsedBooksPage extends StatefulWidget {
  const UsedBooksPage({super.key});

  @override
  _UsedBooksPageState createState() => _UsedBooksPageState();
}

class _UsedBooksPageState extends State<UsedBooksPage> {
  final List<Map<String, String>> _cards = [];
  List<Map<String, String>> _filteredCards = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCards = _cards;
  }

  void _addCard(
      String name, String book, String mobile, String faculty, String major) {
    setState(() {
      _cards.add({
        'name': name, // Owner name
        'book': book, // Book title
        'mobile': mobile, // Owner's mobile number
        'faculty': faculty, // Owner's faculty
        'major': major, // Owner's major
      });
      _filteredCards = _cards; // Reset the filter when a new book is added
    });
  }

  void _filterCards(String query) {
    setState(() {
      _filteredCards = _cards
          .where((card) => card['book']!
              .toLowerCase()
              .contains(query.toLowerCase())) // Search by book title
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      image: AssetImage("images/books.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.black.withOpacity(0.4),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Text(
                  "Find Your Needed Book",
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SearchB(
              searchController: _searchController, filterCards: _filterCards),
          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _filteredCards.length,
              itemBuilder: (context, index) {
                return BookCard(
                  card: _filteredCards[index],
                  onTap: () => _showBookDetails(_filteredCards[index]),
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
            builder: (context) => AddBookDialog(addCard: _addCard),
          );
        },
        label: const Text(
          "Add A Book",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.brown,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showBookDetails(Map<String, String> card) {
    showDialog(
      context: context,
      builder: (context) => BookDialog(card: card),
    );
  }
}
