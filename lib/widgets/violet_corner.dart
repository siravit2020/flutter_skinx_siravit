import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VioletCornerWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  const VioletCornerWidget({
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorViolet,
        elevation: 0,
        title: Text(
          title,
          style: theme.headline5!.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        color: colorViolet,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 0.08.sw,
          ),
          child: widget,
        ),
      ),
    );
  }
}
