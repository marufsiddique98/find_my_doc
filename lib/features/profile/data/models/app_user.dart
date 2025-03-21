class AppUser {
  final int id;
  final String name;
  final String? speciality;
  final int ratings;

  AppUser({required this.id, required this.name, required this.ratings, this.speciality});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      speciality: json['speciality'],
      ratings: json['ratings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'speciality': speciality,
      'ratings': ratings,
    };
  }
}
