import 'package:flutter/material.dart';
import 'login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  // Data dari gabungan 3 CSS kamu
  final List<Map<String, String>> _data = [
    {
      "title": "Discover Eco-Friendly Products",
      "desc": "Browse through a wide range of sustainable and env",
    },
    {
      "title": "Book Environmental Services",
      "desc": "Connect with service providers for recycling, clea",
    },
    {
      "title": "Support Sustainable Living",
      "desc": "Join our community and make a positive impact on t",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 23.99, right: 23.99, bottom: 31.98),
          child: Column(
            children: [
              // SKIP BUTTON (Container order: 0)
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _finishOnboarding(),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF6A7282),
                    ),
                  ),
                ),
              ),

              // MAIN CONTENT (Container order: 1)
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ICON BOX
                        Container(
                          width: 127.99,
                          height: 127.99,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8F5E9),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              _getIcon(index),
                              size: 64,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                        const SizedBox(height: 47.98),
                        
                        // TITLE (h2)
                        Text(
                          _data[index]['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            height: 1.33,
                            color: Color(0xFF101828),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // DESCRIPTION (p)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            _data[index]['desc']!,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              height: 1.5,
                              color: Color(0xFF4A5565),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // DOTS INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  bool isActive = _currentIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 31.99 : 8.0,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFF2E7D32) : const Color(0xFFD1D5DC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 47.98),

              // NEXT / GET STARTED BUTTON (motion.button)
              SizedBox(
                width: 344.89,
                height: 47.97,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (_currentIndex == 2) {
                      _finishOnboarding();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _currentIndex == 2 ? "Get Started" : "Next",
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    if (index == 0) return Icons.shopping_bag_outlined;
    if (index == 1) return Icons.build_outlined;
    return Icons.eco_outlined; // Ikon untuk Onboarding-3
  }

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}