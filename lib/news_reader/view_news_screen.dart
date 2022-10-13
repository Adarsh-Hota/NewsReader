import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewNewsScreen extends StatelessWidget {
  final String url;

  const ViewNewsScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
    );
  }
}
