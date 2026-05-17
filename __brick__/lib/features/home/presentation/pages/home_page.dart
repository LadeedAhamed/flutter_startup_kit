import 'package:flutter/material.dart';

import 'package:flutter_startup_kit/app/theme/app_colors.dart';
import 'package:flutter_startup_kit/app/theme/app_spacing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _buildGreetingCard(context),
          const SizedBox(height: AppSpacing.xl),
          _buildQuickActions(context),
          const SizedBox(height: AppSpacing.xl),
          _buildRecentItems(context),
        ],
      ),
    );
  }

  Widget _buildGreetingCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primaryLight,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: AppSpacing.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Ready to build something amazing',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            _buildActionButton(context, Icons.search, 'Search'),
            const SizedBox(width: AppSpacing.md),
            _buildActionButton(context, Icons.chat_bubble_outline, 'Chat'),
            const SizedBox(width: AppSpacing.md),
            _buildActionButton(context, Icons.person_outline, 'Profile'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    return Expanded(
      child: Card(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(height: AppSpacing.sm),
                Text(label, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.md),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.grey200,
                child: const Icon(Icons.description, color: AppColors.grey600),
              ),
              title: Text('Item ${index + 1}'),
              subtitle: const Text('Recently updated'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}
