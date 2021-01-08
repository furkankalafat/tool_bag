import 'package:flutter/material.dart';
import 'package:my_tool_bag/Models/HESCode.dart';
import 'package:my_tool_bag/Services/DbServices.dart';

class HESCodeScreen extends StatefulWidget {
  @override
  _HESCodeScreenState createState() => _HESCodeScreenState();
}

class _HESCodeScreenState extends State<HESCodeScreen> {
  HESCode _hesCode = HESCode();
  List<HESCode> _hesCodes = [];
  DbServices _dbServices;
  final _key = GlobalKey<FormState>();
  final _controlName = TextEditingController();
  final _controlId = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbServices = DbServices.instance;
    });
    _refreshHESCodeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text("HES Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _addScreen(),
            _listScreen(),
          ],
        ),
      ),
    );
  }

  _addScreen() => Container(
        color: Colors.grey[300],
        margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                cursorColor: Colors.green,
                controller: _controlName,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                onSaved: (val) => setState(() => _hesCode.name = val),
                validator: (val) =>
                    (val.length == 0 ? "This field is required" : null),
              ),
              TextFormField(
                cursorColor: Colors.green,
                controller: _controlId,
                decoration: InputDecoration(
                  labelText: "HES Code",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                onSaved: (val) => setState(() => _hesCode.id = val),
                validator: (val) =>
                    (val.length == 0 ? "This field is required" : null),
              ),
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () => _onSubmit(),
                child: Text("Submit"),
                color: Colors.green[700],
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      );

  _listScreen() => Expanded(
        child: Card(
          color: Colors.grey[300],
          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      _hesCodes[index].name.toUpperCase(),
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(_hesCodes[index].id),
                    onTap: () {
                      setState(() {
                        _hesCode = _hesCodes[index];
                        _controlName.text = _hesCodes[index].name;
                        _controlId.text = _hesCodes[index].id;
                      });
                    },
                  ),
                  Divider(
                    height: 5,
                  )
                ],
              );
            },
            itemCount: _hesCodes.length,
          ),
        ),
      );

  _refreshHESCodeList() async {
    List<HESCode> x = await _dbServices.fetchHESCode();
    setState(() {
      _hesCodes = x;
    });
  }

  _onSubmit() async {
    var form = _key.currentState;
    if (form.validate()) {
      form.save();
      await _dbServices.insertHESCode(_hesCode);
      _refreshHESCodeList();
      form.reset();
    }
  }
}
