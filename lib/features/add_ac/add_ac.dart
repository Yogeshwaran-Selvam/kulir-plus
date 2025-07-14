import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '/app/app.dart';

class AddACPage extends StatefulWidget {
  const AddACPage({super.key});

  @override
  State<AddACPage> createState() => _AddACPageState();
}

class _AddACPageState extends State<AddACPage> {
  final ValueNotifier<int> selectedSvg = ValueNotifier(0);
  final ValueNotifier<int> selectedLottie = ValueNotifier(0);
  final TextEditingController nicknameController = TextEditingController();

  final svgAssets = [
    AppStrings.bedroomAsset,
    AppStrings.hallwayAsset,
    AppStrings.kitchenAsset,
    AppStrings.livingroomAsset,
    AppStrings.officeAsset,
  ];

  final lottieAssets = [
    AppStrings.bedroom,
    AppStrings.kitchen,
    AppStrings.livingroom,
    AppStrings.office,
  ];

  bool isFound = false;
  bool isConnected = false;
  bool isVisible = false;
  bool isRepeat = true;
  final random = Random();
  Timer? toggleTimer;

  @override
  void initState() {
    super.initState();
    toggleTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) {
        setState(() => isFound = !isFound);
      }
    });
  }

  @override
  void dispose() {
    toggleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 75,
        leading: const BackButton(),
        title: Text(
          "Add AC",
          style: AppTexts.headlineLarge(context, font: AppFont.aDLaMDisplay),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          AppRouter.pop(context);
        },
        icon: const Icon(Icons.save),
        label: Text(
          "Save",
          style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 400,
                      child: isConnected
                          ? Visibility(
                            visible: isVisible,
                            child: Lottie.asset(
                                AppStrings.successfulAsset,
                                fit: BoxFit.fill,
                                repeat: isRepeat,
                              ),
                            )
                          : Lottie.asset(
                              AppStrings.searcherAsset,
                              fit: BoxFit.fill,
                            ),
                    ),
                    if (!isConnected && isFound)
                      Positioned(
                        top: random.nextInt(150).toDouble(),
                        left: random.nextInt(300).toDouble(),
                        child: IconButton(
                          onPressed: () async {
                            setState(() => isConnected = true);
                            await Future.delayed(Duration(milliseconds: 100));
                            setState(() => isVisible = true);
                            await Future.delayed(Duration(milliseconds: 2000));
                            setState(() => isRepeat = false);
                          },
                          icon: Icon(
                            Icons.bluetooth,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          isConnected
                              ? 'A device is connected...'
                              : isFound
                              ? 'A device found, click it to connect...'
                              : 'Searching for device, wait for it...',
                          style: AppTexts.labelLarge(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: nicknameController,
                decoration: InputDecoration(
                  labelText: "AC Nickname",
                  labelStyle: AppTexts.bodyLarge(
                    context,
                    font: AppFont.aDLaMDisplay,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildSvgSelector(context, theme),
              const SizedBox(height: 30),
              _buildLottieSelector(context, theme),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSvgSelector(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Room Icon:",
          style: AppTexts.titleMedium(context, font: AppFont.aDLaMDisplay),
        ),
        const SizedBox(height: 15),
        ValueListenableBuilder(
          valueListenable: selectedSvg,
          builder: (_, value, __) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Row(
              key: ValueKey(value),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(svgAssets.length, (index) {
                return GestureDetector(
                  onTap: () => selectedSvg.value = index,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: value == index
                        ? theme.colorScheme.primary
                        : Colors.grey.shade800,
                    child: SvgPicture.asset(
                      svgAssets[index],
                      width: 30,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLottieSelector(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Room Animation:",
          style: AppTexts.titleMedium(context, font: AppFont.aDLaMDisplay),
        ),
        const SizedBox(height: 15),
        ValueListenableBuilder(
          valueListenable: selectedLottie,
          builder: (_, value, __) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Wrap(
              key: ValueKey(value),
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: List.generate(lottieAssets.length, (index) {
                return GestureDetector(
                  onTap: () => selectedLottie.value = index,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: value == index
                            ? theme.colorScheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Lottie.asset(lottieAssets[index]),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
