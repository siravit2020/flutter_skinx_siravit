import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/providers/party_provider.dart';
import 'package:flutter_skinx_siravit/server/cloud_firestore.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
import 'package:flutter_skinx_siravit/view/party.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skinx_siravit/widgets/logo.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final listParty =
        context.select((PartyChangeNotifierProvider p) => p.listParty);
    print('restart');
    return Scaffold(
      backgroundColor: colorGrey,
      appBar: AppBar(
        backgroundColor: colorViolet,
        elevation: 0,
        title: Text(
          'ปาร์ตี้ทั้งหมด',
          style: theme.headline5!.copyWith(
            color: colorWhite,
          ),
        ),
        actions: [
          Center(
            child: _AddPartyButton(),
          ),
          IconButton(
            onPressed: () {
              NavigationService.instance.navigateTo('profile');
            },
            icon: Icon(Icons.account_circle_outlined),
            color: colorWhite,
            splashRadius: 20,
            iconSize: 40,
          ),
        ],
      ),
      body: Container(
        color: colorViolet,
        child: Container(
          decoration: BoxDecoration(
            color: colorGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          child: listParty != null
              ? listParty.isNotEmpty
                  ? PartyPage()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logo/goose.svg',
                            height: 0.15.sh,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'ยังไม่มีปาร์ตี้',
                            style: theme.headline5!.copyWith(
                              color: colorBlack.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorViolet,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Loading',
                        style: TextStyle(
                          color: colorBlack,
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _AddPartyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        NavigationService.instance.navigateTo('createParty');
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        minimumSize: Size(0, 33),
        shape: StadiumBorder(),
      ),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: colorViolet,
          ),
          Text(
            'เพิ่มปาร์ตี้',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: colorViolet,
                ),
          ),
        ],
      ),
    );
  }
}
