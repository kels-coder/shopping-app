class UserProfile {
  final String email;
  final String userName;
  final String address;
  final String phoneNumber;

  UserProfile({
    required this.email,
    required this.userName,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}
