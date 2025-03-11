class Doctor {
  int? id;
  int? userId;
  String? name;
  String? speciality;
  double? latitude;
  double? longitude;
  double? ratings;

  Doctor({
    this.id,
    this.userId,
    this.name,
    this.speciality,
    this.latitude,
    this.longitude,
    this.ratings,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      speciality: json['speciality'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      ratings: json['ratings']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'speciality': speciality,
      'latitude': latitude,
      'longitude': longitude,
      'ratings': ratings,
    };
  }

  @override
  String toString() {
    return 'Doctor{id: $id, userId: $userId, name: $name, speciality: $speciality, latitude: $latitude, longitude: $longitude, ratings: $ratings}';
  }
}

class Patient {
  final int id;
  final String name;
  final double ratings;

  Patient({
    required this.id,
    required this.name,
    required this.ratings,
  });

  // Factory constructor to create an instance from a JSON map
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      ratings: (json['ratings'] ?? 0).toDouble(),
    );
  }

  // Method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ratings': ratings,
    };
  }
}
