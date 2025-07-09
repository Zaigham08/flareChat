// import 'dart:convert';
// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:external_path/external_path.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:open_file_plus/open_file_plus.dart';
//
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:flare_chat/data/app_exceptions.dart';
// import 'package:flare_chat/data/network/base_api_services.dart';
// import 'package:flare_chat/utils/utils.dart';
//
// class NetworkApiServices extends BaseApiServices {
//   final _authService = AuthService();
//
//   @override
//   Future getApi(String url) async {
//     String? idToken = await _authService.getIdToken();
//     final headers = {
//       'Authorization': 'Bearer $idToken',
//     };
//
//     dynamic responseJson;
//     try {
//       final response = await http
//           .get(Uri.parse(url), headers: headers)
//           .timeout(const Duration(seconds: 20));
//
//       debugPrint(idToken);
//       debugPrint("response ${response.body}");
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//
//     return responseJson;
//   }
//
//   @override
//   Future getApiWithParams(
//     String url,
//     var params, {
//     bool sendToken = true,
//   }) async {
//     debugPrint("param--- $params");
//
//     Map<String, String> headers;
//     String? idToken;
//
//     if (sendToken) {
//       idToken = await _authService.getIdToken();
//       headers = {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $idToken',
//       };
//     } else {
//       headers = {
//         'Content-Type': 'application/json',
//       };
//     }
//
//     dynamic responseJson;
//     try {
//       final response = await http
//           .get(Uri.parse(url).replace(queryParameters: params),
//               headers: headers)
//           .timeout(const Duration(seconds: 20));
//
//       debugPrint(idToken);
//       debugPrint("get param response ${response.body}");
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//
//     return responseJson;
//   }
//
//   @override
//   Future postApi(String url, var data, {int time = 50}) async {
//     debugPrint("data -----------------  ${jsonEncode(data)}");
//     String? idToken = await _authService.getIdToken();
//
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $idToken',
//     };
//     dynamic responseJson;
//     try {
//       final response = await http.post(Uri.parse(url),
//           headers: headers, body: jsonEncode(data));
//       debugPrint(idToken);
//       debugPrint("response ${response.body}");
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//
//     return responseJson;
//   }
//
//   @override
//   Future postApiWithParams(
//     String url,
//     var data,
//     var params, {
//     bool sendJson = true,
//   }) async {
//     debugPrint("params -----------------  ${jsonEncode(params)}");
//     String? idToken = await _authService.getIdToken();
//
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $idToken',
//     };
//     dynamic responseJson;
//     try {
//       final response = await http.post(
//         Uri.parse(url).replace(queryParameters: params),
//         headers: headers,
//         body: jsonEncode(data),
//       );
//       debugPrint(idToken);
//
//       if (sendJson) {
//         responseJson = returnResponse(response);
//       } else {
//         if (response.statusCode == 200) {
//           return response.bodyBytes;
//         } else {
//           throw Exception('${jsonDecode(response.body)["detail"]}');
//         }
//       }
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//     if (sendJson) {
//       return responseJson;
//     }
//   }
//
//   @override
//   Future putApi(String url, var data, var param) async {
//     debugPrint("data -----------------  $data");
//     String? idToken = await _authService.getIdToken();
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $idToken',
//     };
//     dynamic responseJson;
//     try {
//       final response = await http
//           .put(Uri.parse(url + param), headers: headers, body: jsonEncode(data))
//           .timeout(const Duration(seconds: 25));
//       debugPrint(idToken);
//       debugPrint("response ${response.body}");
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//
//     return responseJson;
//   }
//
//   @override
//   Future deleteApi(String url, var data) async {
//     debugPrint("data -----------------$url  $data");
//     String? idToken = await _authService.getIdToken();
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $idToken',
//     };
//     dynamic responseJson;
//     try {
//       final response = await http
//           .delete(Uri.parse(url), headers: headers, body: jsonEncode(data))
//           .timeout(const Duration(seconds: 20));
//       debugPrint(idToken);
//       debugPrint("response ${response.body}");
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//     return responseJson;
//   }
//
//   @override
//   Future deleteApiWithParams(String url, var params) async {
//     String? idToken = await _authService.getIdToken();
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $idToken',
//     };
//
//     dynamic responseJson;
//     try {
//       final response = await http
//           .delete(Uri.parse(url).replace(queryParameters: params),
//               headers: headers)
//           .timeout(const Duration(seconds: 20));
//
//       debugPrint(idToken);
//       debugPrint("param response ${response.body}");
//
//       responseJson = returnResponse(response);
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//     return responseJson;
//   }
//
//   Future multipartRequestApi({
//     required String url,
//     required String filePath,
//     required var params,
//     bool returnBytes = false,
//   }) async {
//     final request = http.MultipartRequest(
//         'POST', Uri.parse(url).replace(queryParameters: params));
//
//     String? idToken = await _authService.getIdToken();
//     final headers = {
//       'Authorization': 'Bearer $idToken',
//       'Content-Type': 'multipart/form-data',
//     };
//     // Add file to the request
//     final file = await http.MultipartFile.fromPath(
//       'file',
//       filePath,
//     );
//     request.files.add(file);
//     // Set headers
//     request.headers.addAll(headers);
//     dynamic responseJson;
//     try {
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       debugPrint(idToken);
//       debugPrint("file response ${response.body}");
//       if (returnBytes) {
//         if (response.statusCode == 200) {
//           return response.bodyBytes;
//         } else if (response.statusCode == 400) {
//           throw Exception(jsonDecode(response.body)["detail"]);
//         } else {
//           throw Exception('${jsonDecode(response.body)["detail"]}');
//         }
//       } else {
//         responseJson = returnResponse(response);
//       }
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//     return responseJson;
//   }
//
//   Future<String> multipartRequestApiForImage({
//     required String url,
//     required String filePath,
//   }) async {
//     final request = http.MultipartRequest('POST', Uri.parse(url));
//
//     String? idToken = await _authService.getIdToken();
//     final headers = {
//       'Authorization': 'Bearer $idToken',
//       'Content-Type': 'multipart/form-data',
//     };
//     // Add file to the request
//     final file = await http.MultipartFile.fromPath(
//       'file',
//       filePath,
//     );
//     request.files.add(file);
//     // Set headers
//     request.headers.addAll(headers);
//     try {
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       debugPrint(idToken);
//       debugPrint("response ${response.body}");
//       if (response.statusCode == 200) {
//         return response.body;
//       } else if (response.statusCode == 400) {
//         return "400";
//       } else {
//         throw Exception('${jsonDecode(response.body)["detail"]}');
//       }
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//   }
//
//   Future<void> uploadImage(
//     String presignedUrl,
//     File imageFile,
//   ) async {
//     try {
//       // Read the file as bytes
//       final imageBytes = await imageFile.readAsBytes();
//
//       // Make a PUT request to upload the image
//       final response = await http.put(
//         Uri.parse(presignedUrl),
//         body: imageBytes,
//       );
//
//       if (response.statusCode == 200) {
//         debugPrint("Image uploaded successfully!");
//       } else {
//         Utils.toastMsg("Error uploading image: ${response.statusCode}");
//         debugPrint("Error uploading image: ${response.statusCode}");
//         debugPrint("Response body: ${response.body}");
//       }
//     } catch (e) {
//       debugPrint("Error uploading image: $e");
//     }
//   }
//
//   Future<void> uploadImages(
//     List<String> presignedUrls,
//     List<File> imageFiles,
//   ) async {
//     if (presignedUrls.length != imageFiles.length) {
//       debugPrint("Error: The number of URLs and image files must match.");
//       return;
//     }
//
//     try {
//       for (int i = 0; i < presignedUrls.length; i++) {
//         final presignedUrl = presignedUrls[i];
//         final imageFile = imageFiles[i];
//
//         // Read the file as bytes
//         final imageBytes = await imageFile.readAsBytes();
//
//         // Make a PUT request to upload the image
//         final response = await http.put(
//           Uri.parse(presignedUrl),
//           body: imageBytes,
//         );
//
//         if (response.statusCode == 200) {
//           debugPrint("Image $i uploaded successfully!");
//         } else {
//           Utils.toastMsg("Error uploading image $i: ${response.statusCode}");
//           debugPrint("Error uploading image $i: ${response.statusCode}");
//           debugPrint("Response body: ${response.body}");
//         }
//       }
//     } catch (e) {
//       debugPrint("Error uploading images: $e");
//     }
//   }
//
//   Future downloadFile(
//       String url, var params, String fileName, String fileExtension) async {
//     String? idToken = await _authService.getIdToken();
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $idToken',
//     };
//     try {
//       final response = await http.get(
//         Uri.parse('$url$fileName/download').replace(queryParameters: params),
//         headers: headers,
//       );
//
//       final timestamp = DateTime.now().millisecondsSinceEpoch;
//       if (fileExtension == '.yt') {
//         fileExtension = '.txt';
//       }
//       final completeFileName = '$fileName-$timestamp$fileExtension'.trim();
//       debugPrint(idToken);
//
//       await writeFileBytes(completeFileName, response.bodyBytes);
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//   }
//
//   Future postApiForFileBytes(String url, var data,
//       {bool showToast = true}) async {
//     debugPrint("data -----------------  $data");
//     String? idToken = await _authService.getIdToken();
//
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $idToken',
//     };
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: headers,
//         body: jsonEncode(data),
//       );
//       debugPrint(idToken);
//       if (response.statusCode == 200) {
//         return response.bodyBytes;
//       } else if (response.statusCode == 400) {
//         List<int> limitReachedBytes = utf8.encode("LIMIT_REACHED");
//         if (showToast) {
//           Utils.toastMsg(jsonDecode(response.body)["detail"]);
//         }
//         return limitReachedBytes;
//       } else {
//         throw Exception('${jsonDecode(response.body)["detail"]}');
//       }
//     } on SocketException {
//       throw InternetException('');
//     } on RequestTimeOutException {
//       throw RequestTimeOutException('');
//     }
//   }
//
//   Future<void> writeFileBytes(String fileName, List<int> bytes) async {
//     // Check for permission and request if not granted
//     bool hasPermission = await checkStoragePermission();
//
//     if (hasPermission) {
//       String? filePath;
//
//       if (Platform.isAndroid) {
//         final downloadsDirectory =
//             await ExternalPath.getExternalStoragePublicDirectory(
//           ExternalPath.DIRECTORY_DOWNLOAD,
//         );
//         filePath = path.join(downloadsDirectory, fileName);
//       } else if (Platform.isIOS) {
//         // On iOS, use the Documents directory to store files
//         final directory = await getApplicationDocumentsDirectory();
//         filePath = path.join(directory.path, fileName);
//       }
//
//       if (filePath != null) {
//         final file = File(filePath);
//         await file.writeAsBytes(Uint8List.fromList(bytes));
//
//         Utils.toastMsg('File saved at ${file.path}');
//         OpenFile.open(file.path);
//       }
//     } else {
//       Utils.toastMsg('Storage Permission denied');
//     }
//   }
//
//   Future<void> downloadImageByUrl(
//       {required String url, String? imgExtension}) async {
//     String extension =
//         imgExtension ?? url.split('/').last.split('?').first.split('.').last;
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     try {
//       // Check for permission and request if not granted
//       bool hasPermission = await checkStoragePermission();
//       if (hasPermission) {
//         String? filePath;
//
//         if (Platform.isAndroid) {
//           final dir = await ExternalPath.getExternalStoragePublicDirectory(
//             ExternalPath.DIRECTORY_DOWNLOAD,
//           );
//           filePath = '$dir/typicl-image-$timestamp.$extension';
//         } else if (Platform.isIOS) {
//           final dir = await getApplicationDocumentsDirectory();
//           filePath = '${dir.path}/typicl-image-$timestamp.$extension';
//         }
//
//         final response = await http.get(Uri.parse(url));
//         if (response.statusCode == 200) {
//           final file = File(filePath!);
//           await file.writeAsBytes(response.bodyBytes);
//           Utils.toastMsg('Image saved at $filePath');
//           OpenFile.open(file.path);
//         } else {
//           debugPrint('Failed to download file: ${response.statusCode}');
//         }
//       } else {
//         Utils.toastMsg('Permission denied');
//       }
//     } catch (e) {
//       Utils.toastMsg('Failed to download image: $e');
//     }
//   }
//
//   Future<void> shareImageByUrl(String imageUrl) async {
//     try {
//       Utils.showLoadingDialog("Preparing...");
//       final tempDir = await getTemporaryDirectory();
//
//       final fileName = imageUrl.split('/').last.split('?').first;
//       final filePath = '${tempDir.path}/$fileName';
//
//       final response = await http.get(Uri.parse(imageUrl));
//       if (response.statusCode == 200) {
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//
//         Utils.dismissLoadingDialog();
//         await Share.shareXFiles([XFile(file.path)]).then((value) {
//           file.delete();
//         });
//
//         debugPrint('Image shared successfully from $filePath');
//       } else {
//         Utils.dismissLoadingDialog();
//         debugPrint('Failed to download image: ${response.statusCode}');
//         throw Exception('Failed to download image. Please try again.');
//       }
//     } catch (e) {
//       Utils.dismissLoadingDialog();
//       debugPrint('Error downloading and sharing image: $e');
//     }
//   }
//
//   Future<bool> checkStoragePermission() async {
//     if (Platform.isAndroid) {
//       final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//       final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
//       if ((info.version.sdkInt) >= 33) {
//         // No need to request storage permission for Android 13 and above
//         return true;
//       } else {
//         var status = await Permission.storage.status;
//         if (!status.isGranted) {
//           status = await Permission.storage.request();
//         }
//         return status.isGranted;
//       }
//     } else {
//       var status = await Permission.storage.status;
//       if (!status.isGranted) {
//         status = await Permission.storage.request();
//       }
//       return status.isGranted;
//     }
//   }
//
//   dynamic returnResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//       case 409:
//       case 400:
//       case 403:
//         return jsonDecode(response.body);
//       case 401:
//         throw ValidationException("Invalid Authentication");
//       case 404:
//         throw ServerException();
//       case 422:
//         throw ValidationException("Validation Error");
//       case 500:
//       case 503:
//         throw FetchDataException(
//             'Server under maintenance,Try again later!. Status: ${response.statusCode.toString()}');
//       default:
//         throw FetchDataException(
//             'Error occurred while communicating with server. Status: ${response.statusCode.toString()}');
//     }
//   }
// }
