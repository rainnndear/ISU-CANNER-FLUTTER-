import 'package:flutter/material.dart';
import '../style/textbox_style.dart';
import '../services/registration.dart';
import '../screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

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
            ],
          ),
        ),
      ),
    );
  }

  // Build the app bar with a back button
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Registration'),
      centerTitle: true,
      backgroundColor: Colors.green[900],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        ),
      ),
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
        controller: _controllers[field],
        decoration: textBoxStyle(hint, field),
        validator: (value) => value?.isEmpty ?? true ? errorMessage : null,
      ),
    );
  }

  // Build the password field with special validation
  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _controllers['password'],
        decoration: textBoxStyle("Enter your password", "password"),
        obscureText: true,
        validator: _validatePassword,
      ),
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
    const accountTypes = [
      {'display': 'Client', 'value': 'client'},
      {'display': 'Staff', 'value': 'office_staff'},
      {'display': 'Supplier', 'value': 'supplier'},
    ];

    return DropdownButtonFormField<String>(
      value: _selectedAccountType,
      decoration: const InputDecoration(
        labelText: "Select User Type",
        border: OutlineInputBorder(),
      ),
      items: accountTypes.map((type) => DropdownMenuItem<String>(
        value: type['value'],
        child: Text(type['display']!),
      )).toList(),
      onChanged: (newValue) => setState(() => _selectedAccountType = newValue!),
    );
  }

  // Build the submit button
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _registerUser,
        child: const Text('Register'),
      ),
    );
  }
}