import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return SafeArea(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: contentBox(context),
              ),
            );
          },
        );
      },
      child: Text("Open Dialog"),
    );
  }

  Widget contentBox(context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.red,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Text 1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Text 1 is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Text 2',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Text 2 is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Text 3',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Text 3 is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Add your logic for form submission here
                    }
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Dialog Example")),
        body: Center(
          child: MyDialog(),
        ),
      ),
    ));
