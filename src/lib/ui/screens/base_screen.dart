import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/models/core/base_model.dart';
import 'package:boilerplate/services/service_locator.dart';

abstract class BaseScreen extends StatelessWidget {}

class BaseWidget<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;
  final Function(T) onDispose;

  BaseWidget({this.builder, this.onModelReady, this.onDispose});
  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseModel> extends State<BaseWidget<T>>
    with AutomaticKeepAliveClientMixin {
  T model = ServiceLocator.getInstance<T>();
  _BaseWidgetState();
  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose(model);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
