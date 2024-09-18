import 'package:flutter/material.dart';
import '../../model/user.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../screens/client/qr_client.dart';



//////////////////CLIENT PROFILE
class ClientProfile extends StatefulWidget {
  final User user;

  const ClientProfile({super.key, required this.user});

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  File? _profileImage; // To store the selected profile image
  File? _coverImage; // To store the selected cover image
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  // Function to pick image for profile or cover
  Future<void> _pickImage(bool isProfile) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
          // Here you can make an API call to upload the profile image
        } else {
          _coverImage = File(pickedFile.path);
          // Here you can make an API call to upload the cover image
        }
      });
    }
  }

  // Function to build the Home page content
// Function to build the Home page content
  Widget _buildHomePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Cover photo
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _coverImage != null
                      ? FileImage(_coverImage!)
                      : const NetworkImage('https://via.placeholder.com/800x300') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Camera icon for cover photo
            Positioned(
              bottom: 10,
              right: 10,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 20,
                child: IconButton(
                  icon:const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {
                    _pickImage(false); // Change cover photo
                  },
                ),
              ),
            ),

            // Profile picture positioned on top of the cover photo
            Positioned(
              top: 130,
              left: 20,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage(true); // Change profile picture when tapping the profile image
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: _profileImage != null
                          ? Image.file(
                        _profileImage!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Camera icon for profile picture
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        _pickImage(true); // Change profile picture
                      },
                      child:const CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 20,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 90),

        // User information
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.user.firstname} ${widget.user.middlename} ${widget.user.lastname}',
                style:const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Edit Profile button
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: ElevatedButton(
            onPressed: () {
              // Add button action here
            },
            child:const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding:const EdgeInsets.symmetric(horizontal: 130, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Details section
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Set the background color to green
        leading: IconButton(
          icon:const Icon(Icons.arrow_back_ios_new_rounded, size: 25),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to the Profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientProfile(
                      user: widget.user, // Use the user passed to ClientHomepage
                    ),
                  ),
                );
              },
              child:const Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: Colors.white), // Customize text style
              ),
            ),
            const SizedBox(width: 20), // Spacing between texts
            GestureDetector(
              onTap: () {
                // Navigate to the QR Code page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientQRProfile(
                      user: widget.user, // Use the user passed to ClientHomepage
                    ),
                  ),
                );
              },
              child:const Text(
                'QR Code',
                style: TextStyle(fontSize: 18, color: Colors.white), // Customize text style
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: _buildHomePage(), // Display the selected page content
      ),
    );
  }
}








/////////////SUPPLIER PROFILE
class SupplierProfile extends StatefulWidget {
  final User user;

  const SupplierProfile({super.key, required this.user});

  @override
  State<SupplierProfile> createState() => _SupplierProfileState();
}

class _SupplierProfileState extends State<SupplierProfile> {
  File? _profileImage; // To store the selected profile image
  File? _coverImage; // To store the selected cover image
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  // Function to pick image for profile or cover
  Future<void> _pickImage(bool isProfile) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
          // Here you can make an API call to upload the profile image
        } else {
          _coverImage = File(pickedFile.path);
          // Here you can make an API call to upload the cover image
        }
      });
    }
  }

  // Function to build the Home page content
// Function to build the Home page content
  Widget _buildHomePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Cover photo
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _coverImage != null
                      ? FileImage(_coverImage!)
                      : const NetworkImage('https://via.placeholder.com/800x300') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Camera icon for cover photo
            Positioned(
              bottom: 10,
              right: 10,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 20,
                child: IconButton(
                  icon:const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {
                    _pickImage(false); // Change cover photo
                  },
                ),
              ),
            ),

            // Profile picture positioned on top of the cover photo
            Positioned(
              top: 130,
              left: 20,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage(true); // Change profile picture when tapping the profile image
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: _profileImage != null
                          ? Image.file(
                        _profileImage!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Camera icon for profile picture
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        _pickImage(true); // Change profile picture
                      },
                      child:const CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 20,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 90),

        // User information
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.user.firstname} ${widget.user.middlename} ${widget.user.lastname}',
                style:const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Edit Profile button
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: ElevatedButton(
            onPressed: () {
              // Add button action here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 130, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child:const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Details section
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Accounts'),
        backgroundColor: Colors.green, // Set the background color to green
        leading: IconButton(
          icon:const Icon(Icons.arrow_back_ios_new_rounded, size: 25),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: _buildHomePage(), // Display the selected page content
      ),
    );
  }
}





/////////////Staff PROFILE
class StaffProfile extends StatefulWidget {
  final User user;

  const StaffProfile({super.key, required this.user});

  @override
  State<StaffProfile> createState() => _StaffProfileState();
}

class _StaffProfileState extends State<StaffProfile> {
  File? _profileImage; // To store the selected profile image
  File? _coverImage; // To store the selected cover image
  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  // Function to pick image for profile or cover
  Future<void> _pickImage(bool isProfile) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
          // Here you can make an API call to upload the profile image
        } else {
          _coverImage = File(pickedFile.path);
          // Here you can make an API call to upload the cover image
        }
      });
    }
  }

  // Function to build the Home page content
// Function to build the Home page content
  Widget _buildHomePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Cover photo
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _coverImage != null
                      ? FileImage(_coverImage!)
                      :const NetworkImage('https://via.placeholder.com/800x300') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Camera icon for cover photo
            Positioned(
              bottom: 10,
              right: 10,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 20,
                child: IconButton(
                  icon:const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {
                    _pickImage(false); // Change cover photo
                  },
                ),
              ),
            ),

            // Profile picture positioned on top of the cover photo
            Positioned(
              top: 130,
              left: 20,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage(true); // Change profile picture when tapping the profile image
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: _profileImage != null
                          ? Image.file(
                        _profileImage!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Camera icon for profile picture
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        _pickImage(true); // Change profile picture
                      },
                      child:const CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 20,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 90),

        // User information
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.user.firstname} ${widget.user.middlename} ${widget.user.lastname}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Edit Profile button
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: ElevatedButton(
            onPressed: () {
              // Add button action here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 130, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Details section
        const Padding(
          padding: const EdgeInsets.only(top: 20, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Accounts'),
        backgroundColor: Colors.green, // Set the background color to green
        leading: IconButton(
          icon:const Icon(Icons.arrow_back_ios_new_rounded, size: 25),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: _buildHomePage(), // Display the selected page content
      ),
    );
  }
}
