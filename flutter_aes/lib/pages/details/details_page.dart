// ignore_for_file: library_prefixes, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_aes/app/data/hive_manager.dart';
import 'package:flutter_aes/core/constant/color_constant.dart';
import 'package:flutter_aes/core/extension/content_extension.dart';
import 'package:flutter_aes/core/init/theme/theme.dart';
import 'package:flutter_aes/src/text_string.dart';
import 'package:flutter_aes/widgets/bottom_nav_bar_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_aes/widgets/icon.dart' as CustomIcons;

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final Box box = Hive.box("password"); ///////////////////// Hive manager

  @override
  Widget build(BuildContext context) {
    int index = box.values.length;
    Map data = box.get(index);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(TextWidget.labelText),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavigationBarWid()));
          },
        ),
      ),
      body: listViewBuilder(index, data),
    );
  }

  ListView listViewBuilder(int index, Map<dynamic, dynamic> data) {
    return ListView.builder(
      itemCount: index,
      itemBuilder: (context, index) {
        data = box.getAt(index);
        return Column(
          children: <Widget>[
            const SizedBox(height: 50), //////////////////////
            serviceIcons(data),
            const SizedBox(height: 20), /////////////////////
            wrapContext(data, context, index),
          ],
        );
      },
    );
  }

  Wrap wrapContext(Map<dynamic, dynamic> data, BuildContext context, index) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: context.paddingNormalHorizontal,
          child: Container(
            width: double.infinity,
            padding: context.paddingOnlyBottom,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: whiteColor,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                  color: greyColor,
                  blurRadius: 12,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: columnContext(data, context, index),
          ),
        ),
      ],
    );
  }

  Column columnContext(
      Map<dynamic, dynamic> data, BuildContext context, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //TITLE
        titlePadding(TextWidget.serviceTextUpper),
        subTitleRow(data, "${data['type']}"),
        titlePadding(TextWidget.usernameTextUpper),
        subTitleRow(data, "${data['email']}"),
        //PASSWORD
        titlePadding(TextWidget.passTextUpper),
        passwordCopy(data, context, index),
      ],
    );
  }

  Row subTitleRow(Map<dynamic, dynamic> data, String text) {
    return Row(
      children: <Widget>[
        Container(
          margin: context.paddingLeftAndTop,
          child: Text(
            text,
            style: ThemeApp.textTheme.headline5,
          ),
        ),
      ],
    );
  }

  Row passwordCopy(Map<dynamic, dynamic> data, BuildContext context, index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: context.paddingOnlyLeft,
          child: Text(
            "${data['password']}",
            style: ThemeApp.textTheme.headline5,
          ),
        ),
        passwordIconCopy(data, context, index),
      ],
    );
  }

  IconButton passwordIconCopy(
      Map<dynamic, dynamic> data, BuildContext context, index) {
    return IconButton(
      tooltip: TextWidget.copyMessage,
      onPressed: () {
        HiveData().onTap(data, context, index);
      },
      icon: Icon(
        Icons.content_copy,
        color: Colors.grey[700],
        size: 20.0,
      ),
    );
  }

  Center serviceIcons(Map<dynamic, dynamic> data) {
    return Center(
      child: ClipOval(
        child: CustomIcons.icons[data['type'.trim()]] ??
            const Icon(
              Icons.lock,
              size: 32.0,
              color: iconColor,
            ),
      ),
    );
  }

  Padding titlePadding(String text) {
    return Padding(
      padding: context.paddingLeftAndTop,
      child: Text(
        text,
        style: ThemeApp.textTheme.headline5,
      ),
    );
  }
}




///////////// Parolayı ** olarak göstermek için /////

  /* String showPassword(dynamic data, int index) {
    Map data = box.getAt(index);
    int pass = "${data['password']}".length;
    String str = "*";
    for (int i = 1; i < pass; i++) {
      str = "$str*";
    }
    return str;
  }*/