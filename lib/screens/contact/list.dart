import 'package:bytebankorigin/database/dao/contact_dao.dart';
import 'package:bytebankorigin/models/Contact.dart';
import 'package:bytebankorigin/screens/contact/form.dart';
import 'package:bytebankorigin/screens/transaction_form.dart';
import 'package:bytebankorigin/widgets/centered_message.dart';
import 'package:bytebankorigin/widgets/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContectsList extends StatefulWidget {

  final ContactDao contactDao;

  ContectsList({@required this.contactDao});

  @override
  State<StatefulWidget> createState() {
    return ContectsListState(contactDao: contactDao);
  }
}

class ContectsListState extends State<ContectsList> {
  final ContactDao contactDao;

  ContectsListState({@required this.contactDao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contects'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: contactDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return _ContactItem(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contact),
                        ),
                      );
                    },
                  );
                },
              );
              break;
          }
          return CenteredMessage('Unkown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(contactDao: contactDao,),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ContactItem(
    this.contact, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
