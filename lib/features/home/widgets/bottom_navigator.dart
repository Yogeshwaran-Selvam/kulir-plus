import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '/app/app.dart';

class BottomNavigator extends StatefulWidget {
  final ValueChanged<int> onTap;

  const BottomNavigator({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<BottomNavigator>
    with SingleTickerProviderStateMixin {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.bottomCenter,
        children: [
          ClipPath(
            clipper: _OvalTopClipper(),
            child: Container(
              height: 100,
              decoration: AppCards.forBottomNavigator(context),
            ),
          ),
          _buildMainWidget(context),
        ],
      ),
    );
  }

  void _onTap(int index) {
    widget.onTap(index);
    currentIndex = index;
  }

  Widget _buildMainWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<TabItem> items = [
      TabItem(
        icon: AppIcons.schedules(context, currentIndex == 0),
        title: AppStrings.schedules,
      ),
      TabItem(
        icon: AppIcons.home(context, currentIndex == 1),
        title: AppStrings.home,
      ),
      TabItem(
        icon: AppIcons.menu(context, currentIndex == 2),
        title: AppStrings.menu,
      ),
    ];

    return SizedBox(
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DefaultTextStyle(
            style: AppTexts.forBotNavi(context),
            child: ConvexAppBar(
              height: 60,
              curve: Curves.ease,
              style: TabStyle.reactCircle,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              activeColor: colorScheme.onSurface,
              color: Colors.white,
              items: items,
              initialActiveIndex: currentIndex,
              onTap: (index) => _onTap(index),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _OvalTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addOval(Rect.fromLTWH(-50, 0, size.width + 100, size.height + 100));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
