import 'package:bloc/bloc.dart';
import 'package:math/bloc/webview/webview_state.dart';

class WebViewLogic extends Cubit<WebViewState> {
  WebViewLogic() : super(InitWebView());
  bool isLoad = false;

  void onWebViewCreated() {
    isLoad = true;
    emit(LoadWebView());
  }

  bool get isWebViewLoaded => isLoad;
}
