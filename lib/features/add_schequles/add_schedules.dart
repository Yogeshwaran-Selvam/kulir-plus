import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '/app/app.dart';
import '/core/core.dart';
import 'widgets/widgets.dart';

class AddSchedulePage extends StatefulWidget {
  final int id;

  const AddSchedulePage({super.key, required this.id});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  // For one-time schedule
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  // For both types
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  // For recurring schedule
  final List<bool> _selectedWeekdays = List.filled(7, false);

  bool _isRecurring = false;
  List<int> _selectedACs = [1];
  int _temperature = 21;
  String _mode = AppStrings.cool;
  String _fanSpeed = AppStrings.low;
  Color _selectedColor = Colors.cyan;

  @override
  void initState() {
    super.initState();
    if (widget.id != -1) {
      final schedule = Provider.of<ScheduleProvider>(
        context,
        listen: false,
      ).getById(widget.id);
      _titleController.text = schedule.title;
      _startTime = schedule.startTime;
      _endTime = schedule.endTime;
      _selectedACs = List.from(schedule.acs);
      _temperature = schedule.temperature;
      _mode = schedule.mode;
      _fanSpeed = schedule.fanSpeed;
      _selectedColor = schedule.color;
      _isRecurring = schedule.isRecurring;

      if (schedule.isRecurring) {
        for (var weekday in schedule.weekdays) {
          _selectedWeekdays[weekday] = true;
        }
      } else {
        _startDate = schedule.dates[0];
        _endDate = schedule.dates[1];
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: themeProvider.themeData.copyWith(
            textTheme: TextTheme(
              headlineLarge: AppTexts.headlineLarge(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              headlineMedium: AppTexts.headlineMedium(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              headlineSmall: AppTexts.headlineSmall(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              titleLarge: AppTexts.titleLarge(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              titleMedium: AppTexts.titleMedium(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              titleSmall: AppTexts.titleSmall(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              bodyLarge: AppTexts.bodyLarge(context),
              bodyMedium: AppTexts.bodyMedium(context),
              bodySmall: AppTexts.bodySmall(context),
              labelLarge: AppTexts.labelLarge(context),
              labelMedium: AppTexts.labelMedium(context),
              labelSmall: AppTexts.labelSmall(context),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
      builder: (context, child) {
        return Theme(
          data: themeProvider.themeData.copyWith(
            textTheme: TextTheme(
              displayLarge: AppTexts.displayLarge(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              displayMedium: AppTexts.displayMedium(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              displaySmall: AppTexts.displaySmall(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              headlineLarge: AppTexts.headlineLarge(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              headlineMedium: AppTexts.headlineMedium(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              headlineSmall: AppTexts.headlineSmall(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              titleLarge: AppTexts.titleLarge(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              titleMedium: AppTexts.titleMedium(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              titleSmall: AppTexts.titleSmall(
                context,
                font: AppFont.aDLaMDisplay,
              ),
              bodyLarge: AppTexts.bodyLarge(context),
              bodyMedium: AppTexts.bodyMedium(context),
              bodySmall: AppTexts.bodySmall(context),
              labelLarge: AppTexts.labelLarge(context),
              labelMedium: AppTexts.labelMedium(context),
              labelSmall: AppTexts.labelSmall(context),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppStrings.selectColor,
            style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
          ),
          content: BlockPicker(
            pickerColor: _selectedColor,
            onColorChanged: (Color color) {
              setState(() => _selectedColor = color);
            },
            availableColors: colors,
            layoutBuilder: (context, colors, child) {
              return SizedBox(
                width: double.maxFinite,
                child: GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [for (Color color in colors) child(color)],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppStrings.ok,
                style: AppTexts.titleSmall(
                  context,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validate time
      final startDateTime = DateTime(
        _startDate.year,
        _startDate.month,
        _startDate.day,
        _startTime.hour,
        _startTime.minute,
      );

      final endDateTime = DateTime(
        _endDate.year,
        _endDate.month,
        _endDate.day,
        _endTime.hour,
        _endTime.minute,
      );

      // Validate time range
      if (endDateTime.isBefore(startDateTime) || endDateTime == startDateTime) {
        AppCards.showTopBar(context, AppStrings.endTimeMustBeAfterStartTime);
        return;
      }

      // Validate recurring schedule
      if (_isRecurring) {
        final weekdays = _selectedWeekdays
            .where((selected) => selected)
            .toList();
        if (weekdays.isEmpty) {
          AppCards.showTopBar(
            context,
            AppStrings.pleaseSelectAtLeastOneWeekdayForRecurringSchedule,
          );
          return;
        }
      }

      // Validate AC selection
      if (_selectedACs.isEmpty) {
        AppCards.showTopBar(context, AppStrings.pleaseSelectAtleastOne);
        return;
      }

      final scheduleProvider = Provider.of<ScheduleProvider>(
        context,
        listen: false,
      );

      final List<int> weekdays = [];
      for (int i = 0; i < _selectedWeekdays.length; i++) {
        if (_selectedWeekdays[i]) weekdays.add(i);
      }

      final newSchedule = ScheduleModel(
        id: widget.id,
        title: _titleController.text,
        dates: _isRecurring ? [] : [startDateTime, endDateTime],
        weekdays: weekdays,
        startTime: _startTime,
        endTime: _endTime,
        acs: _selectedACs,
        temperature: _temperature,
        mode: _mode,
        fanSpeed: _fanSpeed,
        color: _selectedColor,
        isRecurring: _isRecurring,
      );

      if (widget.id != -1) {
        scheduleProvider.updateSchedule(newSchedule);
      } else {
        scheduleProvider.addSchedule(newSchedule);
      }
      AppRouter.pop(context);
    }
  }

  Widget _buildWeekdaySelector() {
    final colorScheme = Theme.of(context).colorScheme;
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.selectWeekdays,
          style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(7, (index) {
            return FilterChip(
              label: Text(weekdays[index]),
              labelStyle: AppTexts.bodyLarge(context),
              selected: _selectedWeekdays[index],
              selectedColor: _selectedColor.withValues(alpha: 0.2),
              checkmarkColor: _selectedColor,
              side: BorderSide(
                color: colorScheme.onSurface.withAlpha(100),
                width: 0.5,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedWeekdays[index] = selected;
                });
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDateTimeRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.scheduleTime,
          style: AppTexts.titleSmall(context, font: AppFont.aDLaMDisplay),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TimeInput(
                label: AppStrings.startTime,
                time: _startTime,
                onTap: () => _selectTime(context, true),
                color: _selectedColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TimeInput(
                label: AppStrings.endTime,
                time: _endTime,
                onTap: () => _selectTime(context, false),
                color: _selectedColor,
              ),
            ),
          ],
        ),
        if (!_isRecurring) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DateInput(
                  label: AppStrings.startDate,
                  date: _startDate,
                  onTap: () => _selectDate(context, true),
                  color: _selectedColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DateInput(
                  label: AppStrings.endDate,
                  date: _endDate,
                  onTap: () => _selectDate(context, false),
                  color: _selectedColor,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTemperatureControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppStrings.temperature,
              style: AppTexts.bodyLarge(context, font: AppFont.aDLaMDisplay),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _selectedColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$_temperature${AppStrings.degree}${AppStrings.celsius}',
                style: AppTexts.bodyLarge(context),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: _selectedColor,
            inactiveTrackColor: _selectedColor.withValues(alpha: 0.3),
            thumbColor: _selectedColor,
            overlayColor: _selectedColor.withValues(alpha: 0.2),
            valueIndicatorColor: _selectedColor,
          ),
          child: Slider(
            value: _temperature.toDouble(),
            min: 16,
            max: 30,
            divisions: 14,
            label: '$_temperature°C',
            onChanged: (double value) {
              setState(() {
                _temperature = value.round();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModeSelection() {
    return ModeSelector(
      selectedMode: _mode,
      availableModes: modesData,
      label: AppStrings.acMode,
      onModeChanged: (value) => setState(() => _mode = value),
      selectedColor: _selectedColor,
    );
  }

  Widget _buildFanSpeedSelection() {
    return ModeSelector(
      selectedMode: _fanSpeed,
      availableModes: fanSpeedsData,
      label: AppStrings.fanSpeed,
      onModeChanged: (value) => setState(() => _fanSpeed = value),
      selectedColor: _selectedColor,
    );
  }

  Widget _buildColorSelection() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(
        AppStrings.scheduleColor,
        style: AppTexts.titleMedium(context, font: AppFont.aDLaMDisplay),
      ),
      trailing: InkWell(
        onTap: _showColorPicker,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _selectedColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id == -1 ? AppStrings.addNewSchedule : AppStrings.editSchedule,
          style: AppTexts.titleLarge(context, font: AppFont.aDLaMDisplay),
        ),
        actions: [
          if (widget.id != -1)
            IconButton(
              icon: AppIcons.deleteIcon(context),
              onPressed: () {
                final provider = Provider.of<ScheduleProvider>(
                  context,
                  listen: false,
                );
                provider.removeSchedule(widget.id);
                AppRouter.pop(context);
              },
            ),
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: AppCards.forCommon1(context, 10),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: AppStrings.scheduleTitle,
                  labelStyle: AppTexts.bodyLarge(
                    context,
                    font: AppFont.aDLaMDisplay,
                    color: Colors.white,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colorScheme.onSurface),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colorScheme.onSurface),
                  ),

                  filled: false,
                ),
                cursorColor: Colors.white,
                style: AppTexts.bodyLarge(context, color: Colors.white),
                validator: (value) {
                  // Validate title
                  if (value == null || value.isEmpty) {
                    AppCards.showTopBar(context, AppStrings.pleaseEnterATitle);
                    return AppStrings.pleaseEnterATitle;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 10,
              color: Colors.transparent,
              child: Container(
                decoration: AppCards.forAcTile(context),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: Text(
                          AppStrings.recurringSchedule,
                          style: AppTexts.titleMedium(
                            context,
                            font: AppFont.aDLaMDisplay,
                          ),
                        ),
                        value: _isRecurring,
                        activeColor: _selectedColor,
                        activeTrackColor: _selectedColor.withAlpha(100),
                        onChanged: (value) {
                          setState(() {
                            _isRecurring = value;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildDateTimeRange(),
                      if (_isRecurring) ...[
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildWeekdaySelector(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 10,
              color: Colors.transparent,
              child: Container(
                decoration: AppCards.forAcTile(context),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ACSelectionWidget(
                        selectedACs: _selectedACs,
                        selectedColor: _selectedColor,
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            _selectedACs = newSelection;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildTemperatureControl(),
                      const SizedBox(height: 24),
                      _buildModeSelection(),
                      const SizedBox(height: 16),
                      _buildFanSpeedSelection(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 10,
              color: Colors.transparent,
              child: Container(
                decoration: AppCards.forAcTile(context),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildColorSelection(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedColor,
                  foregroundColor: colorScheme.onSurface,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  widget.id == -1
                      ? AppStrings.createSchedule
                      : AppStrings.updateSchedule,
                  style: AppTexts.bodyLarge(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
