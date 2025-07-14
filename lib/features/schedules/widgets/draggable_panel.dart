import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/core.dart';

class DraggablePanel extends StatefulWidget {
  final Widget collapsedChild;
  final Widget expandedChild;
  final double collapsedHeight;
  final double expandedHeight;
  final bool isExpanded;

  const DraggablePanel({
    super.key,
    required this.collapsedChild,
    required this.expandedChild,
    required this.collapsedHeight,
    required this.expandedHeight,
    required this.isExpanded,
  });

  @override
  State<DraggablePanel> createState() => _DraggablePanelState();
}

class _DraggablePanelState extends State<DraggablePanel> {
  late double _panelHeight;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _panelHeight = widget.isExpanded
        ? widget.expandedHeight
        : widget.collapsedHeight;
    _isExpanded = widget.isExpanded;
  }

  void _handleDragUpdate(double delta) {
    setState(() {
      _panelHeight += delta;
      _panelHeight = _panelHeight.clamp(
        widget.collapsedHeight,
        widget.expandedHeight,
      );
      _isExpanded = _panelHeight > widget.collapsedHeight + 10;
    });
  }

  void _handleDragEnd(double velocity) {
    setState(() {
      _isExpanded =
          _panelHeight > (widget.collapsedHeight + widget.expandedHeight) / 2;
      _panelHeight = _isExpanded
          ? widget.expandedHeight
          : widget.collapsedHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final color1 = themeProvider.isDark ? Colors.white : Colors.black;
    final color2 = themeProvider.isDark ? Colors.black : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _panelHeight,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1.withAlpha(38), color1.withAlpha(13)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color1.withAlpha(25)),
        boxShadow: [
          BoxShadow(
            color: color2.withAlpha(100),
            blurRadius: 12,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _isExpanded
                ? widget.expandedChild
                : FittedBox(child: widget.collapsedChild),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onVerticalDragUpdate: (details) =>
                  _handleDragUpdate(details.delta.dy),
              onVerticalDragEnd: (details) =>
                  _handleDragEnd(details.primaryVelocity ?? 0),
              child: Container(
                height: 30,
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color1.withAlpha(100),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
