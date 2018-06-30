import 'package:flutter/material.dart';
import 'package:notodo/locale/translations.dart';
import 'package:notodo/models/item.dart';
import 'package:notodo/typedef/typedef.dart';
import 'package:intl/intl.dart';

class MainScreenList extends StatelessWidget {

  final List itemList;
  final OnItemRemove removeCallback;
  final OnItemEdit editCallback;

  MainScreenList(this.itemList, {this.removeCallback, this.editCallback});

  @override
  Widget build(BuildContext context) {

    if (itemList != null && itemList.length > 0) {
      return _createList(context, itemList);
    } else {
      return _createEmpty(context);
    }
  }

  _createList(BuildContext context, List items) {

    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          return _createListRow(context, position, items[position]);
        }
    );
  }

  _createListRow(BuildContext context, int position, Item item) {

    return Card(
      elevation: 4.0,
      child: ListTile(
          onLongPress: () => _onLongPress(context, position, item),
          title: Text(
            item.title,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(
            '${Translations.of(context).text('created_at')} ${_formatDate(item.createdTime)}',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400
            ),
          ),
          trailing: IconButton(
            onPressed: () async {
              if (removeCallback != null) {
                removeCallback(position, item);
              }
              Scaffold
                  .of(context)
                  .showSnackBar(SnackBar(content: Text('${Translations.of(context).text('removed')} ${item.title}.')));
            },
            icon: Icon(
              Icons.remove_circle,
              color: Colors.greenAccent,
            ),
          )
      ),
    );
  }

  _onLongPress(BuildContext context, int position, Item item) {

    final _textController = TextEditingController();
    _textController.text = item.title;
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

    var dialog = AlertDialog(
      title: Text(
        '${Translations.of(context).text('update_item')}',
        style: TextStyle(
            color: Colors.greenAccent
        ),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textController,
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
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('${Translations.of(context).text('cancel')}'),
        ),
        FlatButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                item.title = _textController.text;
                if (editCallback != null) {
                  editCallback(position, item);
                }
                Navigator.pop(context);
              }
            },
            child: Text('${Translations.of(context).text('update')}')
        ),

      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  _formatDate(int at) {

    return DateFormat
        .yMd()
        .add_jm()
        .format(DateTime.fromMillisecondsSinceEpoch(at));
  }

  _createEmpty(BuildContext context) {

    return Center(
      child: Text(
        '${Translations.of(context).text('empty_item')}',
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w300,
          fontSize: 19.0,
        ),
      ),
    );
  }
}
