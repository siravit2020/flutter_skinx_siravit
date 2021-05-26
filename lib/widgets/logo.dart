import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/logo/goose.svg',
            height: 0.15.sh,
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            'Party\nHaan',
            style: theme.headline1,
          ),
        ],
      ),
    );
  }
}