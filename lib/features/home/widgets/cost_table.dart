import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '/app/app.dart';
import '/core/core.dart';

class CostTable extends StatelessWidget {
  final List<ACModel> acList;
  final bool isUSD;
  final format = NumberFormat('#,##0', 'en_IN');

  CostTable({
    super.key,
    required this.acList,
    required this.isUSD,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Container(
        decoration: AppCards.forTable(context),
        child: DataTable(
          columnSpacing: 0,
          headingRowHeight: 48,
          headingRowColor: WidgetStateColor.resolveWith(
            (states) => Colors.transparent,
          ),
          dataRowColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.hovered)
                ? Theme.of(context).colorScheme.primary.withAlpha(25)
                : Colors.transparent,
          ),
          dividerThickness: 0,
          columns: [
            DataColumn(label: _glassHeaderCell(AppStrings.top, context)),
            DataColumn(label: _glassHeaderCell(AppStrings.name, context)),
            DataColumn(label: _glassHeaderCell(AppStrings.power, context)),
            DataColumn(label: _glassHeaderCell('${AppStrings.cost} (${(isUSD ? AppStrings.usd : AppStrings.rupees)})', context)),
          ],
          rows: acList.asMap().entries.map((entry) {
            final index = entry.key;
            final ac = entry.value;
            return DataRow(
              cells: [
                DataCell(_glassTableCell('${index + 1}', context, isNum: true)),
                DataCell(_glassTableCell(ac.nickname, context)),
                DataCell(
                  _glassTableCell(ac.liveEnergyUsage.toString(), context),
                ),
                DataCell(
                  _glassTableCell(
                    isUSD
                        ? '${AppStrings.usd}${ac.cost.toStringAsFixed(2)}'
                        : '${AppStrings.rupees}${format.format(ac.nativeCost)}',
                    context,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _glassHeaderCell(String text, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 3),
      child: Text(
        text,
        style: AppTexts.titleMedium(context, color: Theme.of(context).colorScheme.primary.withAlpha(200)),
      ),
    );
  }

  Widget _glassTableCell(String text, BuildContext context, {bool isNum = false}) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final color = isNum ? themeProvider.themeData.colorScheme.primary : themeProvider.isDark ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        text,
        style: AppTexts.titleSmall(context, color: color.withAlpha(200)),
      ),
    );
  }
}
