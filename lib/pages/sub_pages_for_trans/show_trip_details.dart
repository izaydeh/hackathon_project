import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripDialog extends StatelessWidget {
  final Map<String, String> card;

  const TripDialog({Key? key, required this.card}) : super(key: key);

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
              card['name'] ?? 'No Name',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 161, 189, 5),
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Pick-Up Point', card['pickUp'] ?? 'N/A'),
            const SizedBox(height: 16),
            _buildDetailRow('Mobile Number', card['mobile'] ?? 'N/A'),
            const SizedBox(height: 16),
            _buildDetailRow('Time to Go', card['timeToGo'] ?? 'N/A'),
            const SizedBox(height: 16),
            _buildDetailRow('Time to Leave', card['timeToLeave'] ?? 'N/A'),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  backgroundColor: const Color.fromARGB(255, 161, 189, 5),
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
