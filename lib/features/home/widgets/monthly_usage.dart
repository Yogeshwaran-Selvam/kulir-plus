import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '/app/app.dart';
import '/core/core.dart';
import 'widgets.dart';

class MonthlyUsage extends StatefulWidget {
  const MonthlyUsage({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MonthlyUsage> {
  bool _showAll = false;
  bool _isUSD = false;
  late List<ACModel> _acList;
  late Timer _timer;
  final format = NumberFormat('#,##0', 'en_IN');

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
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _isUSD = !_isUSD;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _acList = Provider.of<ACProvider>(context).sortByCost(ascending: false);

    return SliverList.list(
      children: [
        SizedBox(height: 20),
        _buildTitleAndCost(context),
        SizedBox(height: 20),
        CostTable(
          acList: _showAll ? _acList : _acList.sublist(0, 3),
          isUSD: _isUSD,
        ),
        SizedBox(height: 12.5),
        _buildShowMoreButton(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTitleAndCost(BuildContext context) {
    double total = Provider.of<ACProvider>(context).totalCost();
    String cost = (_isUSD)
        ? total.toStringAsFixed(2)
        : format.format(total * 85);

    return Row(
      children: [
        SizedBox(width: 15),
        Text(
          AppStrings.monthlyUsage,
          style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
        ),
        Spacer(),
        Container(
          width: 80,
          height: 30,
          decoration: AppCards.forCommon1(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                (_isUSD) ? AppStrings.usd : AppStrings.rupees,
                style: AppTexts.titleMedium(
                  context,
                ).copyWith(color: Colors.white),
              ),
              Text(
                cost,
                style: AppTexts.titleMedium(
                  context,
                ).copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(width: 15),
      ],
    );
  }

  Widget _buildShowMoreButton() {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay),
        child: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showAll = !_showAll;
              });
            },
            child: BlinkingText(_showAll ? 'Show Less' : 'Show More'),
          ),
        ),
      ),
    );
  }
}
