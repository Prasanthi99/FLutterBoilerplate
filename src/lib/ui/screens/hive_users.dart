import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/models/api/user.dart';
import 'package:boilerplate/ui/base_screen.dart';
import 'package:boilerplate/ui/view_models/users_model.dart';

class SQLUsers extends BaseScreen {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseWidget<UsersModel>(onModelReady: (model) {
      model.getSQLUsers();
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  var id = DateTime.now().millisecondsSinceEpoch.toString();
                  var user = new User()
                    ..id = id
                    ..name = "User ${id}";
                  model.users.add(user);
                  model.addHiveUser(user);
                },
              ),
              appBar: AppBar(title: Text("Users")),
              body: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(model.users[index].name)))));
    });
  }
}
