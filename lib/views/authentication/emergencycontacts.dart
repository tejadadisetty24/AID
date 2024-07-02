// ignore_for_file: avoid_print, empty_catches, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sos/export.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({Key? key}) : super(key: key);

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  void initState() {
    getEmergencyContacts();
    super.initState();
  }

  List emergencyContacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        toolbarHeight: 104,
        backgroundColor: AppColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          "Emergency Contacts",
          style: TextView.text70010Black.copyWith(
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 52,
          vertical: 58,
        ),
        child: ListView.builder(
          itemCount: emergencyContacts.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _showEditPopup(emergencyContacts[index]);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8),
                height: 85, // Adjust height as needed
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          emergencyContacts[index]['name'],
                        ),
                        Text(
                          emergencyContacts[index]['relation'],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(emergencyContacts[index]['mobileNumber']),
                        const Icon(Icons.edit),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  getEmergencyContacts() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    print("Emergency Contacts");
    try {
      // setState(() {
      //   loading = true;
      // });

      var res = await http.get(
        Uri.parse('${baseUrl}contacts/${sharedPrefs.getString('userId')}'),
        headers: {
          "content-type": 'application/json',
          'UserId': "${sharedPrefs.getString('userId')}"
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        setState(() {
          emergencyContacts = json.decode(res.body);
        });
      }
    } catch (e) {}
  }

  TextEditingController name = TextEditingController();
  TextEditingController relation = TextEditingController();
  TextEditingController number = TextEditingController();
  void _showEditPopup(emeCont) {
    print(emeCont);
    name.text = emeCont['name'];
    relation.text = emeCont['relation'];
    number.text = emeCont['mobileNumber'];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  initialValue: name.text,
                  onChanged: (value) => name.text = value,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: relation.text,
                  onChanged: (value) => relation.text = value,
                  decoration: const InputDecoration(labelText: 'Relation'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: number.text,
                  onChanged: (value) => number.text = value,
                  decoration: const InputDecoration(labelText: 'Number'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Update values in the container here
                    update(emeCont['Id']);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  update(id) async {
    print(id);
    var sharedPrefs = await SharedPreferences.getInstance();
    var res = await http.put(Uri.parse("${baseUrl}contacts/" + id),
        headers: {
          "content-type": 'application/json',
          'UserId': "${sharedPrefs.getString('userId')}"
        },
        body: jsonEncode({
          "name": name.text,
          "mobileNumber": number.text,
          "relation": relation.text
        }));
    if (res.statusCode == 200) {
      getEmergencyContacts();
      Navigator.pop(context);
    }
  }
}
