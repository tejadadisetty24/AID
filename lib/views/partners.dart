import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sos/export.dart';
import 'package:http/http.dart' as http;

class Partners extends StatefulWidget {
  final bool isPatner;
  const Partners({super.key, required this.isPatner});

  @override
  State<Partners> createState() => _PartnersState();
}

class _PartnersState extends State<Partners> {
  @override
  void initState() {
    super.initState();
    widget.isPatner ? getPartners() : getSponsers();
  }

  List partners = [];
  getPartners() async {
    var res = await http
        .get(Uri.parse('${baseUrl}partners'), headers: {"userId": "2"});
    var data = jsonDecode(res.body);
    setState(() {
      partners = data;
    });
  }

  getSponsers() async {
    var res = await http
        .get(Uri.parse('${baseUrl}sponsors'), headers: {"userId": "2"});
    var data = jsonDecode(res.body);
    setState(() {
      partners = data;
    });
  }

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
          widget.isPatner ? "Our Partners" : "Our Supporters",
          style: TextView.text70010Black.copyWith(
            fontSize: 18,
          ),
        ),
        elevation: 0,
        actions: const [
          //IconButton(onPressed: () {}, icon: const Icon(Icons.filter_6_sharp))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: double.infinity,
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: partners.length,
          itemBuilder: (context, index) {
            return GridsTile().suppGrid(partners[index]);
          },
        ),
      ),
    );
  }
}
