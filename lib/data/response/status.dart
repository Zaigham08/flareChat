// // enum Status{LOADING, COMPLETED, ERROR}
//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
//
// class MyStreamingWidget extends StatefulWidget {
//   @override
//   _MyStreamingWidgetState createState() => _MyStreamingWidgetState();
// }
//
// class _MyStreamingWidgetState extends State<MyStreamingWidget> {
//   final StreamController<String> _streamController = StreamController<String>();
//   String _accumulatedData = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchStreamedData();
//   }
//
//   void _fetchStreamedData() async {
//     final httpClient = HttpClient();
//
//     try {
//
//       final Map<String, dynamic> payload = {
//         'collection_name': 'haha',
//         'chat_history': [],
//         'prompt': 'hi, gimme 10 maths equation in latex. ',
//         'model': 'gpt-3.5-turbo',
//         'language': 'English'
//       };
//
//       request.write(jsonEncode(payload));
//
//       final HttpClientResponse response = await request.close();
//
//       if (response.statusCode == 200) {
//         response.transform(utf8.decoder).listen((String data) {
//           _accumulatedData += data;
//           _streamController.add(_accumulatedData);
//         });
//       } else {
//         response.transform(utf8.decoder).join().then((String errorMessage) {
//           print(
//               'Error with the request: ${response.statusCode}, $errorMessage');
//           _streamController
//               .addError('Error: ${response.statusCode}, $errorMessage');
//         });
//       }
//     } catch (error) {
//       print('Exception: $error');
//       _streamController.addError('Exception: $error');
//     }
//   }
//
//   List<Widget> _parseContent(String content) {
//     List<Widget> widgets = [];
//     List<String> delimiters = [
//       r'\(',
//       r'\)',
//       r'\[',
//       r'\]',
//       r'$',
//       r'$',
//       r'$$',
//       r'$$',
//       r'\begin{equation}',
//       r'\end{equation}',
//       r'\begin{align}',
//       r'\end{align}'
//     ];
//     int lastMatchedIndex = 0;
//     int i = 0;
//
//     while (i < content.length) {
//       bool found = false;
//
//       for (String delimiter in delimiters) {
//         if (content.startsWith(delimiter, i)) {
//           String markdownPart = content.substring(lastMatchedIndex, i);
//
//           if (markdownPart.isNotEmpty) {
//             widgets.add(Text(markdownPart));
//           }
//
//           int j = i + delimiter.length;
//           String endDelim = delimiter;
//
//           // Find the corresponding end delimiter
//           if (delimiter == r'\(') {
//             endDelim = r'\)';
//           } else if (delimiter == r'\[') {
//             endDelim = r'\]';
//           }
//
//           while (j < content.length) {
//             if (content.startsWith(endDelim, j)) {
//               String latexPart = content.substring(i + delimiter.length, j);
//               widgets.add(Math.tex(latexPart,
//                   settings: const TexParserSettings(strict: Strict.ignore)));
//               i = j + endDelim.length;
//               lastMatchedIndex = i;
//               found = true;
//               break;
//             }
//             j++;
//           }
//         }
//
//         if (found) {
//           break;
//         }
//       }
//
//       if (!found) {
//         i++;
//       }
//     }
//
//     if (lastMatchedIndex < content.length) {
//       String remainingMarkdown = content.substring(lastMatchedIndex);
//       widgets.add(Text(remainingMarkdown));
//     }
//
//     return widgets;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<String>(
//       stream: _streamController.stream,
//       builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData) {
//           return const Text('No data received yet.');
//         } else {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: _parseContent(snapshot.data!),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _streamController.close();
//     super.dispose();
//   }
// }
