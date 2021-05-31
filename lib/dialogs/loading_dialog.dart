import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/servicers/globalkey_servicer.dart';

void showLoadingDialog() {
  showGeneralDialog(
    barrierLabel: 'loading',
    barrierDismissible: false,
    barrierColor: Colors.white.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 50),
    context: GlobalKeyService.instance.navigationKey.currentContext!,
    pageBuilder: (_, __, ___) {
      return Center(
        child: CircularProgressIndicator(
          color: colorViolet,
        ),
      );
    },
  );
}
