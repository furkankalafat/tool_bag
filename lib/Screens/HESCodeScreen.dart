import 'package:flutter/material.dart';
import 'package:my_tool_bag/Models/HESCode.dart';
import 'package:my_tool_bag/Services/DbServicesHesCode.dart';

class HESCodeScreen extends StatefulWidget {
  @override
  _HESCodeScreenState createState() => _HESCodeScreenState();
}

class _HESCodeScreenState extends State<HESCodeScreen> {
  HESCode _hesCode = HESCode();
  List<HESCode> _hesCodes = [];
  DbServicesHesCode _dbServices;
  final _key = GlobalKey<FormState>();
  final _controlName = TextEditingController();
  final _controlhesCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _dbServices = DbServicesHesCode.instance;
    });
    _refreshHESCodeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
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
                controller: _controlhesCode,
                decoration: InputDecoration(
                  labelText: "HES Code",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                onSaved: (val) => setState(() => _hesCode.hescode = val),
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
                    subtitle: Text(_hesCodes[index].hescode),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.green),
                      onPressed: () async {
                        await _dbServices.deleteHESCode(_hesCodes[index].id);
                        _resetForm();
                        _refreshHESCodeList();
                      },
                    ),
                    onTap: () {
                      setState(() {
                        _hesCode = _hesCodes[index];
                        _controlName.text = _hesCodes[index].name;
                        _controlhesCode.text = _hesCodes[index].hescode;
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
      if (_hesCode.id == null) {
        await _dbServices.insertHESCode(_hesCode);
      } else
        await _dbServices.updateHESCode(_hesCode);
      _refreshHESCodeList();
      _resetForm();
    }
  }

  _resetForm() {
    setState(() {
      _key.currentState.reset();
      _controlhesCode.clear();
      _controlName.clear();
      _hesCode.id = null;
    });
  }
}
