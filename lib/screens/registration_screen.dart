import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:isu_canner/screens/login_screen.dart';
import '../style/textbox_style.dart';
import '../services/registration.dart';
import '../screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final Map<String, TextEditingController> _controllers = {
    'lastname': TextEditingController(),
    'firstname': TextEditingController(),
    'middlename': TextEditingController(),
    'department': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confirm_password': TextEditingController(),
  };

  // Selected account type
  String _selectedAccountType = 'client';

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _registerUser() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) return;

    // Attempt to register the user
    final response = await register(
      _controllers['lastname']!.text,
      _controllers['firstname']!.text,
      _controllers['middlename']!.text,
      _selectedAccountType,
      _controllers['department']!.text,
      _controllers['email']!.text,
      _controllers['password']!.text,
      _controllers['confirm_password']!.text,
    );

    // Show success or error message
    _showSnackBar(response.error == null
        ? 'REGISTERED SUCCESSFULLY'
        : 'Registration failed: ${response.error}');
  }

  void _showSnackBar(String message) {
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
              const SizedBox(height: 20),
              ..._buildInputFields(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
              const SizedBox(height: 20),
              _loginButton(),
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
          const SizedBox(width: 8),
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


  // Build all input fields including text fields and dropdown
  List<Widget> _buildInputFields() {
    return [
      _buildTextField('lastname', 'Enter your lastname', 'Lastname is required'),
      _buildTextField('firstname', 'Enter your firstname', 'Firstname is required'),
      _buildTextField('middlename', 'Enter your middlename', 'Middlename is required'),
      _buildAccountTypeDropdown(),
      _buildTextField('department', 'Enter your department', 'Department is required'),
      _buildTextField('email', 'Enter your email', 'Email is required'),
      _buildPasswordField(),
      _buildTextField('confirm_password', 'Confirm your password', 'Password confirmation is required'),
      const SizedBox(height: 10),
    ];
  }




  // Build a generic text field
  Widget _buildTextField(String field, String hint, String errorMessage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _controllers[field],  // Controller for managing text input
        decoration: greenInputDecoration(field, hint),  // Apply custom greenInputDecoration
        validator: (value) => value?.isEmpty ?? true ? errorMessage : null,  // Validation
      ),
    );
  }


  // Build the password field with special validation
  Widget _buildPasswordField() {
    return TextFormField(
      decoration: greenInputDecoration('Password', 'Enter your password'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
    );
  }


  // Validate the password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter';
    } else if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least 1 number';
    }
    return null;
  }

  // Build the account type dropdown
  Widget _buildAccountTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: greenInputDecoration('Account Type', 'Select your account type'),
      items: <String>['Client', 'Supplier', 'Office Staff'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {},
      validator: (value) => value == null ? 'Account type is required' : null,
    );
  }


  // Build the submit button
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,  // Full width
      height: 50,  // Button height
      child: ElevatedButton(
        onPressed: _registerUser,  // Action on button press
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.green,  // Set text color to white
          textStyle: const TextStyle(fontSize: 16),  // Customize text size
        ),
        child: const Text('Register'),
      ),
    );
  }

  Widget _loginButton() {
    return Align(
      alignment: Alignment.centerLeft, // Aligns the text to the start (left)
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black), // Default text style
              children: [
                const TextSpan(
                  text: "Do have an account? Try to login ",
                ),
                TextSpan(
                  text: "here.",
                  style: const TextStyle(
                    color: Colors.green, // Color to indicate it's clickable
                    decoration: TextDecoration.none, // No underline
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
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