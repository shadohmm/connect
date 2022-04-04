import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:connect/models/contacts.dart';

import '../services/upload_service.dart';
import '../widgets/custom_button.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //test controler
  late TextEditingController _nameController, _numberController;
  String _typeSelected = '';

//member of firebase
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;
//tushar

  TextEditingController? controllerEmail = TextEditingController();
  TextEditingController? controllerPhone = TextEditingController();
  TextEditingController? controllerName = TextEditingController();
  bool? isLoading;
  List<Contact>? _contacts;

//tushar
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    // _ref = .instance.reference().child('Post');
  }

  Widget _buildContactType(String title) {
    return InkWell(
      child: Container(
        height: 40.0,
        width: 90.0,
        decoration: BoxDecoration(
          color: _typeSelected == title
              ? Colors.green
              : Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Post'),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'enter name',
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 30.0,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15.0),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                hintText: 'enter number',
                prefixIcon: Icon(
                  Icons.phone_android,
                  size: 30.0,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15.0),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40.0,
              //list was created as it should be scrollable
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildContactType('work'),
                  SizedBox(
                    width: 10.0,
                  ),
                  _buildContactType('Family'),
                  SizedBox(
                    width: 10.0,
                  ),
                  _buildContactType('Friends'),
                  SizedBox(
                    width: 10.0,
                  ),
                  _buildContactType('others'),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                  title: "Save",
                  icon: Icons.save,
                  onTap: () async {
                    debugPrint(controllerEmail?.text);
                    debugPrint(controllerPhone?.text);
                    debugPrint(controllerName?.text);
                    context.read<Contact>().setEmail(controllerEmail?.text);
                    context.read<Contact>().setPhone(controllerPhone?.text);
                    context.read<Contact>().setName(controllerName?.text);
                    context
                        .read<UploadService>()
                        .uploadContacts(context)
                        .then((value) {
                      return ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Contact Saved")));
                    });
                    // style:ElevationButton.styleForm(Theme.of(context).primaryColor,
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> uploadContacts(BuildContext context) async {
    Contact _contact = context.read<Contact>();

    try {
      _firestoreReference.collection("contacts").add({
        'name': _contact.getName() ?? '',
        'phone': _contact.getPhone() ?? '',
      }).then((value) => debugPrint("Contact Saved"));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
