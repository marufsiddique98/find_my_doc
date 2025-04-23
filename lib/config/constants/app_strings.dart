import 'package:shared_preferences/shared_preferences.dart';

class AppString {
  AppString._();
  static const String appName = 'Find My Doc';
  static const String baseUrl = 'http://192.168.0.100:3001/';
  static const List<String> specialties = [
    "Cardiologist",
    "Neurologist",
    "Oncologist",
    "Dermatologist",
    "Pediatrician",
    "Orthopedic Surgeon",
    "Endocrinologist",
    "Ophthalmologist",
    "Pulmonologist",
    "Gastroenterologist",
    "Neurosurgeon",
    "Cardiothoracic Surgeon",
    "Plastic Surgeon",
    "Urologist",
    "Vascular Surgeon",
    "Geriatrician",
    "Psychiatrist",
    "Immunologist",
    "Hematologist",
    "Rheumatologist",
    "Anesthesiologist",
    "Radiologist",
    "Pathologist",
    "Nephrologist",
    "Infectious Disease Specialist",
    "Emergency Medicine Physician",
    "General Surgeon",
    "Otolaryngologist",
    "Allergy Specialist",
    "Sports Medicine Physician",
    "Family Medicine Physician",
    "Internal Medicine Physician",
    "Obstetrician",
    "Gynecologist",
    "Reproductive Endocrinologist",
    "Pain Management Specialist",
    "Sleep Medicine Specialist",
    "Addiction Medicine Specialist",
    "Preventive Medicine Specialist",
    "Critical Care Specialist",
    "Hyperbaric Medicine Specialist"
  ];
}

class LocalStorage {
  late SharedPreferences preferences;
  LocalStorage() {
    _init();
  }
  _init() async {
    preferences = await SharedPreferences.getInstance();
  }

  void setToken(String token) async {
    await preferences.setString('token', token);
  }

  String? getToken() {
    print('Token: ${preferences.getString('token')}');
    return preferences.getString('token');
  }

  Future<bool> removeToken() async {
    return await preferences.remove('token');
  }
}
