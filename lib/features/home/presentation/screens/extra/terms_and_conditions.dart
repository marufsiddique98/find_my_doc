import 'package:find_my_doc/core/common/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../config/constants/app_colors.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Terms and Conditions'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Terms and Conditions for FindMyDoc'),
            _buildSectionContent(
              'Effective Date: March 10, 2025',
            ),
            _buildSectionTitle('1. Introduction'),
            _buildSectionContent(
              'These Terms and Conditions ("Terms") govern your use of the FindMyDoc mobile application ("App") provided by FindMyDoc, a service that helps connect patients with doctors for medical consultations, appointments, and health-related services. By using our App, you agree to comply with and be bound by these Terms.\n'
              'If you do not agree to these Terms, you must not use our App.',
            ),
            _buildSectionTitle('2. Eligibility'),
            _buildSectionContent(
              'To use our App, you must be at least 18 years old or have the permission of a legal guardian. By using the App, you confirm that you meet these eligibility requirements.\n'
              'We reserve the right to restrict access to the App to individuals who do not meet these requirements or who violate any terms outlined here.',
            ),
            _buildSectionTitle('3. Account Registration'),
            _buildSectionContent(
              'To access certain features of the App, you may be required to create an account. You agree to provide accurate, current, and complete information during the registration process and to update such information as necessary.\n'
              'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
            ),
            _buildSectionTitle('4. Use of the App'),
            _buildSectionContent(
              'You agree to use the App solely for lawful purposes and in a manner that does not infringe on the rights of others. You must not:\n'
              '- Engage in any activity that disrupts or damages the App.\n'
              '- Use the App to engage in fraud, abuse, or illegal activity.\n'
              '- Attempt to reverse engineer or decompile any part of the App.\n'
              'You acknowledge that FindMyDoc may suspend or terminate your access to the App if you violate these Terms.',
            ),
            _buildSectionTitle('5. Doctor-Patient Interaction'),
            _buildSectionContent(
              'FindMyDoc acts as an intermediary between doctors and patients. However, we do not directly provide medical services or advice. The doctors listed on the platform are independent contractors and are solely responsible for the services they provide.\n'
              'By using the App, you agree that FindMyDoc is not responsible for any medical advice, diagnosis, or treatment that you receive from doctors.',
            ),
            _buildSectionTitle('6. Appointments and Cancellations'),
            _buildSectionContent(
              'You may book appointments with doctors through the App. Once an appointment is booked, both you and the doctor will receive notifications. You agree to attend the appointment at the scheduled time and to notify the doctor or FindMyDoc if you need to cancel or reschedule.\n'
              'FindMyDoc reserves the right to cancel appointments or deny access to the App if necessary.',
            ),
            _buildSectionTitle('7. Fees and Payments'),
            _buildSectionContent(
              'Certain features of the App, such as doctor consultations or premium services, may require payment. All fees and charges will be clearly communicated to you before confirming any transactions.\n'
              'By using the paid features of the App, you agree to pay all applicable fees as described. Payments are processed through third-party payment providers, and you agree to comply with their terms and conditions.',
            ),
            _buildSectionTitle('8. Data Collection and Privacy'),
            _buildSectionContent(
              'We collect and process your personal information as described in our Privacy Policy. By using the App, you agree to the collection and use of your information in accordance with our Privacy Policy.\n'
              'Please review our Privacy Policy for more information on how we collect, use, and protect your data.',
            ),
            _buildSectionTitle('9. Termination and Suspension'),
            _buildSectionContent(
              'FindMyDoc may suspend or terminate your access to the App if you violate any of these Terms or engage in activities that harm the platform or other users. We may also suspend your account for maintenance, upgrades, or other necessary reasons.',
            ),
            _buildSectionTitle('10. Limitation of Liability'),
            _buildSectionContent(
              'To the fullest extent permitted by law, FindMyDoc, its officers, employees, and partners are not liable for any indirect, incidental, special, consequential, or punitive damages arising from the use or inability to use the App.\n'
              'This includes any issues related to doctor-patient interactions, appointment cancellations, or any inaccuracies in medical information provided through the App.',
            ),
            _buildSectionTitle('11. Indemnification'),
            _buildSectionContent(
              'You agree to indemnify, defend, and hold harmless FindMyDoc, its officers, employees, and partners from any claims, losses, damages, or expenses arising from your use of the App, including violations of these Terms or any applicable laws.',
            ),
            _buildSectionTitle('12. Changes to Terms and Conditions'),
            _buildSectionContent(
              'FindMyDoc reserves the right to update or modify these Terms at any time. Any changes will be posted in this document with an updated "Effective Date." We encourage you to review these Terms periodically to stay informed about how we operate.',
            ),
            _buildSectionTitle('13. Governing Law'),
            _buildSectionContent(
              'These Terms are governed by and construed in accordance with the laws of the jurisdiction in which FindMyDoc operates. Any disputes arising from the use of the App will be subject to the exclusive jurisdiction of the courts in that jurisdiction.',
            ),
            _buildSectionTitle('14. Contact Us'),
            _buildSectionContent(
              'If you have any questions or concerns about these Terms and Conditions, please contact us at:\n'
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
