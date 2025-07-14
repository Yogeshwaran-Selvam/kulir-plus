import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import '/core/core.dart';

class ACSelectionWidget extends StatefulWidget {
  final List<int> selectedACs;
  final Color selectedColor;
  final ValueChanged<List<int>> onSelectionChanged;

  const ACSelectionWidget({
    super.key,
    required this.selectedACs,
    required this.selectedColor,
    required this.onSelectionChanged,
  });

  @override
  State<ACSelectionWidget> createState() => _ACSelectionWidgetState();
}

class _ACSelectionWidgetState extends State<ACSelectionWidget> {
  late List<int> _selectedACs;

  @override
  void initState() {
    super.initState();
    _selectedACs = List.from(widget.selectedACs);
  }

  @override
  void didUpdateWidget(ACSelectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedACs != widget.selectedACs) {
      _selectedACs = List.from(widget.selectedACs);
    }
  }

  void _handleACSelection(int acId, bool selected) {
    setState(() {
      if (selected) {
        _selectedACs.add(acId);
      } else {
        _selectedACs.remove(acId);
      }
    });
    widget.onSelectionChanged(_selectedACs);
  }

  @override
  Widget build(BuildContext context) {
    final acProvider = Provider.of<ACProvider>(context);
    final acs = acProvider.acs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.acSelection,
          style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: acs.map((ac) {
              final isSelected = _selectedACs.contains(ac.id);
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _handleACSelection(ac.id, !isSelected),
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.selectedColor.withAlpha(25)
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? widget.selectedColor
                            : Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha(75),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.ac_unit,
                              color: isSelected
                                  ? widget.selectedColor
                                  : Theme.of(context).iconTheme.color,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ac.nickname,
                                style: AppTexts.bodyMedium(
                                  context,
                                  color: isSelected
                                      ? widget.selectedColor
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${ac.temperature}${AppStrings.degree}${AppStrings.celsius} • ${ac.fanSpeed}',
                          style: AppTexts.bodyMedium(
                            context,
                            color: isSelected ? widget.selectedColor : null,
                          ),
                        ),
                        if (ac.serviceAlert)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.orange,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  AppStrings.needsService,
                                  style: AppTexts.bodyMedium(
                                    context,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 10),
        if (acs.length > 2)
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              AppStrings.scrollToSeeMore,
              style: AppTexts.bodySmall(
                context,
                color: Colors.grey.withAlpha(200),
              ),
            ),
          ),
      ],
    );
  }
}
