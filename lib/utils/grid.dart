import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sos/export.dart';

class GridsTile {
  Container suppGrid(Map partners) {
    return Container(
      width: 129,
      height: 200,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.red,/
          border: Border.all(color: const Color(0xFFD9D9D9))),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.memory(
            base64Decode(partners['photo']),
            width: 107,
            height: 110,
            // color: Colors.black12,
          ),
          height(1),
          Text(
            partners['name'] ?? partners['firstName'] + partners['lastName'],
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            partners["link"] != null
                ? partners['link']
                : partners['designation'],
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xFF7B6F72),
            ),
          )
        ],
      ),
    );
  }

  Container patnerGrid(Map partners) {
    return Container(
      width: 129,
      height: 165,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: Colors.red,/
          border: Border.all(color: const Color(0xFFD9D9D9))),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzuNjpeyScH7vwtgnDAZKW5cuH6MwmQFzVHQ&usqp=CAU",
            width: 107,
            height: 120,
            // color: Colors.black12,
          ),
          height(2),
          const Text(
            "Ramanth Kovind",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
