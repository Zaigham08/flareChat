import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

launchEmail(String toEmail, String subject) async {
  final url =
  Uri.parse('mailto:$toEmail?subject=${Uri.encodeComponent(subject)}');
  await launchUrl(url);
}

String constructWebSocketUrl(String baseUrl, Map<String, String> params) {
  Uri uri = Uri.parse(baseUrl);
  Uri updatedUri = uri.replace(queryParameters: params);
  return updatedUri.toString();
}

String formatDate(String isoDateString) {
  final dateTime = DateTime.parse(isoDateString).toLocal();
  return DateFormat("d MMMM, y").format(dateTime);
}