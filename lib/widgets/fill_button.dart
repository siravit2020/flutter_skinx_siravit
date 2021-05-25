import 'package:flutter/material.dart';


class FillButton extends StatelessWidget {
  final BuildContext context;
  final String title;
  final Color color;
  final Function function;

  const FillButton(
      {Key? key,
      required this.context,
      required this.title,
      required this.color,
      required this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: Size(double.infinity, 44),
        shape: StadiumBorder(),
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
