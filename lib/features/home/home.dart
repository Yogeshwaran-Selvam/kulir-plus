import 'package:flutter/material.dart';
import '/features/features.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _homeSlideAnimation;
  late Animation<Offset> _scheduleSlideAnimation;
  late Animation<Offset> _menuSlideAnimation;
  double schedulesXOffset = -1;
  double homeXOffset = 0;
  double menuXOffset = 1;
  bool dontHideHome = true;
  bool isCurrHome = true;
  bool isModeChange = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scheduleSlideAnimation = Tween<Offset>(
      begin: Offset(schedulesXOffset, 0),
      end: Offset(schedulesXOffset, 0),
    ).animate(_controller);

    _homeSlideAnimation = Tween<Offset>(
      begin: Offset(homeXOffset, 0),
      end: Offset(homeXOffset, 0),
    ).animate(_controller);

    _menuSlideAnimation = Tween<Offset>(
      begin: Offset(menuXOffset, 0),
      end: Offset(menuXOffset, 0),
    ).animate(_controller);
  }

  void _setSlideAnimations() {
    _scheduleSlideAnimation = Tween<Offset>(
      begin: _scheduleSlideAnimation.value,
      end: Offset(schedulesXOffset, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _homeSlideAnimation = Tween<Offset>(
      begin: _homeSlideAnimation.value,
      end: Offset(homeXOffset, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _menuSlideAnimation = Tween<Offset>(
      begin: _menuSlideAnimation.value,
      end: Offset(menuXOffset, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _onPageSelected(int index) {
    switch (index) {
      case 1: // home
        setState(() {
          isCurrHome =  dontHideHome = true;
        });
        schedulesXOffset = -1;
        homeXOffset = 0;
        menuXOffset = 1;
        break;
      case 0: // schedules
        setState(() {
          dontHideHome = isCurrHome;
        });
        isCurrHome = false;
        schedulesXOffset = 0;
        homeXOffset = 1;
        menuXOffset = 1;
        break;
      case 2: // menu
        setState(() {
          dontHideHome = isCurrHome;
        });
        isCurrHome = false;
        schedulesXOffset = -1;
        homeXOffset = -1;
        menuXOffset = 0;
        break;
    }

    setState(() {
      _setSlideAnimations();
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _buildScheduleSlider(context),
          _buildMenuSlider(context),
          Visibility(visible: dontHideHome, child: _buildHomeSlider(context)),
        ],
      ),
      bottomNavigationBar: BottomNavigator(onTap: _onPageSelected),
    );
  }

  Widget _buildHomeSlider(BuildContext context) {
    return SlideTransition(
      position: _homeSlideAnimation,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 25)),
            CustomAppBar(
              onChangeGrade: () async {
                setState(() => isModeChange = !isModeChange);
              },
            ),
            AllRooms(),
            MonthlyUsage(),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSlider(BuildContext context) {
    return SlideTransition(
      position: _scheduleSlideAnimation,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.surface,
        child: SchedulesBody(),
      ),
    );
  }

  Widget _buildMenuSlider(BuildContext context) {
    return SlideTransition(
      position: _menuSlideAnimation,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.surface,
        child: MenuBody(),
      ),
    );
  }
}
