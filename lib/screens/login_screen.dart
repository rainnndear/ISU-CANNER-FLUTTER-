import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/api_response.dart';
import '../model/user.dart';
import '../services/login.dart';
import '../style/textbox_style.dart';
import '../screens/registration_screen.dart';
import '../screens/client/client_Homepage.dart';
import '../screens/office_staff/staff_Homepage.dart';
import '../screens/supplier/supplier_Homepage.dart';
import 'forgot_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _showPassword = false; // Checkbox for showing password

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveAndRedirectToHome(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token ?? '');
    await prefs.setInt('userId', user.id ?? 0);

    Widget homepage;
    switch (user.account_type) {
      case 'office staff':
        homepage = StaffHomepage(user: user);
        break;
      case 'client':
        homepage = ClientHomepage(user: user);
        break;
      case 'supplier':
        homepage = SupplierHomepage(user: user);
        break;
      default:
        return; // Handle unexpected account type
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => homepage),
    );
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      ApiResponse response = await login(_emailController.text, _passwordController.text);

      if (response.error == null) {
        User user = response.data as User;

        // Log the user account type to debug
        print('User account type: ${user.account_type}');

        // Redirect to the appropriate homepage
        await _saveAndRedirectToHome(user);
      } else {
        _showErrorSnackBar(response.error ?? 'An error occurred');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }


  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 60),
              _welcomeText(),
              const SizedBox(height: 40),
              _emailField(),
              const SizedBox(height: 20),
              _passwordField(),
              const SizedBox(height: 30),
              _sumbitButton(),
              const SizedBox(height: 20),
              _registrationButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,  // Removes the back button
      title: Row(
        children: [
          Image.asset(
            'assets/images/isu.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 9),
          const Text(
            'ISU-CANNER',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.green[900],
    );
  }


  Widget _welcomeText() {
    return const Column(
      children: [
        Text(
          'WELCOME',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.lightGreen,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Log in to continue',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      decoration: greenInputDecoration("Email", "Enter your email"),
      cursorColor: Colors.green,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Email!';
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: greenInputDecoration("Password", "Enter your password").copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.green,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          cursorColor: Colors.green,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password!';
            }
            return null;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _showPassword,
                  onChanged: (value) {
                    setState(() {
                      _showPassword = value ?? false;
                      _obscurePassword = !_showPassword; // Toggle password visibility
                    });
                  },
                  activeColor: Colors.green, // Change checkbox color
                ),
                const Text('Show Password', style: TextStyle(color: Colors.green)),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()), // Replace with your LoginPage widget
                );
              },

              child: const Text('Forgot Password?', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _sumbitButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _loginUser,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Submit', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _registrationButton() {
    return Align(
      alignment: Alignment.centerLeft, // Aligns the text to the start (left)
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black), // Default text style
              children: [
                const TextSpan(
                  text: "Don't have an account? Try to register ",
                ),
                TextSpan(
                  text: "here.",
                  style: const TextStyle(
                    color: Colors.green, // Color to indicate it's clickable
                    decoration: TextDecoration.none, // No underline
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegistrationScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



}
