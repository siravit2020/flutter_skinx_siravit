import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/dialogs/loading_dialog.dart';
import 'package:flutter_skinx_siravit/providers/party_provider.dart';
import 'package:flutter_skinx_siravit/servicers/navigation_service.dart';
import 'package:flutter_skinx_siravit/widgets/fill_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PartyPage extends StatelessWidget {
  const PartyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyProvider = context.watch<PartyChangeNotifierProvider>();
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        itemCount: partyProvider.listParty!.length,
        itemBuilder: (BuildContext context, int index) {
          final itemParty = partyProvider.listParty![index];
          return Card(
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: itemParty.imageUrl != null
                      ? FadeInImage(
                          placeholder: AssetImage('assets/images/white.png'),
                          image: NetworkImage('${itemParty.imageUrl}'),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/party_time.jpg',
                          fit: BoxFit.cover,
                        ),
                  // Image.network('${itemParty.imageUrl}'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${itemParty.title}',
                        style: theme.bodyText1!
                            .copyWith(fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  color: colorBlack.withOpacity(0.3),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.groups_outlined,
                            color: colorViolet,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            itemParty.memberList != null
                                ? '${itemParty.memberList!.length}/${itemParty.memberMax}'
                                : '0/${itemParty.memberMax}',
                            style: theme.bodyText2!.copyWith(
                              color: colorViolet,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Builder(builder: (context) {
                        if (itemParty.host ==
                            FirebaseAuth.instance.currentUser!.uid)
                          return _FillButton(
                            title: 'เจ้าของปาร์ตี้',
                            color: colorRed,
                            function: () async {},
                          );
                        else if (!itemParty.join!)
                          return _FillButton(
                            title: 'เข้าร่วม',
                            color: colorViolet,
                            function: () async {
                              showLoadingDialog(context);
                              await partyProvider.updateMember(index);
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              partyProvider.update();
                              NavigationService.instance.pop();
                            },
                          );
                        else
                          return _FillButton(
                            title: 'อยู่ในปาร์ตี้',
                            color: colorGreyMedium,
                            function: () async {},
                          );
                      }),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      ),
    );
  }
}

class _FillButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function function;

  const _FillButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        function();
      },
      style: TextButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(color: color),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: color,
            ),
      ),
    );
  }
}
