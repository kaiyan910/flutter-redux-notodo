import 'package:flutter/material.dart';
import 'package:notodo/dao/Item_dao.dart';
import 'package:notodo/locale/translations.dart';
import 'package:notodo/models/item.dart';
import 'package:notodo/utils/database_helper.dart';


class AddScreenForm extends StatefulWidget {
  @override
  _AddScreenFormState createState() => _AddScreenFormState();
}

class _AddScreenFormState extends State<AddScreenForm> {
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

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
                decoration: InputDecoration(hintText: '${Translations.of(context).text('title_hint')}'),
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
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _save(context);
                      }
                    },
                    child: Text('${Translations.of(context).text('add')}', style: TextStyle(color: Colors.black87)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _save(BuildContext context) async {

    String message = _titleController.text;
    Item item = Item(message, DateTime.now().millisecondsSinceEpoch);

    ItemDao itemDao = await _databaseHelper.itemDao;
    int insertedId = await itemDao.save(item);

    _return(context, insertedId);
  }

  _return(BuildContext context, int id) {
    Navigator.pop(context, {'id': id});
  }
}
