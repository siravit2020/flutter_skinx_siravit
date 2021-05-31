import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skinx_siravit/servicers/globalkey_servicer.dart';

void showAcceptDialog({
 
  required Function function,
}) {
  
  showDialog(
    context: GlobalKeyService.instance.navigationKey.currentContext!,
    builder: (BuildContext context) {
      final theme = Theme.of(context).textTheme;
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 0.1.sw,
          ),
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
                'คุณต้องการเข้าร่วมปาร์ตี้\nใช่หรือไม่ ?',
                style: theme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: colorViolet,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        'ยกเลิก',
                        style: theme.bodyText2!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        function();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: colorViolet,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        'ตกลง',
                        style: theme.bodyText2!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
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
