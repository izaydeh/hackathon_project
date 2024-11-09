import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDialog extends StatelessWidget {
  final Map<String, String> card;

  const BookDialog({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
              card['book'] ?? 'No Title',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Owner', card['name'] ?? 'N/A'), // Correct key
            const SizedBox(height: 16),
            _buildDetailRow('Mobile Number', card['mobile'] ?? 'N/A'),
            const SizedBox(height: 16),
            _buildDetailRow('Faculty', card['faculty'] ?? 'N/A'),
            const SizedBox(height: 16),
            _buildDetailRow('Major', card['major'] ?? 'N/A'),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
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
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
