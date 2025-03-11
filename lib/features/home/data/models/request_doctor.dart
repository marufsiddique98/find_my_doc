import 'package:find_my_doc/features/home/data/models/doctor.dart';

class RequestDoctor {
  int? id;
  int? doctorId;
  int? patientId;
  String? status;
  int? urgencyLevel;
  double? latitude;
  double? longitude;
  Doctor? doctor;
  Patient? patient;
  DateTime? createdAt;

  RequestDoctor({
    this.id,
    this.doctorId,
    this.patientId,
    this.status,
    this.urgencyLevel,
    this.latitude,
    this.longitude,
    this.doctor,
    this.patient,
    this.createdAt,
  });

  // Factory method to create a RequestDoctor object from JSON
  factory RequestDoctor.fromJson(Map<String, dynamic> json) {
    return RequestDoctor(
      id: json['id'],
      doctorId: json['doctor_id'],
      patientId: json['patient_id'],
      status: json['status'],
      urgencyLevel: json['urgency_level'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      doctor: Doctor.fromJson(json['doctor']),
      patient: Patient.fromJson(json['patient']),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  // Method to convert a RequestDoctor object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'patient_id': patientId,
      'status': status,
      'urgency_level': urgencyLevel,
      'latitude': latitude,
      'longitude': longitude,
      'doctor': doctor?.toJson(),
      'patient': patient?.toJson(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
