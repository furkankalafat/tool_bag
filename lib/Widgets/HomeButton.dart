import 'package:flutter/material.dart';
import 'package:my_tool_bag/Screens/Calculator.dart';
import 'package:my_tool_bag/Screens/HESCodeScreen.dart';

// ignore: must_be_immutable
class HomeButton extends StatefulWidget {
  String name;
  String menu;
  HomeButton({
    @required this.name,
    @required this.menu,
  });

  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  bool hover;
  bool isSwitched;
  @override
  void initState() {
    hover = false;
    isSwitched = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (_) {
        setState(() {
          hover = _;
        });
      },
      onTap: () {
        if (widget.menu == 'Calculator')
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CalculatorScreen()));
        if (widget.menu == 'HESCode')
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HESCodeScreen()));
        if (widget.menu == 'TODOLIST')
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CalculatorScreen()));
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: hover ? Colors.green[700] : Colors.green[800],
          borderRadius: BorderRadius.circular(15),
        ),
        width: 150,
        height: 100,
        child: Center(
          child: Text(
            widget.name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
