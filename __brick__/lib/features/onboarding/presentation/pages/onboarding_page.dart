import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../app/routes/route_paths.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingItem> _items = const [
    _OnboardingItem(
      icon: Icons.rocket_launch,
      title: 'Welcome to StartupKit',
      description: 'A production-ready Flutter foundation with Clean Architecture and Bloc.',
    ),
    _OnboardingItem(
      icon: Icons.build_circle,
      title: 'Enterprise Ready',
      description: 'Built with scalability, maintainability, and team productivity in mind.',
    ),
    _OnboardingItem(
      icon: Icons.speed,
      title: 'Get Started',
      description: 'Clone, configure, and start building your next great app.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemCount: _items.length,
                itemBuilder: (context, index) => _buildPage(_items[index]),
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            size: 100,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          Text(
            item.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.grey600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _items.length,
              (index) => _buildDot(index),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          AppButton(
            label: _currentPage == _items.length - 1 ? 'Get Started' : 'Next',
            onPressed: () {
              if (_currentPage == _items.length - 1) {
                context.go(RoutePaths.login);
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          if (_currentPage < _items.length - 1) ...[
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () => context.go(RoutePaths.login),
              child: const Text('Skip'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.primary : AppColors.grey300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _OnboardingItem {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
