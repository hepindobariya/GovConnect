import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutralLight,
      appBar: AppBar(
        title: Text('home_title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gujarat Scope Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.ashokaBlue, Color(0xFF1E88E5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.ashokaBlue.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'gujarat_only'.tr(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Header for Categories
            Text(
              'Categories',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 12),
            // Category list (Horizontal chips)
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryChip(context, '🎓 Education', true),
                  _buildCategoryChip(context, '🌾 Agriculture', false),
                  _buildCategoryChip(context, '👵 Pension', false),
                  _buildCategoryChip(context, '👩 Women Care', false),
                  _buildCategoryChip(context, '💼 Business / MSME', false),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Header for Recommended Schemes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended for you',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Mock Scheme Cards
            _buildMockSchemeCard(
              context: context,
              title: 'PM-KISAN (Gujarat Farmer Subsidy)',
              benefit: '₹6,000/year in 3 installments',
              level: 'Central Scheme',
              daysRemaining: 'Open',
              iconText: '🌾',
            ),
            const SizedBox(height: 16),
            _buildMockSchemeCard(
              context: context,
              title: 'Digital Gujarat Scholarship',
              benefit: 'Up to 100% tuition fee waiver',
              level: 'Gujarat State Scheme',
              daysRemaining: '12 days left',
              iconText: '🎓',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppTheme.ashokaBlue,
        unselectedItemColor: AppTheme.neutralMid,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: AppTheme.ashokaBlue.withValues(alpha: 0.15),
        labelStyle: GoogleFonts.inter(
          color: isSelected ? AppTheme.ashokaBlue : AppTheme.neutralDark,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: isSelected ? AppTheme.ashokaBlue : AppTheme.neutralMid.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }

  Widget _buildMockSchemeCard({
    required BuildContext context,
    required String title,
    required String benefit,
    required String level,
    required String daysRemaining,
    required String iconText,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.neutralLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    iconText,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        level,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.neutralMid,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_outline, color: AppTheme.neutralMid),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Benefits',
                      style: GoogleFonts.inter(
                        color: AppTheme.neutralMid,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      benefit,
                      style: GoogleFonts.inter(
                        color: AppTheme.ashokaBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.indiaGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppTheme.indiaGreen, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'Eligible',
                        style: GoogleFonts.inter(
                          color: AppTheme.indiaGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
