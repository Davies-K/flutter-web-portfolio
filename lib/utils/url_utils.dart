import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(
    uri,
    webOnlyWindowName: uri.scheme == 'mailto' ? '_self' : '_blank',
  );
}
