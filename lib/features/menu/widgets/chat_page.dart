import 'package:flutter/material.dart';

class ACChatPage extends StatefulWidget {
  const ACChatPage({super.key});

  @override
  State<ACChatPage> createState() => _ACChatPageState();
}

class _ACChatPageState extends State<ACChatPage> {
  final List<_ChatItem> _chat = [];
  final List<dynamic> _flow = acSupportFlow;

  void _handleSelection(dynamic item) {
    if (item is String) {
      setState(() {
        _chat.add(_ChatItem(user: true, text: item));
        final index = _flow.indexOf(item);
        if (index != -1 && index + 1 < _flow.length) {
          _chat.add(_ChatItem(user: false, text: _flow[index + 1]));
        }
      });
    } else if (item is List) {
      setState(() {
        _chat.add(_ChatItem(user: false, options: item));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _chat.add(_ChatItem(user: false, text: _flow[0]));
    _chat.add(_ChatItem(user: false, text: _flow[1]));
    _handleSelection(_flow[2]);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('AC Support')),
      body: Container(
        color: isDark ? Colors.black : Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _chat.length,
          itemBuilder: (context, index) {
            final item = _chat[index];
            return item.user      
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.text ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.text != null)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[800] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item.text!,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      if (item.options != null)
                        ...item.options!.map<Widget>(
                          (opt) => Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: OutlinedButton(
                              onPressed: () => _handleSelection(opt),
                              child: Text(
                                opt.toString(),
                                style: TextStyle(color: primary),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class _ChatItem {
  final bool user;
  final String? text;
  final List<dynamic>? options;

  _ChatItem({required this.user, this.text, this.options});
}

final List<dynamic> acSupportFlow = [
  "Welcome",
  "How can I help you?",
  "Need Service Assistance",
  [
    "1. Room is not getting cooled",
    [
      "a. Please check if anything is blocking the airflow path. Blocked Airflow path may affect the cooling performance of your AC. Things which may block the airflow path are curtains, blinds, or furniture",
      [
        "i. No, AC is blocked",
        [
          "1. Please ensure that AC filters are cleaned at interval of every 30 days",
        ],
      ],
    ],
    "2. AC is making noise",
    "3. AC is showing error",
    "4. AC is emitting Fog",
    "5. Water is dripping inside the room",
  ],
  "Need Energy Saving tips",
  [
    "a. Set your AC temperature smartly during night",
    "b. Avoid frequent door opening",
    "c. Keep the sunlight out",
    "d. Keep your AC well maintained",
    "e. Avoid Air leakage",
    "f. Choosing the right set temperature",
  ],
  "Want to call customer",
  ["1. Call Now 1800 209 1177", "2. Not now, Please skip"],
  "Log a service request",
  [
    "1. Looks like you need a service assistance. Should I log a service call for you?",
    [
      "a. Yes, please call a service",
      "b. No, Thank You. I will check this later",
    ],
  ],
];
