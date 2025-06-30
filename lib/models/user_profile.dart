class UserProfile {
  final String email;
  final String address;
  final String phoneNumber;

  UserProfile({
    required this.email,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {'email': email, 'address': address, 'phoneNumber': phoneNumber};
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}
