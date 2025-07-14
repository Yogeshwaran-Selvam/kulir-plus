import '/app/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text('Contact Us'),
        toolbarHeight: 50,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 350),
                Text(
                  '--Blue Star logo--', style: AppTexts.bodySmall(context),
                ),
                Text('1.0.0', 
                  style: AppTexts.bodySmall(context),),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorScheme.primaryContainer,
                  ),
                  child: Link(
                    uri: Uri.parse('https://www.bluestarindia.com'),
                    builder: (context, followLink) => TextButton(
                      onPressed: followLink,
                      child: Text(
                        'https://www.bluestarindia.com',
                        style: AppTexts.bodySmall(context,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'This app is owned and operated by Blue Star Limited.\nCopyrights 2024 Blue Star Limited\nAll Rights Reserverd.',
                  textAlign: TextAlign.center,
                  style: AppTexts.bodySmall(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
