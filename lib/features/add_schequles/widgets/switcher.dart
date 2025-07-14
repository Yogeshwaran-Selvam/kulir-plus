import 'package:flutter/material.dart';
import 'package:kulir_plus/app/app.dart';

class ModeSelector extends StatefulWidget {
  final String selectedMode;
  final List<String> availableModes;
  final String label;
  final ValueChanged<String> onModeChanged;
  final Color selectedColor;

  const ModeSelector({
    super.key,
    required this.selectedMode,
    required this.availableModes,
    required this.onModeChanged,
    required this.selectedColor,
    required this.label,
  });

  @override
  State<ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTexts.titleSmall(context, font: AppFont.aDLaMDisplay),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.availableModes.map((mode) {
              final isSelected = mode == widget.selectedMode;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => widget.onModeChanged(mode),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AppIcons.getModeIcon(mode),
                          color: isSelected ? widget.selectedColor : null,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          mode,
                          style: AppTexts.bodyMedium(
                            context,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? widget.selectedColor : null,
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
      ],
    );
  }
}
