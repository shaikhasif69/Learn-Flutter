import 'package:flutter/material.dart';

class ComplexButtons extends StatefulWidget {
  const ComplexButtons({super.key});

  @override
  State<ComplexButtons> createState() => _ComplexButtonsState();
}

class _ComplexButtonsState extends State<ComplexButtons> {
  bool isSubscribed = false;
  bool isDarkMode = false;
  int selectedIndex = 0;
  double sliderValue = 0.7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Buttons'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gradient Buttons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                gradientButton(
                  'Login',
                  const [Color(0xFF6448FE), Color(0xFF5FC6FF)],
                  Icons.login,
                ),
                gradientButton(
                  'Sign Up',
                  const [Color(0xFFFE6197), Color(0xFFFFB463)],
                  Icons.person_add,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Animated Toggle Buttons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                subscriptionToggleButton(),
                darkModeToggleButton(),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Floating Action Buttons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customFloatingActionButton(
                  Icons.add,
                  Colors.green,
                  'Add Item',
                ),
                customFloatingActionButton(
                  Icons.favorite,
                  Colors.red,
                  'Like',
                ),
                customFloatingActionButton(
                  Icons.share,
                  Colors.blue,
                  'Share',
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Custom Segmented Control',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            customSegmentedControl(),
            const SizedBox(height: 30),
            const Text(
              'Animated Loading Button',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            loadingButton(),
            const SizedBox(height: 30),
            const Text(
              'Interactive Slider Button',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            sliderButton(),
            const SizedBox(height: 30),
            const Text(
              'Social Media Buttons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                socialMediaButton(
                  'f',
                  const Color(0xFF1877F2),
                  'Facebook',
                ),
                socialMediaButton(
                  'G',
                  const Color(0xFFEA4335),
                  'Google',
                ),
                socialMediaButton(
                  'in',
                  const Color(0xFF0A66C2),
                  'LinkedIn',
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Call-to-Action Buttons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            callToActionButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget gradientButton(String text, List<Color> colors, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget subscriptionToggleButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSubscribed = !isSubscribed;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSubscribed ? Colors.green : Colors.grey[300],
          boxShadow: [
            BoxShadow(
              color: isSubscribed
                  ? Colors.green.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isSubscribed
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      key: ValueKey('check'),
                    )
                  : const Icon(
                      Icons.notifications_off,
                      color: Colors.black54,
                      key: ValueKey('bell'),
                    ),
            ),
            const SizedBox(width: 8),
            Text(
              isSubscribed ? 'Subscribed' : 'Subscribe',
              style: TextStyle(
                color: isSubscribed ? Colors.white : Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget darkModeToggleButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkMode = !isDarkMode;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 110,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          border: Border.all(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isDarkMode ? 60 : 5,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode ? Colors.grey[700] : Colors.amber,
                ),
                child: Center(
                  child: Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    color: isDarkMode ? Colors.white : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customFloatingActionButton(
      IconData icon, Color color, String tooltip) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 30),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 5),
        Text(
          tooltip,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget customSegmentedControl() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildSegmentItem('Day', 0),
          _buildSegmentItem('Week', 1),
          _buildSegmentItem('Month', 2),
          _buildSegmentItem('Year', 3),
        ],
      ),
    );
  }

  Widget _buildSegmentItem(String text, int index) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingButton() {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Processing...',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget sliderButton() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[200],
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Colored progress background
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: MediaQuery.of(context).size.width * sliderValue,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Colors.orangeAccent, Colors.redAccent],
                  ),
                ),
              ),
              // Slider thumb
              Positioned(
                left: (MediaQuery.of(context).size.width - 80) * sliderValue,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      sliderValue += details.delta.dx /
                          (MediaQuery.of(context).size.width - 80);
                      sliderValue = sliderValue.clamp(0.0, 1.0);
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              // Label
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Text(
                    'Slide to confirm',
                    style: TextStyle(
                      color: sliderValue > 0.5 ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${(sliderValue * 100).toInt()}% completed',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget socialMediaButton(String label, Color color, String platform) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          platform,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget callToActionButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF416C).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'GET STARTED NOW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}