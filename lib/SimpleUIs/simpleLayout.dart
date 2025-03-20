import 'package:flutter/material.dart';

class SimpleLayout extends StatelessWidget {
  const SimpleLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Layout Examples'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cards Layout
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Card Layout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            cardLayout(),
            
            // Profile Layout
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Profile Layout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            profileLayout(),
            
            // Grid Layout
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Grid Layout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            gridLayout(),
            
            // List Layout
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'List Layout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            listLayout(),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget cardLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        color: Colors.blue,
                        child: const Icon(Icons.flight, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Travel Package',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Bali, Indonesia',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Enjoy your vacation in beautiful Bali with our premium travel package. Includes hotel and sightseeing.',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$899',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Book Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        color: Colors.orange,
                        child: const Icon(Icons.restaurant, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Food Delivery',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '30-40 min delivery time',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Order your favorite food from the best restaurants in your area with fast delivery.',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber[700], size: 20),
                          const SizedBox(width: 4),
                          const Text(
                            '4.8 (256 reviews)',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('Order'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileLayout() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 16),
              const SizedBox(width: 4),
              const Text('Mumbai, India'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStat('Posts', '28'),
              _buildProfileStat('Followers', '846'),
              _buildProfileStat('Following', '162'),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
              padding: const EdgeInsets.symmetric(horizontal: 40),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
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

  Widget gridLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildGridItem(Icons.home, 'Home', Colors.blue),
          _buildGridItem(Icons.shopping_cart, 'Shop', Colors.green),
          _buildGridItem(Icons.favorite, 'Favorites', Colors.red),
          _buildGridItem(Icons.settings, 'Settings', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget listLayout() {
    final items = [
      {'title': 'Inbox', 'icon': Icons.inbox, 'color': Colors.blue},
      {'title': 'Starred', 'icon': Icons.star, 'color': Colors.amber},
      {'title': 'Sent', 'icon': Icons.send, 'color': Colors.green},
      {'title': 'Drafts', 'icon': Icons.drafts, 'color': Colors.grey},
      {'title': 'Trash', 'icon': Icons.delete, 'color': Colors.red},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: item['color'] as Color,
            child: Icon(
              item['icon'] as IconData,
              color: Colors.white,
            ),
          ),
          title: Text(item['title'] as String),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        );
      },
    );
  }
}