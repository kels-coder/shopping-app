import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/terms_and_condition.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _isLogin = true;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); // hide keyboard

    if (!isValid) return;

    _formKey.currentState!.save();

    setState(() {
      _isAuthenticating = true;
    });

    try {
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      } else {
        await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
      }
    } on FirebaseAuthException catch (error) {
      var message = 'Authentication failed.';

      if (error.code == 'email-already-in-use') {
        message = 'This email address is already in use.';
      } else if (error.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (error.code == 'wrong-password') {
        message = 'Incorrect password.';
      }
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(message)));

      if (!mounted) return;

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/tomato.jpg', fit: BoxFit.cover),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'My Store',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: screenWidth < 400 ? 26 : 32,
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
                  const SizedBox(height: 20),
                  Container(
                    width: screenWidth * 0.9,
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredEmail = value!.trim();
                                },
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length < 6) {
                                    return 'Password must be at least 6 characters long.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredPassword = value!.trim();
                                },
                              ),
                              const SizedBox(height: 20),
                              if (_isAuthenticating)
                                const CircularProgressIndicator()
                              else
                                ElevatedButton.icon(
                                  onPressed: _submit,
                                  icon: Icon(
                                    _isLogin ? Icons.login : Icons.person_add,
                                  ),
                                  label: Text(_isLogin ? 'Login' : 'Signup'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(
                                  _isLogin
                                      ? 'Create an account'
                                      : 'I already have an account',
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          const TermsAndConditionsScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Read our Terms and Conditions',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
