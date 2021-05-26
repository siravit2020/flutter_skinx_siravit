
import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/providers/party_provider.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
import 'package:flutter_skinx_siravit/view/load_party.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    context.read<PartyChangeNotifierProvider>().fakeDowload();
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
      body: LoadPartyPage(),
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
