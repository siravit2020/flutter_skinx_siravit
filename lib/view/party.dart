import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skinx_siravit/config/colors/color_palette.dart';
import 'package:flutter_skinx_siravit/dialogs/accept_dialog.dart';
import 'package:flutter_skinx_siravit/dialogs/error_dialog.dart';
import 'package:flutter_skinx_siravit/models/party_model.dart';
import 'package:flutter_skinx_siravit/providers/party_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PartyPage extends StatelessWidget {
  const PartyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyProvider = context.read<PartyChangeNotifierProvider>();
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
      ),
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
                _ImageWidget(
                  itemParty: itemParty,
                ),
                _Title(
                  itemParty: itemParty,
                ),
                Divider(
                  height: 0,
                  color: colorBlack.withOpacity(0.3),
                ),
                _Member(
                  itemParty: itemParty,
                  partyProvider: partyProvider,
                  index: index,
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

class _Member extends StatelessWidget {
  const _Member({
    Key? key,
    required this.itemParty,
    required this.partyProvider,
    required this.index,
  }) : super(key: key);

  final PartyModel itemParty;
  final PartyChangeNotifierProvider partyProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CountMember(
            itemParty: itemParty,
          ),
          SizedBox(
            height: 4,
          ),
          _ButtonMember(
            itemParty: itemParty,
            partyProvider: partyProvider,
            index: index,
          ),
        ],
      ),
    );
  }
}

class _ButtonMember extends StatelessWidget {
  const _ButtonMember({
    Key? key,
    required this.itemParty,
    required this.partyProvider,
    required this.index,
  }) : super(key: key);

  final PartyModel itemParty;
  final PartyChangeNotifierProvider partyProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (itemParty.host == FirebaseAuth.instance.currentUser!.uid)
          return _JoinButton(
            title: 'เจ้าของปาร์ตี้',
            color: colorRed,
          );
        else if (!itemParty.join!)
          return _JoinButton(
            title: 'เข้าร่วม',
            color: colorViolet,
            function: () async {
              partyProvider.addParty(index);
            },
          );
        else
          return _JoinButton(
            title: 'อยู่ในปาร์ตี้',
            color: colorGreyMedium,
          );
      },
    );
  }
}

class _CountMember extends StatelessWidget {
  const _CountMember({
    Key? key,
    required this.itemParty,
  }) : super(key: key);

  final PartyModel itemParty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
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
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.itemParty,
  }) : super(key: key);

  final PartyModel itemParty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${itemParty.title}',
            style: theme.bodyText1!.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    Key? key,
    required this.itemParty,
  }) : super(key: key);

  final PartyModel itemParty;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
    );
  }
}

class _JoinButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function? function;
  const _JoinButton(
      {Key? key, required this.title, required this.color, this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (function != null) function!();
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
