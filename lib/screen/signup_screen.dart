import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _isLoading = false;
  String _name = '';
  String _email = '';
  String _password = '';
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final newInset = MediaQuery.of(context).viewInsets.bottom;
    if (mounted) {
      setState(() {
        _keyboardHeight = newInset;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1)); // Simulated delay
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🎉 Signup successful! Please login now.')),
      );

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = _keyboardHeight > 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background/login_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Dreamy white overlay
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.1),
            ),
          ),

          // Black overlay when keyboard is open
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isKeyboardOpen ? 0.4 : 0.0,
            child: Container(color: Colors.black),
          ),

          // Foreground content
          SafeArea(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: _keyboardHeight + 24,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 115),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Create your account ✨',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        focusNode: _nameFocus,
                        decoration: _inputDecoration('Name'),
                        onChanged: (value) => _name = value,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_emailFocus),
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter your name'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: _emailFocus,
                        decoration: _inputDecoration('Email'),
                        onChanged: (value) => _email = value,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_passwordFocus),
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter your email'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: _passwordFocus,
                        obscureText: true,
                        decoration: _inputDecoration('Password'),
                        onChanged: (value) => _password = value,
                        onFieldSubmitted: (_) => _submitForm(),
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter a password'
                            : null,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 80,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Create Account'),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }
}
