import 'package:flutter/material.dart';
import '../model/api_response.dart';
import '../services/registration.dart';
import '../style/textbox_style.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _middlenameController = TextEditingController();
  String _selectedaccountType = 'client'; 
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();


  Future<void> registerUser() async {
    ApiResponse response = await register(
      _lastnameController.text,
      _firstnameController.text,
      _middlenameController.text,
      _selectedaccountType,  
      _departmentController.text,
      _emailController.text,
      _passwordController.text,
      _confirmpasswordController.text,
    );

    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('REGISTERED SUCCESSFULLY')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${response.error}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _lastnameController,
                  decoration: textBoxStyle("Enter your lastname", "lastname"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'LASTNAME IS REQUIRED!';
                    }
                    return null;
                  },
                ),
                const Divider(),
                TextFormField(
                  controller: _firstnameController,
                  decoration: textBoxStyle("Enter your firstname", "firstname"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'FIRSTNAME IS REQUIRED!';
                    }
                    return null;
                  },
                ),
                const Divider(),
                TextFormField(
                  controller: _middlenameController,
                  decoration: textBoxStyle("Enter your middlename", "middlename"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'MIDDLENAME IS REQUIRED!';
                    }
                    return null;
                  },
                ),
                const Divider(),
                DropdownButtonFormField<String>(
                  value: _selectedaccountType,
                  decoration: const InputDecoration(
                    labelText: "Select User Type",
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    {'display': 'Client', 'value': 'client'},
                    {'display': 'Office Staff', 'value': 'office_staff'},
                    {'display': 'Supplier', 'value': 'supplier'},
                  ].map((item) {
                    return DropdownMenuItem<String>(
                      value: item['value'],
                      child: Text(item['display']!),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedaccountType = newValue!;
                    });
                  },
                ),
                const Divider(),
                TextFormField(
                  controller: _departmentController,
                  decoration: textBoxStyle("Enter your department", "department"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'PLEASE ENTER YOUR DEPARTMENT!';
                    }
                    return null;
                  },
                ),
                const Divider(),
                TextFormField(
                  controller: _emailController,
                  decoration: textBoxStyle("Enter your email", "email"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'PLEASE ENTER YOUR EMAIL';
                    }
                    return null;
                  },
                ),
                const Divider(),
                TextFormField(
                  controller: _passwordController,
                  decoration: textBoxStyle("Enter your password", "password"),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'PLEASE ENTER YOUR PASSWORD!';
                    } else if (value.length < 8) {
                      return 'PASSWORD MUST BE AT LEAST 8 CHARACTERS!';
                    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'PASSWORD MUST CONTAIN AT LEAST 1 UPPERCASE LETTER!';
                    } else if (!RegExp(r'\d').hasMatch(value)) {
                      return 'PASSWORD MUST CONTAIN AT LEAST 1 NUMBER!';
                    }
                    return null;
                  },
                ),
                const Divider(),
                TextFormField(
                  controller: _confirmpasswordController,
                  decoration: textBoxStyle("Enter your password confirmation", "password confirmation"),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'PASSWORD CONFIRMATION IS REQUIRED!';
                    } else if (value != _passwordController.text) {
                      return 'PASSWORDS DO NOT MATCH!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        registerUser();
                      });
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
