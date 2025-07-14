import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/app/app.dart';

class WeatherBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  const WeatherBar({super.key, required this.height});

  @override
  State<WeatherBar> createState() => _WeatherBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _WeatherBarState extends State<WeatherBar> {
  final List<List<dynamic>> mockData = [
    [true, false, null, null, null],
    [false, true, null, null, null],
    [false, false, 32.0, 'Sunny', AppStrings.sunnyAsset],
    [false, false, 22.0, 'Cloudy', AppStrings.cloudyAsset],
    [false, false, 18.0, 'Windy', AppStrings.windyAsset],
    [false, false, -5.0, 'Snowy', AppStrings.snowyAsset],
    [false, false, 12.0, 'Rainy', AppStrings.rainyAsset],
  ];

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % mockData.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 390,
      padding: EdgeInsets.symmetric(vertical: 5),
      // decoration: AppCards.forCommon1(context),
      // child: _buildLoading(context),
      child: mockData[_currentIndex][0]
          ? _buildLoading(context)
          : mockData[_currentIndex][1]
          ? _buildError(context)
          : _helper2(context),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Text(
            AppStrings.loadingWeather,
            style: AppTexts.bodyMedium(context),
          ),
          Lottie.asset(AppStrings.loadingWeatherAsset, width: 100, height: 100, fit: BoxFit.cover),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(CupertinoIcons.refresh, color: colorScheme.onSurface),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              AppStrings.couldntFetch,
              style: AppTexts.bodyMedium(context, color: colorScheme.onSurface),
            ),
          ),
          Lottie.asset(
            AppStrings.errorWeatherAsset,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }

  Widget _helper1(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_title(context), _locationInfo(context)],
      ),
    );
  }

  Widget _helper2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_helper1(context), _weatherInfo(context)],
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      AppStrings.weather,
      style: AppTexts.titleLarge(context),
    );
  }

  Widget _locationInfo(BuildContext context) {
    return Row(
      children: [
        AppIcons.locationIcon(context),
        SizedBox(width: 3),
        Text(
          AppStrings.location,
          style: AppTexts.labelSmall(
            context,
          ).copyWith(fontSize: 8),
        ),
      ],
    );
  }

  Widget _weatherInfo(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${mockData[_currentIndex][2]}${AppStrings.degree}',
                  style: AppTexts.headlineSmall(context, ),
                ),
                Column(
                  children: [
                    Text(
                      AppStrings.celsius,
                      style: AppTexts.titleMedium(context),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
            Text(
              mockData[_currentIndex][3],
              style: AppTexts.bodySmall(context),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Lottie.asset(mockData[_currentIndex][4], fit: BoxFit.contain, width: 80, height: 80),
        const SizedBox(width: 5),
      ],
    );
  }
}
