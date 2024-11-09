import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBookDialog extends StatefulWidget {
  final Function(String, String, String, String, String) addCard;

  const AddBookDialog({Key? key, required this.addCard}) : super(key: key);

  @override
  _AddBookDialogState createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add a Book",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 20),

              // Book Name
              _buildTextField("Name of the Book", _bookNameController),
              const SizedBox(height: 16),

              // Owner Name
              _buildTextField("Name of the Owner", _ownerNameController),
              const SizedBox(height: 16),

              // Mobile Number
              _buildTextField("Mobile Number of the Owner", _mobileController,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 16),

              // Faculty
              _buildTextField("Faculty", _facultyController),
              const SizedBox(height: 16),

              // Major
              _buildTextField("Major", _majorController),
              const SizedBox(height: 20),

              // Add Button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Add the book to the list if all fields are filled
                    if (_bookNameController.text.isNotEmpty &&
                        _ownerNameController.text.isNotEmpty &&
                        _mobileController.text.isNotEmpty &&
                        _facultyController.text.isNotEmpty &&
                        _majorController.text.isNotEmpty) {
                      widget.addCard(
                          _ownerNameController.text,
                          _bookNameController.text,
                          _mobileController.text,
                          _facultyController.text,
                          _majorController.text);
                      Navigator.of(context).pop();
                    } else {
                      // Show error message if any field is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please fill in all fields")),
                      );
                    }
                  },
                  child: Text(
                    "Add Book",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
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

  // Helper method for creating text fields
  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.brown),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
    );
  }
}
