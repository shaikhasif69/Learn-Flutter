import 'package:flutter/material.dart';

class ComplexListViews extends StatefulWidget {
  const ComplexListViews({super.key});

  @override
  State<ComplexListViews> createState() => _ComplexListViewsState();
}

class _ComplexListViewsState extends State<ComplexListViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced ListViews'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'E-commerce Product List',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ecommerceProductList(),
            const SizedBox(height: 30),
            
            const Text(
              'Chat Conversation List',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            chatConversationList(),
            const SizedBox(height: 30),
            
            const Text(
              'Task List with Checkboxes',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            taskListWithCheckboxes(),
            const SizedBox(height: 30),
            
            const Text(
              'Settings List',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            settingsList(),
            const SizedBox(height: 30),
            
            const Text(
              'Horizontal Card Carousel',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            horizontalCardCarousel(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget ecommerceProductList() {
    final List<Map<String, dynamic>> products = [
      {
        'name': 'Wireless Earbuds',
        'price': 79.99,
        'rating': 4.5,
        'reviews': 2356,
        'image': 'https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb',
        'inStock': true,
      },
      {
        'name': 'Smart Watch Series 5',
        'price': 299.99,
        'rating': 4.7,
        'reviews': 4217,
        'image': 'https://images.unsplash.com/photo-1546868871-7041f2a55e12',
        'inStock': true,
      },
      {
        'name': 'Bluetooth Speaker',
        'price': 59.99,
        'rating': 4.3,
        'reviews': 1432,
        'image': 'https://images.unsplash.com/photo-1589003077984-894e133dabab',
        'inStock': false,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product['image'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${product['price']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          Text(
                            ' ${product['rating']} (${product['reviews']})',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: product['inStock']
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product['inStock'] ? 'In Stock' : 'Out of Stock',
                              style: TextStyle(
                                color:
                                    product['inStock'] ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                              size: 20,
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
        },
      ),
    );
  }

  Widget chatConversationList() {
    final List<Map<String, dynamic>> chats = [
      {
        'name': 'John Smith',
        'message': 'Hey, how are you doing?',
        'time': '2:30 PM',
        'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
        'unread': 3,
        'online': true,
      },
      {
        'name': 'Emma Johnson',
        'message': 'I just sent you the documents. Let me know when you review them.',
        'time': '11:24 AM',
        'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
        'unread': 0,
        'online': false,
      },
      {
        'name': 'Michael Brown',
        'message': 'Are we still meeting tomorrow at 3?',
        'time': 'Yesterday',
        'avatar': 'https://randomuser.me/api/portraits/men/86.jpg',
        'unread': 1,
        'online': true,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: chats.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(chat['avatar']),
                    ),
                    if (chat['online'])
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 14,
                          height: 14,
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
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chat['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            chat['time'],
                            style: TextStyle(
                              color: chat['unread'] > 0
                                  ? Colors.indigo
                                  : Colors.grey[500],
                              fontWeight: chat['unread'] > 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat['message'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: chat['unread'] > 0
                                    ? Colors.black
                                    : Colors.grey[600],
                                fontWeight: chat['unread'] > 0
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (chat['unread'] > 0)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.indigo,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                chat['unread'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
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
        },
      ),
    );
  }

  Widget taskListWithCheckboxes() {
    final List<Map<String, dynamic>> tasks = [
      {
        'title': 'Complete project proposal',
        'dueDate': 'Today',
        'priority': 'High',
        'completed': false,
      },
      {
        'title': 'Schedule team meeting',
        'dueDate': 'Tomorrow',
        'priority': 'Medium',
        'completed': true,
      },
      {
        'title': 'Review client feedback',
        'dueDate': 'Mar 22',
        'priority': 'Low',
        'completed': false,
      },
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < tasks.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: tasks[i]['completed'],
                          onChanged: (bool? value) {
                            setState(() {
                              tasks[i]['completed'] = value;
                            });
                          },
                          activeColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[i]['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: tasks[i]['completed']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: tasks[i]['completed']
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Due: ${tasks[i]['dueDate']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(tasks[i]['priority'])
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    tasks[i]['priority'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _getPriorityColor(tasks[i]['priority']),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey[600],
                        ),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.indigo.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_task,
                      color: Colors.indigo,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Add New Task',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Widget settingsList() {
    final List<Map<String, dynamic>> settings = [
      {
        'title': 'Notifications',
        'subtitle': 'Manage how you receive alerts',
        'icon': Icons.notifications,
        'color': Colors.red,
        'trailing': Switch(
          value: true,
          onChanged: (value) {},
          activeColor: Colors.indigo,
        ),
      },
      {
        'title': 'Privacy',
        'subtitle': 'Control your data and permissions',
        'icon': Icons.lock,
        'color': Colors.blue,
        'trailing': const Icon(Icons.arrow_forward_ios, size: 16),
      },
      {
        'title': 'Appearance',
        'subtitle': 'Theme and display options',
        'icon': Icons.palette,
        'color': Colors.purple,
        'trailing': const Icon(Icons.arrow_forward_ios, size: 16),
      },
      {
        'title': 'Language',
        'subtitle': 'English (US)',
        'icon': Icons.language,
        'color': Colors.green,
        'trailing': const Icon(Icons.arrow_forward_ios, size: 16),
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: settings.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          indent: 70,
        ),
        itemBuilder: (context, index) {
          final setting = settings[index];
          return ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: setting['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                setting['icon'],
                color: setting['color'],
              ),
            ),
            title: Text(
              setting['title'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              setting['subtitle'],
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            trailing: setting['trailing'],
          );
        },
      ),
    );
  }

  Widget horizontalCardCarousel() {
    final List<Map<String, dynamic>> cards = [
      {
        'title': 'Beach Resort',
        'location': 'Bali, Indonesia',
        'image': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4',
        'rating': 4.8,
        'price': 299,
      },
      {
        'title': 'Mountain Retreat',
        'location': 'Swiss Alps',
        'image': 'https://images.unsplash.com/photo-1506974210756-8e1b8985d348',
        'rating': 4.9,
        'price': 349,
      },
      {
        'title': 'Luxury Villa',
        'location': 'Santorini, Greece',
        'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945',
        'rating': 4.7,
        'price': 429,
      },
    ];

    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Container(
            width: 220,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        card['image'],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              card['rating'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.indigo,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            card['location'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${card['price']}/night',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.indigo,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
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
        },
      ),
    );
  }
}