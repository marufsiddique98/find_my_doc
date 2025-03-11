import 'package:flutter/material.dart';
import '../../../../core/common/widgets/my_app_bar.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Help & Support'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for help topics...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),

            // FAQ Section
            Text("Frequently Asked Questions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildFAQTile("How do I book an appointment?", "You can book an appointment by selecting a doctor, choosing a date and time, and confirming."),
            _buildFAQTile("How can I cancel or reschedule an appointment?", "Go to your appointments section, select the appointment, and choose cancel or reschedule."),
            _buildFAQTile("How do I contact my doctor?", "You can contact your doctor through the chat feature or by calling if the doctor allows calls."),
            _buildFAQTile("What should I do if my doctor is unavailable?", "Try booking another doctor or check for available slots later."),
            _buildFAQTile("How do I add my insurance details?", "Go to settings > insurance details > add your provider and policy number."),

            SizedBox(height: 20),

            // Support Options
            Text("Support Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildSupportButton(Icons.phone, "Call Customer Care", () {
              // Implement call functionality (example: launch a dialer)
              print("Calling Support...");
            }),
            _buildSupportButton(Icons.email, "Email Us", () {
              // Implement email functionality
              print("Opening email support...");
            }),

            SizedBox(height: 20),

            // Emergency Section
            Card(
              color: Colors.red.shade100,
              child: ListTile(
                leading: Icon(Icons.warning, color: Colors.red),
                title: Text("Emergency Assistance", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("If you need urgent medical help, call 911 or visit the nearest hospital."),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Card(
      child: ExpansionTile(
        title: Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
        children: [Padding(padding: EdgeInsets.all(10), child: Text(answer))],
      ),
    );
  }

  Widget _buildSupportButton(IconData icon, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(icon),
        label: Text(title),
        onPressed: onPressed,
      ),
    );
  }
}
