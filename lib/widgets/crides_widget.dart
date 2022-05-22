import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsWidget extends StatelessWidget {
  const CreditsWidget({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Developed By',
          style: TextStyle(color: Colors.grey),
        ),
        TextButton(
          onPressed: () => _launchUrl('https://eyes-soft.web.app/#/'),
          child: const Text('Abdul Haseeb'),
        ),
      ],
    );
  }
}
