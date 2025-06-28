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
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _savedAddress = '';
  String _savedPhone = '';
  bool _isEditingAddress = true;
  bool _isEditingPhone = true;

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                TableRow(
                  children: [
                    const Text('Address'),
                    const SizedBox(),
                    _isEditingAddress
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                onPressed: () {
                                  final input = _addressController.text.trim();
                                  if (input.isNotEmpty) {
                                    setState(() {
                                      _savedAddress = input;
                                      _isEditingAddress = false;
                                    });
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  setState(() {
                                    _isEditingAddress = true;
                                  });
                                },
                              ),
                            ],
                          ),
                  ],
                ),
                const TableRow(
                  children: [SizedBox(height: 16), SizedBox(), SizedBox()],
                ),
                TableRow(
                  children: [
                    const Text('Phone'),
                    const SizedBox(),
                    _isEditingPhone
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                onPressed: () {
                                  final input = _phoneController.text.trim();
                                  if (input.isNotEmpty) {
                                    setState(() {
                                      _savedPhone = input;
                                      _isEditingPhone = false;
                                    });
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  setState(() {
                                    _isEditingPhone = true;
                                  });
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
