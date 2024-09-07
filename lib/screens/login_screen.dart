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
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

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
      case 'office_staff':
        homepage = StaffHomepage(user:user);
        break;
      case 'client':
        homepage = ClientHomepage(user:user);
        break;
      case 'supplier':
        homepage = SupplierHomepage(user:user);
        break;
      default:
        return; // Handle unexpected account type
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => homepage),
      (route) => false,
    );
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      ApiResponse response = await login(_emailController.text, _passwordController.text);

      if (response.error == null) {
        await _saveAndRedirectToHome(response.data as User);
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
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        ),
      ),
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
      decoration: textBoxStyle("Enter your email", "Email"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Email!';
        }
        return null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your Password",
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password!';
        }
        return null;
      },
    );
  }

  Widget _sumbitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _loginUser,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Submit'),
      ),
    );
  }

  Widget _registrationButton() {
    return TextButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RegistrationScreen()),
      ),
      child: const Text('Register'),
    );
  }
}

