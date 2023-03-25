import 'package:flutter/material.dart';

class CreateJournalForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<CreateJournalForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime _date = DateTime.now();
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Form'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null && pickedDate != _date) {
                  setState(() {
                    _date = pickedDate;
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date',
                  ),
                  controller: TextEditingController(
                      text: '${_date.month}/${_date.day}/${_date.year}'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onSaved: (value) {
                _description = value!;
              },
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Do something with the form data
                  }
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
