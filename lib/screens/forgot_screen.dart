import 'package:flutter/material.dart';

import '../style/textbox_style.dart';
import 'login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ForgotPasswordScreen(),
  ));
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _contactController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to VerificationScreen after resetting
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MethodSelectionScreen()),
    );

    setState(() => _isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Column for Icon and Forgot Password text
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center, // Centers the icons on top of each other
                    children: [
                      const Icon(
                        Icons.lock,
                        size: 120,
                        color: Color(0xFF01450D), // First icon's color
                      ),
                      Transform.translate(
                        offset: const Offset(0, 10), // Adjust x and y values to move the icon
                        child: const Icon(
                          Icons.circle,
                          size: 50, // Smaller size for the circle
                          color: Colors.white, // Second icon's color
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, 10), // Adjust x and y values to move the icon
                        child: const Icon(
                          Icons.question_mark,
                          size: 40, // Smaller size for the circle
                          color: Color(0xFF01450D), // Second icon's color
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8), // Space between icon and text
                  const Text(
                    'Forgot Password', // Your text here
                    style: TextStyle(
                      fontSize: 26, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Optional: Make the text bold
                      color: Colors.black, // Change color if needed
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Provide your email or phone to reset your password'),
              const SizedBox(height: 20),
              _contactField(),
              const SizedBox(height: 20),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }



  AppBar _buildAppBar() {
    return AppBar(
      leading: Transform.translate(
        offset: const Offset(0, 0), // Adjust the icon's position if needed
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Custom green color
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
      ),
      title: Row(
        children: [
          Transform.translate(
            offset: const Offset(-20, 0), // Moves the image 20 units to the left
            child: Image.asset(
              'assets/images/isu.png',
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 9),
          Transform.translate(
            offset: const Offset(-20, 0), // Moves the text 20 units to the left
            child: const Text(
              'ISU-CANNER',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green[900],
    );
  }

  Widget _contactField() {
    return TextFormField(
      controller: _contactController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Email or Phone',
        hintText: 'Enter your email or phone',
        labelStyle: const TextStyle(color: Colors.black), // Change label color
        hintStyle: TextStyle(color: Colors.green.shade600), // Change hint text color
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: Colors.green, // Change prefix icon color
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email or phone!';
        }
        return null;
      },
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _resetPassword,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF08811D), // Replace with your desired color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Next', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class MethodSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: const Offset(0, 0), // Adjust the icon's position if needed
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white, // Custom white color for the back icon
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) =>  ForgotPasswordScreen()),
              );
            },
          ),
        ),
        title: Row(
          children: [
            Transform.translate(
              offset: const Offset(-20, 0), // Moves the image 20 units to the left
              child: Image.asset(
                'assets/images/isu.png',
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(width: 9),
            Transform.translate(
              offset: const Offset(-20, 0), // Moves the text 20 units to the left
              child: const Text(
                'ISU-CANNER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(-120, -20), // Move the title up by 10 units
            child: const Text(
              'MAKE\nSELECTION', // Your text here
              style: TextStyle(
                fontSize: 26, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Optional: Make the text bold
                color: Colors.black, // Change color if needed
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(-25, -15), // Move the description down by 5 units
            child: const Text(
              'Select which contact detail should we use to \nreset your password',
              textAlign: TextAlign.start, // Left align the text
              style: TextStyle(
                fontSize: 16, // Adjust the font size for this text
                color: Colors.black54, // Change color if needed
              ),
            ),
          ),
          const SizedBox(height: 20), // Space between description and contact method cards
          _contactMethodCard(context, '+923332562233', 'via SMS', Icons.phone),
          _contactMethodCard(context, 'support@gmail.com', 'via Email', Icons.email),
        ],
      ),
    );
  }

  // Updated _contactMethodCard to include icons
  Widget _contactMethodCard(BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.green), // Add icon at the left
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationScreen()),
          );
        },
      ),
    );
  }
}

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _codeControllers =
  List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: const Offset(0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) =>  MethodSelectionScreen()),
              );
            },
          ),
        ),
        title: const Text(
          'Verification',
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Colors.green[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            const Text(
              'Please check your email',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            const Text(
              'We\'ve sent a code to contact@curfcode.com',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 60,
                  child: TextField(
                    controller: _codeControllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 1,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) =>  NewCredentialsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Verify'),
            ),
            TextButton(
              onPressed: () {
                // Add your resend code logic here
              },
              child: const Text('Didn\'t get the code? Click to resend.'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewCredentialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: const Offset(0, 0), // Adjust the icon's position if needed
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white, // Custom green color
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) =>  MethodSelectionScreen()),
              );
            },
          ),

        ),
        title: Row(
          children: [
            Transform.translate(
              offset: const Offset(-20, 0), // Moves the image 20 units to the left
              child: Image.asset(
                'assets/images/isu.png',
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(width: 9),
            Transform.translate(
              offset: const Offset(-20, 0), // Moves the text 20 units to the left
              child: const Text(
                'ISU-CANNER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Column(
              children: [
                Stack(
                  alignment: Alignment.center, // Centers the icons on top of each other
                  children: [
                    Icon(
                      Icons.edit_calendar_outlined,
                      size: 100,
                      color: Color(0xFF01450D), // First icon's color
                    ),
                  ],
                ),
                SizedBox(height: 8), // Space between icon and text
                Text(
                  'NEW\NCREDENTIAL', // Your text here
                  style: TextStyle(
                    fontSize: 26, // Adjust the font size as needed
                    fontWeight: FontWeight.bold, // Optional: Make the text bold
                    color: Colors.black, // Change color if needed
                  ),
                ),
                Text(
                  'Enter your new password to\n      unlock your account',
                  style: TextStyle(
                    color: Colors.grey, // Change color if needed
                  ),
                )
              ],
            ),

            TextField(
                  decoration: greenInputDecoration("New Password", "Enter New Password"),  // Using textBoxStyle here

            ),
            const SizedBox(height: 20),
            TextField(
              decoration: greenInputDecoration("Password Confirmation", "Confirm New Password"),  // Using textBoxStyle here

            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordUpdatedScreen()),
                );
              },
              child: const Text('Update'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordUpdatedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          children: [
            Transform.translate(
              offset: const Offset(-10, 0), // Moves the image 20 units to the left
              child: Image.asset(
                'assets/images/isu.png',
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(width: 9),
            Transform.translate(
              offset: const Offset(-20, 0), // Moves the text 20 units to the left
              child: const Text(
                'ISU-CANNER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20), // Padding around the content
          decoration: BoxDecoration(
            color: Colors.green, // Set the background color to green
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          width: 400,
          height: 600,// Set the width of the box
          child: Column(
            mainAxisSize: MainAxisSize.min, // Makes the column take only the required space
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PASSWORD\nUPDATED', // Your text here
                style: TextStyle(
                  fontSize: 46, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Optional: Make the text bold
                  color: Colors.black, // Change color if needed
                ),
                textAlign: TextAlign.center, // Center align the text
              ),
              const Icon(Icons.check_circle, size: 100, color: Colors.black),
              const SizedBox(height: 20),
              const Text(
                'Your password has been updated',
                style: TextStyle(color: Colors.black), // Optional: Style the text
                textAlign: TextAlign.center, // Center align the text
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) =>  const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green.shade900,
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
