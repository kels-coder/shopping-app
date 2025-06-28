import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernameProvider = Provider<String>((ref) {
  final email = FirebaseAuth.instance.currentUser?.email ?? '';
  return email.contains('@') ? email.split('@')[0] : 'User';
});
