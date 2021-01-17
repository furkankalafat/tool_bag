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
                HomeButton(name: 'Hesap Makinesi', menu: 'Calculator'),
                HomeButton(name: 'HES Kod', menu: 'HESCode'),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeButton(name: 'Yapılacaklar Listesi', menu: 'TODOLIST'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
