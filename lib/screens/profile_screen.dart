import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/provider/username_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _savedUsername = '';
  String _savedAddress = '';
  String _savedPhone = '';

  bool _isEditingUserName = false;
  bool _isEditingAddress = false;
  bool _isEditingPhone = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _savedUsername = data['userName'] ?? '';
        _savedAddress = data['address'] ?? '';
        _savedPhone = data['phoneNumber'] ?? '';
      });
    }
  }

  Future<void> _updateField(String field, String value) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      field: value,
    });
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final email = ref.watch(emailProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.pacifico(
            textStyle: TextStyle(
              fontSize: screenWidth < 400 ? 28 : 32,
              color: Colors.white,
              shadows: const [
                Shadow(
                  blurRadius: 8,
                  color: Colors.black54,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text('User Details', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Table(
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FixedColumnWidth(16),
                2: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const Text('Email'),
                    const SizedBox(),
                    Row(
                      children: [
                        const Icon(Icons.email, size: 18),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            email,
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const TableRow(
                  children: [SizedBox(height: 16), SizedBox(), SizedBox()],
                ),

                /// Username
                TableRow(
                  children: [
                    const Text('Username'),
                    const SizedBox(),
                    _isEditingUserName
                        ? Row(
                            children: [
                              SizedBox(
                                width: 160,
                                height: 40,
                                child: TextField(
                                  controller: _userNameController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter username',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 10,
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const SizedBox(width: 6),
                              IconButton(
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  final input = _userNameController.text.trim();
                                  if (input.isNotEmpty) {
                                    setState(() {
                                      _savedUsername = input;
                                      _isEditingUserName = false;
                                    });
                                    await _updateField('userName', input);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Username saved'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(Icons.person, size: 18),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  _savedUsername,
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _userNameController.text = _savedUsername;
                                  setState(() => _isEditingUserName = true);
                                },
                              ),
                            ],
                          ),
                  ],
                ),
                const TableRow(
                  children: [SizedBox(height: 16), SizedBox(), SizedBox()],
                ),

                /// Address
                TableRow(
                  children: [
                    const Text('Address'),
                    const SizedBox(),
                    _isEditingAddress
                        ? Row(
                            children: [
                              SizedBox(
                                width: 160,
                                height: 40,
                                child: TextField(
                                  controller: _addressController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter address',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 10,
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const SizedBox(width: 6),
                              IconButton(
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  final input = _addressController.text.trim();
                                  if (input.isNotEmpty) {
                                    setState(() {
                                      _savedAddress = input;
                                      _isEditingAddress = false;
                                    });
                                    await _updateField('address', input);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Address saved'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(Icons.home, size: 18),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  _savedAddress,
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _addressController.text = _savedAddress;
                                  setState(() => _isEditingAddress = true);
                                },
                              ),
                            ],
                          ),
                  ],
                ),
                const TableRow(
                  children: [SizedBox(height: 16), SizedBox(), SizedBox()],
                ),

                /// Phone
                TableRow(
                  children: [
                    const Text('Phone'),
                    const SizedBox(),
                    _isEditingPhone
                        ? Row(
                            children: [
                              SizedBox(
                                width: 160,
                                height: 40,
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter phone number',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 10,
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const SizedBox(width: 6),
                              IconButton(
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  final input = _phoneController.text.trim();
                                  if (input.isNotEmpty) {
                                    setState(() {
                                      _savedPhone = input;
                                      _isEditingPhone = false;
                                    });
                                    await _updateField('phoneNumber', input);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Phone number saved'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(Icons.phone, size: 18),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  _savedPhone,
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _phoneController.text = _savedPhone;
                                  setState(() => _isEditingPhone = true);
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
