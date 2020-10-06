import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/ui/base_screen.dart';
import 'package:boilerplate/ui/view_models/logger_model.dart';

class LogsScreen extends BaseScreen {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoggerModel>(
      onModelReady: (model) async {
        await model.getAll();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: new AppBar(
            title: Text("Logs"),
          ),
          body: Scrollbar(
            child: model.logs.length != 0
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: Colors.grey[400],
                        height: 6.0,
                      );
                    },
                    itemCount: model.logs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(model.logs[index].methodName),
                          subtitle: Text(
                            model.logs[index].text,
                          ));
                    },
                  )
                : Center(
                    child: Text("No logs Found"),
                  ),
          ),
          floatingActionButton: (model.logs.length > 0)
              ? new FloatingActionButton.extended(
                  onPressed: () {
                    model.clearAll();
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.delete),
                  label: new Text(
                    "Clear",
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : null,
        );
      },
    );
  }
}
