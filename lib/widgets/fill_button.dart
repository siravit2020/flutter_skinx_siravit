import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function function;

  const FillButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          function();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 12,
          ),
          primary: color,
          shape: StadiumBorder(),
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
