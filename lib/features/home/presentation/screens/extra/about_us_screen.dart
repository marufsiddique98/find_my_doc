import 'package:find_my_doc/config/constants/app_colors.dart';
import 'package:find_my_doc/core/common/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/assets.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'About Us'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildFeaturesSection(),
            _buildWhyChooseSection(),
            _buildCallToAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(
            Assets.imagesLogo, // Add your app logo
            height: 100,
            width: 100,
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to FindMyDoc!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.purpleColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Your Health, Your Convenience',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🌟 Unique Features',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.purpleColor,
            ),
          ),
          SizedBox(height: 10),
          _buildFeatureItem(
            'Real-Time Proximity Matching',
            'Find doctors near you instantly with real-time availability.',
          ),
          _buildFeatureItem(
            'AI Symptom Checker',
            'Get smart triage and the right doctor recommendations.',
          ),
          _buildFeatureItem(
            'Smart Queue System',
            'Reduce wait times with priority-based scheduling.',
          ),
          _buildFeatureItem(
            'Doctor Ratings & Reviews',
            'Make informed choices with transparency and trust.',
          ),
          _buildFeatureItem(
            'Medical History Integration',
            'Access previous consultations and prescriptions anytime.',
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.purpleColor, size: 24),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.purpleColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🚀 Why Choose FindMyDoc?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.purpleColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'FindMyDoc is more than just an app – it\'s your personal healthcare assistant, ensuring quick access to trusted doctors and smarter healthcare solutions.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to next page or take action here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purpleColor,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Get Started Today!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Experience the future of healthcare at your fingertips.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
