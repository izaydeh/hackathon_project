import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    //await deleteDatabase(path);

    return openDatabase(
      path,
      onCreate: (db, version) async {
        // Create users table
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
        );
        // Insert a test user
        await db.insert('users', {'username': 'user', 'password': 'pass'});

        // Create books table
        await db.execute('''
          CREATE TABLE books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            book TEXT,
            mobile TEXT,
            faculty TEXT,
            major TEXT
          )
        ''');

        // Create trips table
        await db.execute('''
          CREATE TABLE trips (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            pickUp TEXT,
            mobile TEXT,
            timeToGo TEXT,
            timeToLeave TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Existing method to get a user by username
  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.query('users', where: 'username = ?', whereArgs: [username]);
    return result.isNotEmpty ? result.first : null;
  }

  // New method to insert a book entry
  Future<void> insertBook(Map<String, String> book) async {
    final db = await database;
    await db.insert('books', book);
  }

  // New method to fetch all books
  Future<List<Map<String, dynamic>>> getAllBooks() async {
    final db = await database;
    return await db.query('books');
  }

  // Method to insert a new trip
  Future<void> insertTrip(Map<String, String> trip) async {
    final db = await database;
    await db.insert('trips', trip);
  }

  // Method to fetch all trips
  Future<List<Map<String, dynamic>>> fetchTrips() async {
    final db = await database;
    return await db.query('trips');
  }
}
