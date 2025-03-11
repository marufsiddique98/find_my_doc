import 'package:find_my_doc/core/common/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../config/constants/app_colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Privacy Policy'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Privacy Policy for FindMyDoc'),
            _buildSectionContent(
              'Effective Date: March 10, 2025',
            ),
            _buildSectionTitle('1. Information We Collect'),
            _buildSectionContent(
              'We collect various types of personal information in order to provide you with the best possible service, including:\n'
              '\n'
              '- **Personal Identification Information:** This includes your name, email address, phone number, location, and other contact details.\n'
              '- **Health Information:** Information related to your health status, including medical history, symptoms, doctor consultations, appointments, and prescriptions.\n'
              '- **Device Information:** We collect information about the device you use to access the app, such as the device model, operating system, and unique device identifiers.\n'
              '- **Usage Information:** This includes data about how you use the app, such as interactions, features you use, and the pages you visit.',
            ),
            _buildSectionTitle('2. How We Use Your Information'),
            _buildSectionContent(
              'We use the collected information for the following purposes:\n'
              '\n'
              '- To provide and improve our services, including doctor appointments, health consultations, and symptom checking.\n'
              '- To personalize your experience, offering tailored doctor recommendations and health tips.\n'
              '- To facilitate communication, such as appointment reminders and notifications about doctor availability.\n'
              '- To track usage patterns and improve the app’s features and functionalities.\n'
              '- To send you promotional or informational content, with your consent, regarding updates, offers, or new features.',
            ),
            _buildSectionTitle('3. How We Share Your Information'),
            _buildSectionContent(
              'We respect your privacy and will not sell or rent your personal information to third parties. We may share your information in the following situations:\n'
              '\n'
              '- **With Doctors:** We share your information with doctors for the purpose of appointment scheduling, medical consultations, and providing medical care.\n'
              '- **With Service Providers:** We may share information with third-party service providers who help us with app functionality, such as hosting, analytics, and payment processing.\n'
              '- **Legal Compliance:** We may share your information if required by law or in response to legal requests, such as complying with a subpoena or protecting our legal rights.',
            ),
            _buildSectionTitle('4. Data Security'),
            _buildSectionContent(
              'We take the protection of your data seriously and use various security measures to prevent unauthorized access, disclosure, or destruction of your personal information. However, please note that no method of transmission over the Internet or method of electronic storage is completely secure. While we strive to use commercially acceptable means to protect your personal information, we cannot guarantee absolute security.',
            ),
            _buildSectionTitle('5. Your Rights and Choices'),
            _buildSectionContent(
              'You have the right to:\n'
              '\n'
              '- **Access your information:** You can view and update your personal information directly through the app.\n'
              '- **Delete your information:** You can request the deletion of your personal data by contacting us. However, we may retain certain information for legal or operational purposes.\n'
              '- **Opt-out of communications:** You can opt-out of promotional emails or notifications by adjusting your settings within the app or unsubscribing via the provided link in emails.',
            ),
            _buildSectionTitle('6. Data Retention'),
            _buildSectionContent(
              'We retain your personal information only for as long as necessary to fulfill the purposes outlined in this Privacy Policy. Once the information is no longer needed, we will securely delete or anonymize it.',
            ),
            _buildSectionTitle('7. Children\'s Privacy'),
            _buildSectionContent(
              'Our app is not intended for use by children under the age of 13. We do not knowingly collect personal information from children. If we learn that we have inadvertently collected information from a child under 13, we will take steps to delete that information.',
            ),
            _buildSectionTitle('8. Changes to This Privacy Policy'),
            _buildSectionContent(
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the updated policy on this page and updating the "Effective Date" at the top of the page. We encourage you to review this Privacy Policy periodically to stay informed about how we protect your information.',
            ),
            _buildSectionTitle('9. Contact Us'),
            _buildSectionContent(
              'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:\n'
              '\n'
              '**FindMyDoc Support Team**\n'
              'Email: support@findmydoc.com\n'
              'Phone: +1 (800) 123-4567\n'
              'Address: 123 Health Avenue, City, Country',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.purpleColor,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
