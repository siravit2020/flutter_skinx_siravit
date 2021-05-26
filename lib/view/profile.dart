import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/providers/profile_provider.dart';
import 'package:flutter_skinx_siravit/widgets/fill_button.dart';
import 'package:flutter_skinx_siravit/widgets/violet_corner.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final profileProvider = context.read<ProfileChangeNotifierProvider>();
    profileProvider.initialData();
    return Scaffold(
      body: VioletCornerWidget(
        title: 'โปรไฟล์ของฉัน',
        widget: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 0.2.sw,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    profileProvider.name != null ? profileProvider.name! : '',
                    style: theme.headline5,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _CountParty(),
                  SizedBox(
                    height: 40.h,
                  ),
                  // _MyParty(),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: FillButton(
                title: 'ออกจากระบบ',
                color: colorRed,
                function: () {
                  profileProvider.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountParty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final profileProvider = context.watch<ProfileChangeNotifierProvider>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            profileProvider.userParty != null
                ? Text(
                    profileProvider.userParty!.partyCreate != null
                        ? '${profileProvider.userParty!.partyCreate!.length}'
                        : '0',
                    style: theme.headline5,
                  )
                : Text(
                    '0',
                    style: theme.headline5,
                  ),
            Text(
              'สร้างปาร์ตี้',
              style: theme.bodyText2,
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            profileProvider.userParty != null
                ? Text(
                    profileProvider.userParty!.partyList != null
                        ? '${profileProvider.userParty!.partyList!.length}'
                        : '0',
                    style: theme.headline5,
                  )
                : Text(
                    '0',
                    style: theme.headline5,
                  ),
            Text(
              'เข้าร่วมปาร์ตี้',
              style: theme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
