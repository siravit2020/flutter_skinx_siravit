import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/servicers/globalkey_servicer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showErrorDialog({

  required String message,
  Function? function,
}) {
  
  showDialog(
    context: GlobalKeyService.instance.navigationKey.currentContext!,
    builder: (BuildContext context) {
      final theme = Theme.of(context).textTheme;
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 0.1.sw),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 2),
                blurRadius: 15,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'เกิดข้อผิดพลาด',
                style: theme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SvgPicture.asset(
                'assets/logo/goose.svg',
                width: 0.3.sw,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                '$message',
                textAlign: TextAlign.center,
                style: theme.bodyText2,
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (function != null) function();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: colorViolet,
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    'ลองอีกครั้ง',
                    style: theme.bodyText2!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      );
    },
  );
}
