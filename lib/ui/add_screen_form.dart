import 'package:flutter/material.dart';
import 'package:notodo/locale/translations.dart';
import 'package:notodo/typedef/typedef.dart';

class AddScreenForm extends StatefulWidget {

  final OnItemAdd onItemAdded;

  const AddScreenForm({Key key, this.onItemAdded}) : super(key: key);

  @override
  _AddScreenFormState createState() => _AddScreenFormState();
}

class _AddScreenFormState extends State<AddScreenForm> {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(8.0),
        color: Colors.black26,
        child: Column(
          children: <Widget>[
            new TextFormField(
              controller: _titleController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: '${Translations.of(context).text('title_hint')}'),
              // The validator receives the text the user has typed in
              validator: (value) {
                if (value.isEmpty) {
                  return '${Translations.of(context).text('title_empty')}';
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 19.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme
                      .of(context)
                      .accentColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      widget.onItemAdded(_titleController.text);
                    }
                  },
                  child: Text('${Translations.of(context).text('add')}',
                      style: TextStyle(color: Colors.black87)),
                ),
              ),
            ),
          ],
        ),
      ));
  }
}
