import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const CustomSlider({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  CustomSliderState createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider> {
  late double currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      inactiveColor: Colors.white,
      activeColor: Theme.of(context).colorScheme.primary,
      value: currentValue,
      min: 0.0,
      max: 100.0,
      divisions: 20,
      onChanged: (double newValue) {
        setState(() {
          currentValue = newValue;
        });
        widget.onChanged(newValue);
      },
    );
  }
}