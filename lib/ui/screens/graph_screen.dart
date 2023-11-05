import '../widget/offline.dart';
import '../../assets/link_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math/ui/screens/my_app_bar.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:math/bloc/webview/webview_logic.dart';
import 'package:math/bloc/webview/webview_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WebViewLogic(),
      child: BlocConsumer<WebViewLogic, WebViewState>(
        listener: (context, state) {},
        builder: (context, state) {
          WebViewLogic webView = BlocProvider.of(context);
          return Scaffold(
            appBar: const MyAppBar(),
            body: SafeArea(
              child: Builder(
                builder: (BuildContext context) {
                  return OfflineBuilder(
                    connectivityBuilder: (BuildContext context,
                        ConnectivityResult connectivity, Widget child) {
                      final bool connected =
                          connectivity != ConnectivityResult.none;
                      return connected
                          ? Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: WebView(
                                    zoomEnabled: true,
                                    onPageFinished: (url) =>
                                        webView.onWebViewCreated(),
                                    initialUrl: kGraphAPIKey,
                                    javascriptMode: JavascriptMode.unrestricted,
                                  ),
                                ),
                                !webView.isWebViewLoaded
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox()
                              ],
                            )
                          : myOfflineWidget();
                    },
                    child: const SizedBox(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
