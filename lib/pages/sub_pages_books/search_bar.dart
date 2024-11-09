import 'package:flutter/material.dart';

class SearchB extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) filterCards;

  const SearchB(
      {Key? key, required this.searchController, required this.filterCards})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: searchController,
        onChanged: filterCards,
        decoration: InputDecoration(
          labelText: 'Search for a book',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.brown,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.brown,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
