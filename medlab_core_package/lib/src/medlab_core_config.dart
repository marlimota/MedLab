import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:medlab_core_package/src/loader/medlab_loader.dart';

class MedLabCoreConfig extends StatelessWidget {
  const MedLabCoreConfig({
    super.key,
    this.binding,
    this.pages,
    this.pagesBuilders,
    this.modules,
    required this.title,
  });

  final ApplicationBindings? binding;
  final List<FlutterGetItPageRouter>? pages;
  final List<FlutterGetItPageBuilder>? pagesBuilders;
  final List<FlutterGetItModule>? modules;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
        debugMode: kDebugMode,
        bindings: binding,
        pages: [...pages ?? [], ...pagesBuilders ?? []],
        modules: modules,
        builder: (context, routes, flutterGetItNavObserver) {
          return AsyncStateBuilder(
              loader: MedLabLoader(),
              builder: (navigatorObserver) {
                return MaterialApp(
                  navigatorObservers: [
                    navigatorObserver,
                    flutterGetItNavObserver,
                  ],
                  routes: routes,
                  title: title,
                );
              });
        });
  }
}
