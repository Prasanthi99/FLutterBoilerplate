import 'package:boilerplate/ui/screens/hive_users.dart';
import 'package:boilerplate/ui/screens/sql_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/models/core/app_context.dart';
import 'package:boilerplate/models/core/base_model.dart';
import 'package:boilerplate/services/device/temperature_service.dart';
import 'package:boilerplate/services/device/toast_service.dart';
import 'package:boilerplate/ui/widgets/app_drawer.dart';
import 'package:boilerplate/ui/screens/share.dart';

class Dashboard extends StatelessWidget {
  TextStyle style = TextStyle(fontSize: 20);
  @override
  Widget build(BuildContext context) {
    var appContext = Provider.of<AppContext>(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            drawer: AppDrawerBuilder.build(appContext, context),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Text("Hello!! ${appContext?.userContext?.displayName ?? ''}",
                      style: style, textAlign: TextAlign.center),
                  Text(
                      "You're using ${Provider.of<ConnectivityStatus>(context).toString().split(".").last}",
                      style: style,
                      textAlign: TextAlign.center),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => new Share()));
                    },
                    child: Text("Share something with your friends",
                        textAlign: TextAlign.center),
                    color: Colors.white,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => new SQLUsers()));
                    },
                    child: Text("Test SQL", textAlign: TextAlign.center),
                    color: Colors.white,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => new HiveUsers()));
                    },
                    child: Text("Test NoSQL", textAlign: TextAlign.center),
                    color: Colors.white,
                  ),
                  RaisedButton(
                      onPressed: () async {
                        var result = await TemperatureService.initialize();
                        ToastService.showToast(
                            msg: (result ?? false)
                                ? "Initialized sensor"
                                : "Something went wrong!!",
                            backgroundColor: Colors.white);
                      },
                      child: Text("Initialize temperature sensor")),
                  StreamBuilder<double>(
                      builder: (BuildContext context,
                          AsyncSnapshot<double> snapshot) {
                        if (snapshot.hasData) {
                          return Text("Temperature ${snapshot.data}");
                        }
                        return Container();
                      },
                      stream: TemperatureService.temperatureStream),
                  RaisedButton(
                    onPressed: () {
                      ToastService.showToast(msg: "Sample Toast");
                    },
                    child: Text("Show Toast", textAlign: TextAlign.center),
                    color: Colors.white,
                  )
                ]))));
  }
}
