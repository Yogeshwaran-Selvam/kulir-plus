import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';
import 'widgets/widgets.dart';

class AcDetails extends StatefulWidget {
  final ACModel ac;

  const AcDetails({super.key, required this.ac});

  @override
  State<AcDetails> createState() => _AcDetailsState();
}

class _AcDetailsState extends State<AcDetails> {
  late ACModel ac;
  late final PageController _pageController;
  int _selectedIndex = 1;
  final items = [Icons.schedule, Icons.tune, Icons.insights, Icons.build];

  @override
  void initState() {
    super.initState();
    ac = widget.ac;
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: _selectedIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget title =
        Text(
              ac.nickname,
              style: AppTexts.displayMedium(
                context,
                font: AppFont.aDLaMDisplay,
              ),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1500.ms, color: Colors.lightBlue)
            .animate()
            .fadeIn(duration: 1500.ms, curve: Curves.easeOutQuad)
            .slide();

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: Center(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.withAlpha(200),
            child: IconButton(
              onPressed: () => AppRouter.pop(context),
              icon: AppIcons.backIcon(context),
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.withAlpha(200),
            child: Icon(Icons.edit),
          ),
          SizedBox(width: 15),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.withAlpha(200),
            child: AppIcons.deleteIcon(context),
          ),
          const SizedBox(width: 20),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        animationDuration: const Duration(milliseconds: 400),
        onTap: _onItemTapped,
        items: List.generate(items.length, (index) {
          final isSelected = _selectedIndex == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: Colors.transparent,
            child: Icon(
              items[index],
              color: isSelected ? Colors.white : Colors.grey,
              size: 30,
              shadows: isSelected
                  ? [
                      Shadow(
                        blurRadius: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ]
                  : [],
            ),
          );
        }),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppLotties.forACRoom(ac.nickname),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppLotties.forACDetails(),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 100, 0, 0),
              child: title,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 15, 0),
              child: Selector<ACProvider, bool>(
                selector: (_, provider) => provider.getById(ac.id).isPowerOn,
                builder: (_, isPowerOn, __) => CircleAvatar(
                  radius: 25,
                  backgroundColor: isPowerOn ? Colors.green : Colors.red,
                  child: IconButton(
                    onPressed: () => Provider.of<ACProvider>(
                      context,
                      listen: false,
                    ).togglePower(ac.id),
                    icon: AppIcons.bigPowerIcon(context),
                  ),
                ),
              ),
            ),
          ),
          _buildPageBuilder(context),
        ],
      ),
    );
  }

  Widget _buildPageBuilder(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: SizedBox(
          height: 500,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 4,
            hitTestBehavior: HitTestBehavior.translucent,
            onPageChanged: (index) => setState(() => _selectedIndex = index),
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = ((_pageController.page ?? _selectedIndex) - index)
                        .toDouble();
                    value = (1 - (value.abs() * 0.3)).clamp(0.925, 1.0);
                  }

                  return Transform.scale(
                    scale: value,
                    child: AnimatedContainer(
                      color: Colors.transparent,
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: [
                          SchedulesView(acId: ac.id),
                          CoreControls(ac: ac),
                          InsightsView(),
                          MaintenanceControls(ac: ac),
                        ][index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
