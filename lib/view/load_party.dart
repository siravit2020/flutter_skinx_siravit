import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/providers/party_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skinx_siravit/view/party.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadPartyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final loading =
        context.select((PartyChangeNotifierProvider p) => p.loading);
    final partyProvider = context.read<PartyChangeNotifierProvider>();
    if (partyProvider.listParty != null)
      print('restart2 ${partyProvider.listParty!.length}');
    return Container(
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
        child: !loading
            ? partyProvider.listParty!.isNotEmpty
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
                      height: 20.h,
                    ),
                    Text(
                      'Loading',
                      style: theme.bodyText1,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
