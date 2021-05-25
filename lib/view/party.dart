import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PartyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //     new StaggeredGridView.countBuilder(
          //   crossAxisCount: 2,
          //   itemCount: 50,
          //   itemBuilder: (BuildContext context, int index) => new Container(
          //       color: Colors.green,
          //       height: index * 5,
          //       child: new Center(
          //         child: new CircleAvatar(
          //           backgroundColor: Colors.white,
          //           child: new Text('$index'),
          //         ),
          //       ),),
          //   staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          //   mainAxisSpacing: 4.0,
          //   crossAxisSpacing: 4.0,
          // )

          Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // DateTime? date = await showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime.now(),
              //   lastDate: DateTime(
              //     DateTime.now().year,
              //     DateTime.now().month + 6,
              //   ),
              // );
            },
            child: Text('Singout'),
          ),
        ),
      ),
    );
  }
}
