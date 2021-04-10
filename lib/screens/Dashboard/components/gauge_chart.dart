/// Gauge chart example, where the data does not cover a full revolution in the
/// chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final pi = math.pi;

  GaugeChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData() {
    return new GaugeChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  factory GaugeChart.withData({int present, int absent}) {
    return new GaugeChart(
      _createData(present.toDouble(), absent.toDouble()),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      animationDuration: Duration(seconds: 1),
      defaultInteractions: true,
      // Configure the width of the pie slices to 30px. The remaining space in
      // the chart will be left as a hole in the center. Adjust the start
      // angle and the arc length of the pie so it resembles a gauge.
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 25,
        startAngle: 4 / 5 * pi,
        arcLength: 2.0 * pi,
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment('Absent', 25, Colors.red),
      new GaugeSegment('Present', 100, Colors.green),
      // new GaugeSegment('High', 50),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
          id: 'Segments',
          domainFn: (GaugeSegment segment, _) => segment.segment,
          measureFn: (GaugeSegment segment, _) => segment.value,
          colorFn: (GaugeSegment segment, _) => segment.color,
          // Set a label accessor to control the text of the arc label.
          labelAccessorFn: (GaugeSegment segment, _) => segment.segment,
          // segment.segment == 'Absent' ? '${segment.value}' : null,
          data: data,
          displayName: 'Attendance')
    ];
  }

  static List<charts.Series<GaugeSegment, String>> _createData(
      double present, double absent) {
    final data = [
      new GaugeSegment('Absent', absent, Colors.red),
      new GaugeSegment('Present', present, Colors.green),
      // new GaugeSegment('High', 50),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
          id: 'Segments',
          domainFn: (GaugeSegment segment, _) => segment.segment,
          measureFn: (GaugeSegment segment, _) => segment.value,
          colorFn: (GaugeSegment segment, _) => segment.color,
          // Set a label accessor to control the text of the arc label.
          labelAccessorFn: (GaugeSegment segment, _) => segment.segment,
          // segment.segment == 'Absent' ? '${segment.value}' : null,
          data: data,
          displayName: 'Attendance')
    ];
  }
}

/// data type.
class GaugeSegment {
  final String segment;
  final double value;
  final charts.Color color;

  GaugeSegment(this.segment, this.value, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
