import '/app/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
            padding: const EdgeInsets.fromLTRB(20, 50, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Write to us @", style: AppTexts.bodyLarge(context)),
                Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorScheme.primaryContainer,
                  ),
                  child: Link(
                    uri: Uri.parse('mailto:customerservice@bluestarindia.com'),
                    builder: (context, followLink) => TextButton(
                      onPressed: followLink,
                      child: Text(
                        'customerservice@bluestarindia.com',
                        style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text("Call to us @", style: AppTexts.bodyLarge(context)),
                Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorScheme.primaryContainer,
                  ),
                  child: Link(
                    uri: Uri.parse('tel:18002091177'),
                    builder: (context, followLink) => TextButton(
                      onPressed: followLink,
                      child: Text(
                        '1800 209 1177',
                        style: AppTexts.bodyLarge(context, 
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text("Visit us @", style: AppTexts.bodyLarge(context)),
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
                        style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
