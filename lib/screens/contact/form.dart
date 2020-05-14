import 'package:bytebankorigin/database/dao/contact_dao.dart';
import 'package:bytebankorigin/models/Contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final ContactDao contactDao;

  ContactForm({@required this.contactDao});
  @override
  State<StatefulWidget> createState() => ContactFormState(contactDao: contactDao);
}

class ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao contactDao;

  ContactFormState({@required this.contactDao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full name',
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account number',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text('Create'),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int accountNumber =
                        int.tryParse(_accountNumberController.text);
                    if (name != null && accountNumber != null) {
                      final Contact newContact =
                          Contact(0, name, accountNumber);
                        _save(newContact, context);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(Contact newContact, BuildContext context) async {
    await contactDao.save(newContact);
    Navigator.pop(context);
  }
}
