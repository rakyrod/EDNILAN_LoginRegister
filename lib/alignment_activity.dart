import 'package:flutter/material.dart';

void main() {
  runApp(const AlignmentActivity());
}

class AlignmentActivity extends StatelessWidget {
  const AlignmentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main and Cross Axis Alignment',
      theme: ThemeData(useMaterial3: true),
      home: const SelectionPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

const String appBarTitle = 'EDNILAN';

const List<Color> boxColors = [Colors.red, Colors.yellow, Colors.blue];

PreferredSizeWidget buildAppBar({bool showBack = false}) {
  return AppBar(
    backgroundColor: Colors.teal,
    centerTitle: true,
    automaticallyImplyLeading: showBack,
    title: const Text(appBarTitle),
  );
}

MainAxisAlignment mainFrom(String value) {
  switch (value) {
    case 'spaceAround':
      return MainAxisAlignment.spaceAround;
    case 'spaceBetween':
      return MainAxisAlignment.spaceBetween;
    case 'spaceEvenly':
      return MainAxisAlignment.spaceEvenly;
    case 'start':
      return MainAxisAlignment.start;
    case 'end':
      return MainAxisAlignment.end;
    default:
      return MainAxisAlignment.center;
  }
}

CrossAxisAlignment crossFrom(String value) {
  switch (value) {
    case 'start':
      return CrossAxisAlignment.start;
    case 'end':
      return CrossAxisAlignment.end;
    case 'baseline':
      return CrossAxisAlignment.baseline;
    case 'stretch':
      return CrossAxisAlignment.stretch;
    default:
      return CrossAxisAlignment.center;
  }
}

// ---------------------------------------------------------------------------
// Screen 1: selection
// ---------------------------------------------------------------------------

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  String layout = 'Column';
  String property = 'CrossAxisAlignment';
  String alignment = 'start';

  static const List<String> layouts = ['Row', 'Column'];
  static const List<String> properties = [
    'MainAxisAlignment',
    'CrossAxisAlignment',
  ];
  static const List<String> mainAlignments = [
    'center',
    'spaceAround',
    'spaceBetween',
    'spaceEvenly',
    'start',
    'end',
  ];
  static const List<String> crossAlignments = [
    'start',
    'end',
    'baseline',
    'center',
    'stretch',
  ];

  Widget _dropdown({
    Key? key,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      key: key,
      initialValue: value,
      isExpanded: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final options =
        property == 'MainAxisAlignment' ? mainAlignments : crossAlignments;

    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('WIDGET:'),
              const SizedBox(height: 6),
              _dropdown(
                value: layout,
                items: layouts,
                onChanged: (v) {
                  if (v != null) setState(() => layout = v);
                },
              ),
              const SizedBox(height: 16),
              const Text('PROPERTY:'),
              const SizedBox(height: 6),
              _dropdown(
                value: property,
                items: properties,
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      property = v;
                      alignment =
                          v == 'MainAxisAlignment' ? 'center' : 'start';
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              const Text('ALIGNMENT:'),
              const SizedBox(height: 6),
              _dropdown(
                // The key makes the dropdown rebuild when the property changes
                key: ValueKey('alignment-$property'),
                value: alignment,
                items: options,
                onChanged: (v) {
                  if (v != null) setState(() => alignment = v);
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResultPage(
                          layout: layout,
                          property: property,
                          alignment: alignment,
                        ),
                      ),
                    );
                  },
                  child: const Text('SHOW RESULT'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Screen 2: result (matches the screenshots)
// ---------------------------------------------------------------------------

class ResultPage extends StatelessWidget {
  final String layout;
  final String property;
  final String alignment;

  const ResultPage({
    super.key,
    required this.layout,
    required this.property,
    required this.alignment,
  });

  static const double boxSize = 60;

  bool get isMain => property == 'MainAxisAlignment';

  Widget _colorBox(int i, {double? width, double? height}) {
    return Container(width: width, height: height, color: boxColors[i]);
  }

  @override
  Widget build(BuildContext context) {
    final main = isMain ? mainFrom(alignment) : MainAxisAlignment.center;
    final cross = isMain ? CrossAxisAlignment.center : crossFrom(alignment);

    CrossAxisAlignment outerCross = CrossAxisAlignment.center;
    List<Widget> demo;

    if (layout == 'Row') {
      demo = [_rowDemo(main, cross)];
    } else if (!isMain && alignment == 'baseline') {
      demo = [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'CrossAxisAlignment.baseline is not supported by Column.\n'
            'Select Row to see how text baselines align.',
            textAlign: TextAlign.center,
          ),
        ),
      ];
    } else if (isMain) {
      demo = [
        SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: main,
            children: List.generate(
              3,
              (i) => _colorBox(i, width: boxSize, height: boxSize),
            ),
          ),
        ),
      ];
    } else {
      // Column + CrossAxisAlignment: the label and blocks follow the alignment
      outerCross = cross;
      final indent = alignment == 'start' || alignment == 'end' ? boxSize : 0.0;
      demo = List.generate(
        3,
        (i) => Padding(
          padding: EdgeInsets.only(
            left: alignment == 'start' ? indent : 0,
            right: alignment == 'end' ? indent : 0,
          ),
          child: _colorBox(
            i,
            width: alignment == 'stretch' ? null : boxSize,
            height: boxSize,
          ),
        ),
      );
    }

    return Scaffold(
      // showBack: true adds the back arrow so the user can return
      appBar: buildAppBar(showBack: true),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: outerCross,
            children: [
              Text(
                '$property.$alignment',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ...demo,
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowDemo(MainAxisAlignment main, CrossAxisAlignment cross) {
    // Baseline: text children with different font sizes
    if (!isMain && alignment == 'baseline') {
      const sizes = [18.0, 32.0, 24.0];
      const labels = ['ONE', 'TWO', 'THREE'];
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: List.generate(
          3,
          (i) => Container(
            color: boxColors[i],
            padding: const EdgeInsets.all(8),
            child: Text(
              labels[i],
              style: TextStyle(
                fontSize: sizes[i],
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      );
    }

    // Row + MainAxisAlignment: equal boxes, spread across the full width
    if (isMain) {
      return Row(
        mainAxisAlignment: main,
        children: List.generate(
          3,
          (i) => _colorBox(i, width: boxSize, height: boxSize),
        ),
      );
    }

    // Row + CrossAxisAlignment: boxes with different heights
    const heights = [50.0, 80.0, 110.0];
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: cross,
        children: List.generate(
          3,
          (i) => _colorBox(
            i,
            width: boxSize,
            height: alignment == 'stretch' ? null : heights[i],
          ),
        ),
      ),
    );
  }
}