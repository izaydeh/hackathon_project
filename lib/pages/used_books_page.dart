import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_app/data_base.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    print("initState called in UsedBooksPage"); // Initial debug print
    _loadSavedBooks(); // Load books from the database on initialization
  }

  // Load books from the database
  Future<void> _loadSavedBooks() async {
    print("Loading saved books...");
    final List<Map<String, dynamic>> savedBooks =
        await _databaseHelper.getAllBooks();
    print("Saved books retrieved: $savedBooks");

    setState(() {
      _cards.clear();
      for (var book in savedBooks) {
        _cards.add({
          'name': book['name'],
          'book': book['book'],
          'mobile': book['mobile'],
          'faculty': book['faculty'],
          'major': book['major'],
        });
      }
      _filteredCards = List.from(_cards);
      print("Cards loaded into _cards: $_cards");
    });
  }

  // Save a new book to the database and add it to the list
  Future<void> _addCard(String name, String book, String mobile, String faculty,
      String major) async {
    print(
        "Inserting book into database: $name, $book, $mobile, $faculty, $major");

    await _databaseHelper.insertBook({
      'name': name,
      'book': book,
      'mobile': mobile,
      'faculty': faculty,
      'major': major,
    });

    print("Book inserted. Reloading all books from database...");
    await _loadSavedBooks(); // Reload to ensure data persistence
  }

  void _filterCards(String query) {
    setState(() {
      _filteredCards = _cards
          .where((card) => card['book']!
              .toLowerCase()
              .contains(query.toLowerCase())) // Search by book title
          .toList();
      print("Filtered cards: $_filteredCards");
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
