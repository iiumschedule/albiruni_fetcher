import 'dart:convert';
import 'dart:io';

import 'package:albiruni/albiruni.dart';
import 'package:albiruni_fetcher/kulliyyah.dart';
import 'package:albiruni_fetcher/subject_chart_stats.dart';
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

  // entries = subject and sections for each kulliyyah
  List<int> numberOfEntriesFetched = [];

  for (var kull in kulliyyahs) {
    print('');
    print("🏢 Getting ${kull.name}");
    Albiruni albiruni = Albiruni(semester: semester, session: session);

    List<Subject> subjects = await retrieveSubjects(albiruni, kull);

    print("📚 Fetched ${subjects.length} subjects");
    numberOfEntriesFetched.add(subjects.length);
    String jsonString = prettyJson(subjects);

    // sanitize sesssion before creating directory
    var sessionDir = session.replaceAll('/', '_');

    // Create a file and write JSON string to it
    var dbFile = await File('db/$sessionDir/$semester/${kull.code}.json')
        .create(recursive: true);

    try {
      var res = await dbFile.writeAsString(jsonString);
      print('JSON dumped successfully!: $res');
    } catch (e) {
      print('Error while creating JSON file: $e');
    }
  }

  // display link to chart summary
  var chartLink = buildChartLink(
      kulliyyahs.map((e) => e.code).toList(), numberOfEntriesFetched);

  print('\n');
  print('📊 Subject statisticsL');
  print(chartLink);
}

Future<List<Subject>> retrieveSubjects(
    Albiruni albiruni, Kulliyyah kulliyyah) async {
  List<Subject> subjects = [];

  // use [useProxy] to allow the data fetching on GitHub runners
  bool useProxy = Platform.environment['GITHUB_ACTION'] != null;

  try {
    for (int i = 1;; i++) {
      var res =
          await albiruni.fetch(kulliyyah.code, page: i, useProxy: useProxy);
      subjects.addAll(res);

      // delay a few seconds to avoid 'DDOS'
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
