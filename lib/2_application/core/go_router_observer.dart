import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    print(
        "DidPop >> ${route.settings.name} previous =>  ${previousRoute?.settings.name}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint(
        "didPush =>> ${route.settings.name} previous Route => ${previousRoute?.settings.name}");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint(
        "didRemove => ${route.settings.name} - previous Route => ${previousRoute?.settings.name}");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint(
        "didReplace => ${newRoute?.settings.name} old route => ${oldRoute!.settings.name} ");
  }
}
