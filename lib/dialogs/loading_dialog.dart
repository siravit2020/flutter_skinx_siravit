import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';

void showLoadingDialog(BuildContext context) {
  showGeneralDialog(
    barrierLabel: 'loading',
    barrierDismissible: true,
    barrierColor: Colors.white.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 50),
    context: context,
    pageBuilder: (_, __, ___) {
      return Center(
        child: CircularProgressIndicator(
          color: colorViolet,
        ),
      );
    },
  );
}
