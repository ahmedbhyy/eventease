import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showAwesomeDialog(BuildContext context ,String title,String desc, DialogType dialogType) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.rightSlide,
    title: title,
    desc: desc,
  ).show();
}
