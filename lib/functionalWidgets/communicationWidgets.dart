import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunicationFeatures extends StatelessWidget {
  final String widgetToShow;

  const CommunicationFeatures({super.key, required this.widgetToShow});

  @override
  Widget build(BuildContext context) {
    switch (widgetToShow) {
      case "PhoneCaller":
        return const PhoneCaller();
      case "EmailSender":
        return const EmailSender();
      case "WebBrowser":
        return const WebBrowser();
      case "SMSSender":
        return const SMSSender();
      default:
        return const PhoneCaller();
    }
  }
}

class PhoneCaller extends StatefulWidget {
  const PhoneCaller({super.key});

  @override
  State<PhoneCaller> createState() => _PhoneCallerState();
}

class _PhoneCallerState extends State<PhoneCaller> {
  final TextEditingController _phoneController = TextEditingController();
  String _message = '';

  Future<void> _makePhoneCall() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: _phoneController.text,
    );

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        setState(() {
          _message = 'Could not launch phone app';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Caller'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _makePhoneCall,
              icon: const Icon(Icons.call),
              label: const Text('Call Number'),
            ),
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.startsWith('Error')
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class EmailSender extends StatefulWidget {
  const EmailSender({super.key});

  @override
  State<EmailSender> createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  String _message = '';

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _emailController.text,
      query:
          'subject=${Uri.encodeComponent(_subjectController.text)}&body=${Uri.encodeComponent(_bodyController.text)}',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        setState(() {
          _message = 'Could not launch email app';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Sender'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter email address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                hintText: 'Enter email subject',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.subject),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Body',
                hintText: 'Enter email body',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(Icons.send),
              label: const Text('Send Email'),
            ),
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.startsWith('Error')
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WebBrowser extends StatefulWidget {
  const WebBrowser({super.key});

  @override
  State<WebBrowser> createState() => _WebBrowserState();
}

class _WebBrowserState extends State<WebBrowser> {
  final TextEditingController _urlController = TextEditingController();
  String _message = '';

  Future<void> _openUrl() async {
    String url = _urlController.text;

    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        setState(() {
          _message = 'Could not launch browser';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Browser'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'Website URL',
                hintText: 'Enter website URL',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.web),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openUrl,
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open Website'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _urlController.text = 'google.com';
                  },
                  child: const Text('Google'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _urlController.text = 'flutter.dev';
                  },
                  child: const Text('Flutter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _urlController.text = 'pub.dev';
                  },
                  child: const Text('Pub.dev'),
                ),
              ],
            ),
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.startsWith('Error')
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SMSSender extends StatefulWidget {
  const SMSSender({super.key});

  @override
  State<SMSSender> createState() => _SMSSenderState();
}

class _SMSSenderState extends State<SMSSender> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _status = '';

  Future<void> _sendSMS() async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: _phoneController.text,
      queryParameters: {'body': _messageController.text},
    );

    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        setState(() {
          _status = 'Could not launch SMS app';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Sender'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Message',
                hintText: 'Enter your message',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.message),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _sendSMS,
              icon: const Icon(Icons.sms),
              label: const Text('Send SMS'),
            ),
            if (_status.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _status,
                  style: TextStyle(
                    color:
                        _status.startsWith('Error') ? Colors.red : Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
