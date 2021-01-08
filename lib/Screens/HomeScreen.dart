import 'package:flutter/material.dart';
import 'package:my_tool_bag/Widgets/HomeButton.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hover;
  bool isSwitched;
  var moonColor;
  @override
  void initState() {
    hover = false;
    isSwitched = false;
    moonColor = Colors.black;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Center(child: Text('TOOL BAG')),
        actions: [
          Row(
            children: [
              Icon(
                Icons.brightness_3,
                size: 20,
                color: moonColor,
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = true;
                    moonColor = Colors.white;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeButton(name: 'CALCULATOR', menu: 'Calculator'),
                HomeButton(name: 'HES CODE', menu: 'HESCode'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeButton(name: 'TO DO LIST', menu: 'TODOLIST'),
                HomeButton(name: 'name', menu: 'name'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
