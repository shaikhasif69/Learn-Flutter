import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String statusMessage = "Click the button to change status!";

  void updateStatus() {
    setState(() {
      statusMessage = "You have successfully updated the status!";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSI Profile'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(78), // Image radius
                child: Image.asset('images/catProfile.jpg', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),

            // User Name
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // User Bio
            const Text(
              'Flutter Developer | Cat Enthusiast | Loves to code and share knowledge!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),

            // Info Section (like email, location)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.email, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text('johndoe@example.com'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.location_on, color: Colors.redAccent),
                SizedBox(width: 8),
                Text('Mumbai, India'),
              ],
            ),
            const SizedBox(height: 24),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Followers
                Column(
                  children: const [
                    Text(
                      "150",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Followers"),
                  ],
                ),
                // Posts
                Column(
                  children: const [
                    Text(
                      "35",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Posts"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Edit Profile Button
                Text(
              statusMessage,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

              ElevatedButton(
              onPressed: updateStatus,
              child: const Text("Update Status"),
            ),

            const SizedBox(height: 24),

            // Hobbies/Interests Section
            const Text(
              'Hobbies & Interests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.music_note, color: Colors.purple),
                SizedBox(width: 8),
                Text('Playing Ukulele'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.code, color: Colors.green),
                SizedBox(width: 8),
                Text('Coding with Flutter'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.pets, color: Colors.orange),
                SizedBox(width: 8),
                Text('Playing with Cats'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
