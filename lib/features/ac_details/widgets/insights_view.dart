import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '/app/app.dart';

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 590,
      padding: const EdgeInsets.all(16),
      decoration: AppCards.forACContainers(context),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _buildTitle(context, 'Energy Insights', true)),
            const SizedBox(height: 20),
            _buildTitle(context, 'Monthly Cost (₹)', false),
            const SizedBox(height: 12),
            _buildBarChart(context),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: _buildTitle(context, 'Key Insights', false),
            ),
            const SizedBox(height: 10),
            insightRow(context, 'Total Cost', '₹3004.92'),
            insightRow(context, 'Avg. CO₂ Emission', '1.4 kg'),
            insightRow(context, 'Highest Usage', 'April'),
            insightRow(context, 'Best Performer', 'May'),
            const SizedBox(height: 20),
            Center(child: _buildTitle(context, 'Updated: Today', false)),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String data, bool flag) {
    return flag
        ? Padding(
            padding: EdgeInsets.fromLTRB(15, 4, 15, 0),
            child: Text(
              data,
              style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
            ),
          )
        : Text(
            data,
            style: AppTexts.titleMedium(context, font: AppFont.aDLaMDisplay),
          );
  }

  Widget _buildBarChart(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const values = [7, 4, 10, 20, 15, 8];

    return SizedBox(
      width: 320,
      height: 180,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: 20,
          backgroundColor: Colors.transparent,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                getTitlesWidget: (value, _) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      value.toInt().toString(),
                      style: AppTexts.labelSmall(context),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  int index = value.toInt();
                  if (index < 0 || index >= months.length) {
                    return const SizedBox.shrink();
                  }
                  return Center(
                    child: Text(
                      months[index],
                      style: AppTexts.labelSmall(context),
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: List.generate(6, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: values[i].toDouble(),
                  gradient: AppCards.forBarChart(context),
                  width: 16,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget insightRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTexts.titleMedium(context)),
          Text(value, style: AppTexts.bodyMedium(context)),
        ],
      ),
    );
  }
}
