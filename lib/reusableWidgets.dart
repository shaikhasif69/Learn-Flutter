import 'package:flutter/material.dart';

class ReusableWidgets extends StatelessWidget {
  final String widgetToShow;
  
  const ReusableWidgets({
    super.key,
    required this.widgetToShow,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget: $widgetToShow'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: _getSelectedWidget(widgetToShow),
      ),
    );
  }

  Widget _getSelectedWidget(String widgetName) {
    switch (widgetName) {
      case 'CustomAppBar':
        return const CustomAppBarExample();
      case 'BottomNavBar':
        return const BottomNavBarExample();
      case 'BasicCard':
        return const BasicCardExample();
      case 'ImageCard':
        return const ImageCardExample();
      case 'RoundedButton':
        return const RoundedButtonExample();
      case 'GradientButton':
        return const GradientButtonExample();
      case 'IconTextRow':
        return const IconTextRowExample();
      case 'ProfileAvatar':
        return const ProfileAvatarExample();
      case 'NotificationBadge':
        return const NotificationBadgeExample();
      case 'SimpleSearchBar':
        return const SimpleSearchBarExample();
      case 'SimpleToggleSwitch':
        return const SimpleToggleSwitchExample();
      case 'SimpleDialog':
        return const SimpleDialogExample();
      case 'DividerWithText':
        return const DividerWithTextExample();
      case 'CircularProgressWithLabel':
        return const CircularProgressWithLabelExample();
      case 'StatsRow':
        return const StatsRowExample();
      case 'TagList':
        return const TagListExample();
      case 'SimpleGridView':
        return const SimpleGridViewExample();
      default:
        return const Text('Widget not found');
    }
  }
}

// 1. Custom AppBar
class CustomAppBarExample extends StatelessWidget {
  const CustomAppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Custom AppBar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: Text(
                      'Page Title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How to use:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '1. This custom app bar can be placed at the top of your Scaffold\n'
                '2. Customize title, back button, and actions\n'
                '3. Easily change colors and elevation',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 2. Bottom Navigation Bar
class BottomNavBarExample extends StatefulWidget {
  const BottomNavBarExample({super.key});

  @override
  State<BottomNavBarExample> createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Selected Tab: ${_selectedIndex + 1}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
            color: Colors.white,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 3. Basic Card
class BasicCardExample extends StatelessWidget {
  const BasicCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Basic Card Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Card 1 - Basic card with shadow
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Basic Card with Shadow',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card has padding and elevation for a shadow effect.',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Card 2 - Rounded corners and colored border
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Colors.blue.shade300,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card with Rounded Corners & Border',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This card has rounded corners and a colored border.',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Card 3 - Card with header
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.blue,
                  width: double.infinity,
                  child: const Text(
                    'Card with Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'This card includes a colored header section.',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Image Card
class ImageCardExample extends StatelessWidget {
  const ImageCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Image Card Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Image card with overlay text
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1501854140801-50d01698950b',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Mountain View',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Beautiful landscape photography',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Card with image and content
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cafe Restaurant',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enjoy the cozy atmosphere and wonderful food.',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber[700],
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '4.8',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(128 reviews)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 5. Rounded Button
class RoundedButtonExample extends StatelessWidget {
  const RoundedButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rounded Button Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Basic rounded button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Basic Rounded Button',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Outlined rounded button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: const BorderSide(color: Colors.blue, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Outlined Rounded Button',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Icon button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.cloud_upload),
              label: const Text(
                'Upload File',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Circular button
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
              ),
              child: const Icon(
                Icons.add,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 6. Gradient Button
class GradientButtonExample extends StatelessWidget {
  const GradientButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gradient Button Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Blue gradient button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.indigo],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Blue Gradient Button',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Pink-Orange gradient button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [Colors.pink, Colors.orange],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Pink-Orange Gradient Button',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Green gradient button with icon
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.teal],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check_circle),
              label: const Text(
                'Success Gradient Button',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 7. Icon Text Row
class IconTextRowExample extends StatelessWidget {
  const IconTextRowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Icon Text Row Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Basic icon text row
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 12),
                Text(
                  'example@email.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Icon text row with background
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                SizedBox(width: 12),
                Text(
                  'New York, USA',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Icon text row with subtitle
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone, color: Colors.green),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '+1 (123) 456-7890',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Primary Contact',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Icon text row with trailing info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.purple),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Team Meeting',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '3:00 PM',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 8. Profile Avatar
class ProfileAvatarExample extends StatelessWidget {
  const ProfileAvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profile Avatar Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Basic circular avatar
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Text(
                    'JD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Basic Circular Avatar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Avatar with image
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/32.jpg',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Image Avatar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Avatar with border
          Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                      width: 3,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/women/44.jpg',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Avatar with Border',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Avatar with status indicator
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/86.jpg',
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Avatar with Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 9. Notification Badge
class NotificationBadgeExample extends StatelessWidget {
  const NotificationBadgeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notification Badge Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          
          // Basic notification badge
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    const Icon(Icons.notifications, size: 36),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Badge with Multiple Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Badge on button
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Cart'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: -5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Badge on Button',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 10. Simple Search Bar
class SimpleSearchBarExample extends StatelessWidget {
  const SimpleSearchBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Search Bar Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Basic search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Basic Search Bar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          
          const SizedBox(height: 30),
          
          // Rounded search bar with background
          TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {},
              ),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Rounded Search Bar with Background',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          
          const SizedBox(height: 30),
          
          // Search bar with filter button
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Search Bar with Filter Button',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// 11. Simple Toggle Switch
class SimpleToggleSwitchExample extends StatefulWidget {
  const SimpleToggleSwitchExample({super.key});

  @override
  State<SimpleToggleSwitchExample> createState() =>
      _SimpleToggleSwitchExampleState();
}

class _SimpleToggleSwitchExampleState extends State<SimpleToggleSwitchExample> {
  bool _switch1 = false;
  bool _switch2 = true;
  bool _switch3 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Toggle Switch Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          
          // Basic switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(fontSize: 16),
              ),
              Switch(
                value: _switch1,
                onChanged: (value) {
                  setState(() {
                    _switch1 = value;
                  });
                },
              ),
            ],
          ),
          Divider(color: Colors.grey[300]),
          
          // Customized switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Change app theme',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _switch2,
                onChanged: (value) {
                  setState(() {
                    _switch2 = value;
                  });
                },
                activeColor: Colors.indigo,
              ),
            ],
          ),
          Divider(color: Colors.grey[300]),
          
          // Switch with custom background
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.do_not_disturb,
                      color: _switch3 ? Colors.red : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Do Not Disturb',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Switch(
                  value: _switch3,
                  onChanged: (value) {
                    setState(() {
                      _switch3 = value;
                    });
                  },
                  activeColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 12. Simple Dialog
class SimpleDialogExample extends StatelessWidget {
  const SimpleDialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _showAlertDialog(context);
            },
            child: const Text('Show Alert Dialog'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showConfirmDialog(context);
            },
            child: const Text('Show Confirm Dialog'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showCustomDialog(context);
            },
            child: const Text('Show Custom Dialog'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('This is a simple alert dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Action'),
          content: const Text('Are you sure you want to proceed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform action on confirm
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Action confirmed!'),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 64,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Success!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your operation has been completed successfully.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 13. Divider With Text
class DividerWithTextExample extends StatelessWidget {
  const DividerWithTextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Divider With Text Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          
          // Basic divider with text
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          // Styled divider with text
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.2),
                        Colors.blue,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'SECTION',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.blue.withOpacity(0.2),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          // Section divider
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'FEATURED PRODUCTS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 14. Circular Progress With Label
class CircularProgressWithLabelExample extends StatelessWidget {
  const CircularProgressWithLabelExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Circular Progress Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          
          // Basic circular progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProgressWithLabel(0.25, '25%', Colors.blue),
              _buildProgressWithLabel(0.5, '50%', Colors.green),
              _buildProgressWithLabel(0.75, '75%', Colors.orange),
            ],
          ),
          const SizedBox(height: 40),
          
          // Progress with icon
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: 0.68,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      size: 40,
                      color: Colors.purple,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '68%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Uploading...',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressWithLabel(double value, String label, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Progress',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

// 15. Stats Row
class StatsRowExample extends StatelessWidget {
  const StatsRowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stats Row Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          
          // Basic stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat('Posts', '248'),
              _buildVerticalDivider(),
              _buildStat('Followers', '12.3K'),
              _buildVerticalDivider(),
              _buildStat('Following', '284'),
            ],
          ),
          const SizedBox(height: 30),
          
          // Stats row with icons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconStat(Icons.visibility, '1.5K', 'Views'),
                _buildIconStat(Icons.favorite, '423', 'Likes'),
                _buildIconStat(Icons.comment, '48', 'Comments'),
                _buildIconStat(Icons.share, '16', 'Shares'),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // Colored stats cards
          Row(
            children: [
              Expanded(child: _buildStatCard('Sales', '\$12,845', Colors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Orders', '248', Colors.orange)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Customers', '1,024', Colors.green)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildIconStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// 16. Tag List
class TagListExample extends StatelessWidget {
  const TagListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tag List Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Basic tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTag('Flutter'),
              _buildTag('Dart'),
              _buildTag('Mobile'),
              _buildTag('App Development'),
              _buildTag('UI'),
              _buildTag('Cross-Platform'),
            ],
          ),
          const SizedBox(height: 30),
          
          // Colored tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildColoredTag('Design', Colors.purple),
              _buildColoredTag('Coding', Colors.blue),
              _buildColoredTag('Testing', Colors.green),
              _buildColoredTag('Deployment', Colors.orange),
              _buildColoredTag('Maintenance', Colors.red),
            ],
          ),
          const SizedBox(height: 30),
          
          // Tags with remove option
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildRemovableTag('JavaScript'),
              _buildRemovableTag('Python'),
              _buildRemovableTag('Java'),
              _buildRemovableTag('C#'),
              _buildRemovableTag('PHP'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildColoredTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildRemovableTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              size: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// 17. Simple Grid View
class SimpleGridViewExample extends StatelessWidget {
  const SimpleGridViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Grid View Examples',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Category grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildCategoryItem(Icons.home, 'Home', Colors.blue),
              _buildCategoryItem(Icons.shopping_bag, 'Shop', Colors.green),
              _buildCategoryItem(Icons.favorite, 'Favorites', Colors.red),
              _buildCategoryItem(Icons.notifications, 'Alerts', Colors.amber),
              _buildCategoryItem(Icons.settings, 'Settings', Colors.purple),
              _buildCategoryItem(Icons.person, 'Profile', Colors.teal),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Photo grid
          const Text(
            'Photo Grid',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: [
              _buildPhotoItem('https://images.unsplash.com/photo-1506744038136-46273834b3fb'),
              _buildPhotoItem('https://images.unsplash.com/photo-1501785888041-af3ef285b470'),
              _buildPhotoItem('https://images.unsplash.com/photo-1444876170292-d2d3283ee906'),
              _buildPhotoItem('https://images.unsplash.com/photo-1452057810740-59d3cf35c97d'),
              _buildPhotoItem('https://images.unsplash.com/photo-1555445091-5a8b655e8a4a'),
              _buildPhotoItem('https://images.unsplash.com/photo-1555446980-9daee18c0a3a'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoItem(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
                         