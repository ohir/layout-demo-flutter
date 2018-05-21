import 'package:flutter/material.dart';


class LayoutDemoPage extends StatefulWidget {
  LayoutDemoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LayoutDemoPageState createState() => new _LayoutDemoPageState();
}

class _LayoutDemoPageState extends State<LayoutDemoPage> {

  bool isRow = true;
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
  MainAxisSize mainAxisSize = MainAxisSize.min;


  void updateLayout(int index) {
    isRow = index == 0;
    setState(() {});
  }
  void updateMainAxisAlignment(int index) {
    switch (index) {
      case 0:
        mainAxisAlignment = MainAxisAlignment.start;
        break;
      case 1:
        mainAxisAlignment = MainAxisAlignment.end;
        break;
      case 2:
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case 3:
        mainAxisAlignment = MainAxisAlignment.spaceBetween;
        break;
      case 4:
        mainAxisAlignment = MainAxisAlignment.spaceAround;
        break;
      case 5:
        mainAxisAlignment = MainAxisAlignment.spaceEvenly;
        break;
    }
    setState(() {});
  }
  void updateCrossAxisAlignment(int index) {
    switch (index) {
      case 0:
        crossAxisAlignment = CrossAxisAlignment.start;
        break;
      case 1:
        crossAxisAlignment = CrossAxisAlignment.end;
        break;
      case 2:
        crossAxisAlignment = CrossAxisAlignment.center;
        break;
      case 3:
        crossAxisAlignment = CrossAxisAlignment.stretch;
        break;
      case 4:
        crossAxisAlignment = CrossAxisAlignment.baseline;
        break;
    }
    setState(() {});
  }
  void updateMainAxisSize(int index) {
    mainAxisSize = index == 0 ? MainAxisSize.min : MainAxisSize.max;
    setState(() {});
  }

  Widget buildContent() {
    if (isRow) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: [
          Icon(Icons.stars, size: 50.0),
          Icon(Icons.stars, size: 100.0),
          Icon(Icons.stars, size: 50.0),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: [
          Icon(Icons.stars, size: 50.0),
          Icon(Icons.stars, size: 100.0),
          Icon(Icons.stars, size: 50.0),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1.0,
        bottom: PreferredSize(
          preferredSize: Size(375.0, 150.0),
          child: buildOptionsPage(),
        )
      ),
      body:
      Container(
          color: Colors.yellow,
          child: buildContent()
      ),

    );
  }

  Widget buildOptionsPage() {
    return OptionsPage(
      onUpdateLayout: updateLayout,
      onUpdateMainAxisAlignment: updateMainAxisAlignment,
      onUpdateCrossAxisAlignment: updateCrossAxisAlignment,
      onUpdateMainAxisSize: updateMainAxisSize,
    );
  }
}


class OptionsPage extends StatelessWidget {
  OptionsPage({this.onUpdateLayout, this.onUpdateMainAxisAlignment, this.onUpdateCrossAxisAlignment, this.onUpdateMainAxisSize});
  final ValueChanged<int> onUpdateLayout;
  final ValueChanged<int> onUpdateMainAxisAlignment;
  final ValueChanged<int> onUpdateCrossAxisAlignment;
  final ValueChanged<int> onUpdateMainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(flex: 1, child: Column(
          children: <Widget>[
            LayoutAttribute(
              title: 'Layout',
              values: ['row', 'column'],
              onChange: onUpdateLayout,
            ),
            LayoutAttribute(
              title: 'Main Axis Size',
              values: ['min', 'max'],
              onChange: onUpdateMainAxisSize,
            ),
          ])),
        Expanded(flex: 1, child: Column(children: [
          LayoutAttribute(
            title: 'Main Axis Alignment',
            values: ['start', 'end', 'center', 'space\nbetween', 'space\naround', 'space\nevenly'],
            onChange: onUpdateMainAxisAlignment,
          ),
          LayoutAttribute(
            title: 'Cross Axis Alignment',
            values: ['start', 'end', 'center', 'stretch', /*'baseline'*/],
            onChange: onUpdateCrossAxisAlignment,
          ),
        ])),
      ]);
  }
}

class LayoutAttribute extends StatefulWidget {
  LayoutAttribute({this.title, this.values, this.onChange});
  final String title;
  final List<String> values;
  final ValueChanged<int> onChange;

  @override
  State<StatefulWidget> createState() => LayoutAttributeState();
}

class LayoutAttributeState extends State<LayoutAttribute> {

  int valueIndex = 0;

  void next() {
    valueIndex = valueIndex + 1 < widget.values.length ? valueIndex + 1 : 0;
    update();
  }

  void previous() {
    valueIndex = valueIndex > 0 ? valueIndex - 1 : widget.values.length - 1;
    update();
  }

  void update() {
    widget.onChange(valueIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(color: Colors.black54),
          Text(widget.title),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: previous,
              ),
              Text(
                  widget.values[valueIndex],
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: next,
              ),
            ],
          ),
        ]),
      );
  }
}