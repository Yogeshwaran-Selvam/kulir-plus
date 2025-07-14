import 'package:flutter/material.dart';
import '/app/app.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
        _buildProfileCard(context),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
        _buildTile(context, "Help", Icons.help, () => AppRouter.push(context, RouteNames.chat)),
        _buildTile(context, 'Contact Us', Icons.call, () => AppRouter.push(context, RouteNames.contactUs),),
        _buildTile(context, 'About App', Icons.info_outline, () => AppRouter.push(context, RouteNames.about)),
        _buildTile(
          context,
          "Notifications",
          Icons.notifications,
           () {},
          badgeCount: 3,
        ),
        _buildTile(context, 'Smart Service', Icons.miscellaneous_services,
          () {},
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 25)),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 400,
            height: 300,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: isDark
                    ? [Colors.black, Colors.transparent, Colors.white]
                    : [Colors.black, Colors.grey[200]!, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 25,
                  child: InkWell(
                    onTap: () => deleteAccount(context),
                    child: AppIcons.deleteIcon(context, Colors.red.shade500),
                  )
                ),
                Positioned(
                  top: 10,
                  right: 75,
                  child: InkWell(
                    onTap: () => signOut(context),
                    child: Icon(Icons.exit_to_app_rounded, color: Colors.pink),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: AppLotties.profileLottie(context),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
                      Text(
                        'Alex',
                        style: AppTexts.titleLarge(
                          context,
                          font: AppFont.aDLaMDisplay,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Online",
                        style: AppTexts.bodyLarge(context, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    String title,
    IconData icon, 
    VoidCallback fn,
    {
    int badgeCount = 0,
  }) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Theme.of(context).colorScheme.onSurface,
          child: ListTile(
            leading: Icon(icon, color: Colors.blue.withAlpha(200)),
            title: Text(title, style: AppTexts.bodyMedium(context)),
            trailing: badgeCount > 0
                ? Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "$badgeCount",
                      style: AppTexts.bodySmall(context, color: Colors.white),
                    ),
                  )
                : const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            // onTap: () => fn(),
          ),
        ),
      ),
    );
  }


  static Future signOut(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Sign Out',
            style: AppTexts.bodyLarge(context, color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: AppTexts.bodyMedium(context, color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => AppRouter.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => AppRouter.replace(
                context,
                RouteNames.auth,
                transition: RouteTransitions.fadeTransition,
              ),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  static Future deleteAccount(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete Account',
            style: AppTexts.bodyLarge(context, color: Colors.white, font: AppFont.aDLaMDisplay),
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: AppTexts.bodyMedium(context, color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => AppRouter.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => AppRouter.replace(
                context,
                RouteNames.auth,
                transition: RouteTransitions.fadeTransition,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
