import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTransDialog extends StatefulWidget {
  final Function(String, String, String, String, String) addCard;

  const AddTransDialog({Key? key, required this.addCard}) : super(key: key);

  @override
  _AddTransDialogState createState() => _AddTransDialogState();
}

class _AddTransDialogState extends State<AddTransDialog> {
  final TextEditingController _pickUpController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _timeToGoController = TextEditingController();
  final TextEditingController _timeToLeaveController = TextEditingController();

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
                "Add a Trip",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 161, 189, 5),
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField("The Pick-Up Point", _pickUpController),
              const SizedBox(height: 16),

              // Owner Name
              _buildTextField("Name of the Person", _ownerNameController),
              const SizedBox(height: 16),

              // Mobile Number
              _buildTextField("Mobile Number", _mobileController,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 16),

              // Time-to-go
              _buildTextField("Time to Go", _timeToGoController),
              const SizedBox(height: 16),

              // Time-to-leave
              _buildTextField("Time to Leave", _timeToLeaveController),
              const SizedBox(height: 20),

              // Add Button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    backgroundColor: const Color.fromARGB(255, 161, 189, 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Add the trip if all fields are filled
                    if (_pickUpController.text.isNotEmpty &&
                        _ownerNameController.text.isNotEmpty &&
                        _mobileController.text.isNotEmpty &&
                        _timeToGoController.text.isNotEmpty &&
                        _timeToLeaveController.text.isNotEmpty) {
                      widget.addCard(
                          _ownerNameController.text,
                          _pickUpController.text,
                          _mobileController.text,
                          _timeToGoController.text,
                          _timeToLeaveController.text);
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
                    "Add Trip",
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
        labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: const Color.fromARGB(255, 161, 189, 5),
        ),
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
