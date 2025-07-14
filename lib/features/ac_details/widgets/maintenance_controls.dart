import 'package:flutter/material.dart';
import 'package:kulir_plus/app/app.dart';
import '/core/core.dart';

class MaintenanceControls extends StatelessWidget {
  final ACModel ac;

  const MaintenanceControls({super.key, required this.ac});

  @override
  Widget build(BuildContext context) {
    final List<String> serviceLogs = [
      'Filter cleaned - Jun 2025',
      'Gas filled - Feb 2025',
      'Annual maintenance - Jan 2025',
    ];

    return Container(
      width: 350,
      height: 590,
      padding: EdgeInsets.all(20),
      decoration: AppCards.forACContainers(context),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 35, 30),
                child: Text(
                  'Maintenance Controls',
                  style: AppTexts.titleLarge(
                    context,
                    font: AppFont.aDLaMDisplay,
                  ),
                ),
              ),
            ),
            _sectionTitle(context, 'Suggestion'),
            Text(
              ' ->   Set temperature to 24°C in Cool mode for best savings.',
              style: AppTexts.bodyMedium(context),
            ),

            const SizedBox(height: 16),
            _sectionTitle(context, 'Monthly Energy Usage'),
            Text(
              '  ->  ${ac.liveEnergyUsage} kWh',
              style: AppTexts.bodyMedium(context),
            ),

            const SizedBox(height: 16),
            _sectionTitle(context, 'Service Logs'),
            ...serviceLogs.map(
              (log) => ListTile(
                leading: const Icon(Icons.build_circle_outlined),
                title: Text(log, style: AppTexts.bodyMedium(context)),
              ),
            ),

            const SizedBox(height: 16),
            _sectionTitle(context, 'Energy Saving Tips'),
            Text(
              '  ->  Use fan mode at night.\n'
              '  ->  Clean filter every 2 months.\n'
              '  ->  Set timer to avoid overuse.\n'
              '  ->  Maintain 24°C to reduce bills.',
              style: AppTexts.bodyMedium(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text) => Padding(
    padding: EdgeInsets.only(bottom: 5),
    child: Text(
      text,
      style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay),
    ),
  );
}
