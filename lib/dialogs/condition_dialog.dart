import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showConditionDialog(BuildContext context) {
  final theme = Theme.of(context).textTheme;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 0.1.sw),
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
                'เงื่อนไขและข้อตกลง',
                style: theme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    for (int i = 1; i <= 10; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '$i. รับผมหน่อยครับ',
                          textAlign: TextAlign.center,
                          style: theme.bodyText2,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: colorViolet,
                    shape: StadiumBorder(),
                  ),
                  child: Text('ปิด'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    },
  );
}
