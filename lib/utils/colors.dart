import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF6DD00);
  static const Color backgroundColor = Color(0xFFD9D9D9);
  static const Color backgroundCardColor = Color.fromARGB(255, 250, 190, 25);
  static const Color black = Color(0xFF000000);
  static const Color black1 = Color(0xFF7B6F72);
  static const Color fieldBG = Color(0xFFF7F8F8);
  static Color dullBg = const Color(0xFF757373).withOpacity(.1);
  static const Color otptimer = Color(0xFF464646);
  static const Color iconColor = Color(0xFF8A8A8A);
  static const Color superlight = Color(0xFFE0E3E3);
  static const Color lightdark = Color(0xff4e4d4d);
  static const Color lightgrey = Color(0xFFC2C1C6);
  static const Color cardColor = Color(0x85FAD04A);
  static PdfColor cardColorPdf = PdfColor.fromHex('FAD04A85');
}
