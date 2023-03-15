import 'dart:convert';
import 'dart:io';

import 'package:albiruni/albiruni.dart';
import 'package:albiruni_fetcher/kulliyyah.dart';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('session')
    ..addOption('sem');

  final args = parser.parse(arguments);

  late String session;
  late int semester;

  try {
    session = args['session'] as String;
    semester = int.parse(args['sem']);
  } catch (e) {
    print('Cannot parse arguments. Please see README');
    exit(1);
  }

  print("ℹ️ Getting data for $session and semester $semester");

  for (var kull in kulliyyahs) {
    print('\n');
    print("🏢 ${kull.name}");
    Albiruni albiruni =
        Albiruni(semester: semester, session: session.replaceAll('_', '/'));

    List<Subject> subjects = await retrieveSubjects(albiruni, kull);
    print(subjects);
    // delay a few seconds to avoid 'DDOS'

    print("📚 Fetched ${subjects.length} subjects");
    String jsonString = prettyJson(subjects);
    // print(jsonString);

    // Create a file and write JSON string to it
    var dbFile = await File('db/$session/$semester/${kull.code}.json')
        .create(recursive: true);
    dbFile.writeAsString(jsonString).then((file) {
      print('JSON file created successfully!');
    }).catchError((error) {
      print('Error while creating JSON file: $error');
    });
  }
}

Future<List<Subject>> retrieveSubjects(
    Albiruni albiruni, Kulliyyah kulliyyah) async {
  List<Subject> subjects = [];

  try {
    for (int i = 1;; i++) {
      var res = await albiruni.fetch(kulliyyah.code, page: i);
      subjects.addAll(res);
      Future.delayed(Duration(seconds: 1));
    }
  } catch (e) {
    // do nothing
  }

  return subjects;
}

String prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}
