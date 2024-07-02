// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:sos/export.dart';
import 'package:sos/views/medicalCardView.dart';

// Future<void> main() async {
//   final pdf = pdf.Document();

//   pdf.addPage(
//     pdf.Page(
//         build: (pdf.Context context) => pdf.Center(
//               child: pdf.Text('Medical Card'),
//             )),
//   );
//   final file = File('example.pdf');
//   await file.writeAsBytes(await pdf.save());
// }

class MedicalCard extends StatefulWidget {
  const MedicalCard({Key? key}) : super(key: key);

  @override
  State<MedicalCard> createState() => _MedicalCardState();
}

class _MedicalCardState extends State<MedicalCard> {
  // Function to download the medical card view
  // Future<void> _downloadMedicalCard() async {
  //   final bytes = await _generatePdfBytes(); // Assuming you have a method to generate PDF bytes
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/medical_card.pdf');
  //   await file.writeAsBytes(bytes);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Medical card downloaded')),
  //   );
  // }

  // // Function to share the medical card
  // Future<void> _shareMedicalCard() async {
  //   final bytes = await _generatePdfBytes(); // Assuming you have a method to generate PDF bytes
  //   final directory = await getTemporaryDirectory();
  //   final file = File('${directory.path}/medical_card.pdf');
  //   await file.writeAsBytes(bytes);
  // }

  // // Example method to generate PDF bytes (replace it with your actual implementation)
  // Future<List<int>> _generatePdfBytes() async {
  //   // Replace this with your logic to generate PDF bytes
  //   // For example, you can use packages like 'pdf' to generate PDF files
  //   return Future.delayed(const Duration(seconds: 2), () => List<int>.generate(100, (index) => index));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            height: 612,
            width: 325,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.cardColor,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 220),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(Images.logo),
                    ),
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(32, 20, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'AID',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                  fontFamily: 'Poppins'),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Text(
                          'Certificate',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              fontFamily: 'Poppins'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Emily Smith",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      fontFamily: 'Poppins'),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  "January 15, 1997",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      fontFamily: 'Poppins'),
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      fontFamily: 'Poppins'),
                                ),
                                Text(
                                  "+91 9479358202",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),
                            SizedBox(width: 39),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(Images.img),
                            )
                          ],
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(32, 5, 0, 0),
                    child: Column(children: [
                      const Row(
                        children: [
                          Text(
                            "Medical Details",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Blood Group :",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "A+",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text("Certification",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20)),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "Date of Issuance :",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "March 27, 2024",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Signature of Doctor :",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            Images.sign,
                            height: 40,
                            width: 40,
                          )
                        ],
                      )
                    ])),
                const Padding(
                    padding: EdgeInsets.fromLTRB(32, 30, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          "Certification provided by AID group in association with MedLab solutions. ",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        )
                      ],
                    )),
                // Buttons().solidButton(() => null, "Medical Card", )
                const SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MedicalCardView()),
                        );
                        // Implement your logic here
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.yellow.shade500),
                      ),
                      child: const Text(
                        'Medical Card',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _downloadMedicalCard();
                },
                // _downloadMedicalCard,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.yellow.shade500),
                ),
                icon: const Icon(Icons.download),
                label: const Text(
                  'Download',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 10), // Add spacing between buttons
              // ElevatedButton.icon(
              //   onPressed: () {},
              //   // _shareMedicalCard,
              //   style: ButtonStyle(
              //     backgroundColor:
              //         MaterialStateProperty.all<Color>(Colors.yellow.shade500),
              //   ),
              //   icon: const Icon(Icons.share_rounded),
              //   label: const Text(
              //     'Share',
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              ElevatedButton.icon(
                onPressed: () {
                  _shareMedicalCard(); // Call the method to share the medical card
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.yellow.shade500),
                ),
                icon: const Icon(Icons.share_rounded),
                label: const Text(
                  'Share',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }

  Future<List<int>> _generatePdfBytes() async {
    // Create a PDF document
    final pdf.Document document = pdf.Document();
    // final
    // Add content to the PDF document
    document.addPage(
      pdf.Page(
        build: (pdf.Context context) {
          return pdf.Container(
            height: 612,
            width: 325,
            decoration: pdf.BoxDecoration(
              borderRadius: pdf.BorderRadius.circular(20),
              color: AppColors.cardColorPdf,
            ),
            child: pdf.Column(
              children: [
                pdf.SizedBox(
                  height: 10,
                ),
                pdf.Padding(
                    padding: const pdf.EdgeInsets.fromLTRB(32, 20, 0, 0),
                    child: pdf.Column(
                      crossAxisAlignment: pdf.CrossAxisAlignment.start,
                      children: [
                        pdf.Row(
                          mainAxisAlignment: pdf.MainAxisAlignment.start,
                          children: [
                            pdf.Text(
                              'AID',
                              style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold,
                                fontSize: 30,
                              ),
                              textAlign: pdf.TextAlign.left,
                            ),
                          ],
                        ),
                        pdf.Text(
                          'Certificate',
                          style: pdf.TextStyle(
                            fontWeight: pdf.FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        pdf.SizedBox(
                          height: 10,
                        ),
                        pdf.Row(
                          children: [
                            pdf.Column(
                              crossAxisAlignment: pdf.CrossAxisAlignment.start,
                              children: [
                                pdf.Text(
                                  "Emily Smith",
                                  style: pdf.TextStyle(
                                    fontWeight: pdf.FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                pdf.Text(
                                  "January 15, 1997",
                                  style: pdf.TextStyle(
                                    fontWeight: pdf.FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                pdf.Text(
                                  "Female",
                                  style: pdf.TextStyle(
                                    fontWeight: pdf.FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                pdf.Text(
                                  "+91 9479358202",
                                  style: pdf.TextStyle(
                                    fontWeight: pdf.FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            pdf.SizedBox(width: 39),
                            // pdf.Container(height: 50,width: 50,decoration: pdf.BoxDecoration(borderRadius: pdf.BorderRadius.circular(50),),child: pdf.Image(pdf.))
                            // CircleAvatar(
                            //   radius: 50,
                            //   backgroundImage: AssetImage(Images.img),
                            // )
                          ],
                        )
                      ],
                    )),
                pdf.Padding(
                    padding: const pdf.EdgeInsets.fromLTRB(32, 5, 0, 0),
                    child: pdf.Column(children: [
                      pdf.Row(
                        children: [
                          pdf.Text(
                            "Medical Details",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      pdf.SizedBox(
                        height: 10,
                      ),
                      pdf.Row(
                        children: [
                          pdf.Text(
                            "Blood Group :",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold, fontSize: 16),
                          ),
                          pdf.SizedBox(
                            width: 20,
                          ),
                          pdf.Text(
                            "A+",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      pdf.SizedBox(
                        height: 20,
                      ),
                      pdf.Row(
                        children: [
                          pdf.Text("Certification",
                              style: pdf.TextStyle(
                                  fontWeight: pdf.FontWeight.bold,
                                  fontSize: 20)),
                        ],
                      ),
                      pdf.Row(
                        children: [
                          pdf.Text(
                            "Date of Issuance :",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold, fontSize: 16),
                          ),
                          pdf.SizedBox(
                            width: 10,
                          ),
                          pdf.Text(
                            "March 27, 2024",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      pdf.Row(
                        children: [
                          pdf.Text(
                            "Signature of Doctor :",
                            style: pdf.TextStyle(
                                fontWeight: pdf.FontWeight.bold, fontSize: 16),
                          ),
                          pdf.SizedBox(
                            width: 15,
                          ),
                          // pdf.Image.asset(
                          //   Images.sign,
                          //   height: 40,
                          //   width: 40,
                          // )
                        ],
                      )
                    ])),
                pdf.Padding(
                    padding: const pdf.EdgeInsets.fromLTRB(32, 30, 0, 0),
                    child: pdf.Column(
                      children: [
                        pdf.Text(
                          "Certification provided by AID group in association with MedLab solutions. ",
                          style: pdf.TextStyle(
                              fontWeight: pdf.FontWeight.bold, fontSize: 12),
                        )
                      ],
                    )),
                // Buttons().solidButton(() => null, "Medical Card", )
                pdf.SizedBox(
                  height: 25,
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF document to a file
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/medical_card.pdf';
    final File file = File(path);
    await file.writeAsBytes(await document.save());

    // Return the bytes of the saved PDF file
    return await file.readAsBytes();
  }

  // Method to handle downloading the medical card
  Future<void> _downloadMedicalCard() async {
    // Generate the PDF bytes
    final List<int> bytes = await _generatePdfBytes();

    try {
      // Get the directory where the file will be saved
      final directory = await getApplicationDocumentsDirectory();

      // Create the file path
      final filePath = '${directory.path}/medical_card.pdf';

      // Write the PDF bytes to the file
      await File(filePath).writeAsBytes(bytes);

      // Show a snackbar to indicate that the medical card is downloaded
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medical card downloaded')),
      );
    } catch (e) {
      // Show an error message if there's any issue with saving the PDF
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to download medical card')),
      );
    }
    // Show a snackbar indicating that the medical card is downloaded

    // Optionally, you can share the file directly after downloading
    // await Share.shareFiles(['$dir/medical_card.pdf']);
  }

  // Method to handle sharing the medical card
  // Method to handle sharing the medical card
  Future<void> _shareMedicalCard() async {
    // Generate the PDF bytes
    final List<int> bytes = await _generatePdfBytes();

    // Save the generated PDF bytes to a file
    final String dir = (await getTemporaryDirectory()).path;
    final String path = '$dir/medical_card.pdf';
    final File file = File(path);
    await file.writeAsBytes(bytes);

    // Share the saved PDF file using the Share package
    await Share.shareFiles([
      path,
    ], text: 'Check out my medical card!', subject: 'Medical Card');
  }
}
