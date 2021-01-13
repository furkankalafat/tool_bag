import 'package:flutter/material.dart';
import 'package:my_tool_bag/Widgets/HomeButton.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Center(child: Text('TOOL BAG')),
        actions: [
          //DARK MODE WİLL BE ADD
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeButton(name: 'CALCULATOR', menu: 'Calculator'),
                HomeButton(name: 'HES CODE', menu: 'HESCode'),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeButton(name: 'TO DO LIST', menu: 'TODOLIST'),
                //HomeButton(name: 'name', menu: 'name'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
