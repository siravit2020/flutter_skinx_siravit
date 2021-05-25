import 'package:mongo_dart/mongo_dart.dart';

void start() async {
  var db = await Db.create(
      "mongodb+srv://dbUser:0851325654@cluster0.injmz.mongodb.net/test?retryWrites=true&w=majority");
  await db.open();

  final coll = db.collection('contacts');
  
  print(await coll.find().toList());
}
