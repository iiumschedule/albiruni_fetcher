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
  bool isRunOnGithubAction = Platform.environment['GITHUB_ACTION'] != null;

  print("ℹ️ Getting data for $session and semester $semester");

  // entries = subject and sections for each kulliyyah
  List<int> numberOfEntriesFetched = [];

  for (var kull in kulliyyahs) {
    print('');
    print("🏢 Getting ${kull.name}");
    Albiruni albiruni = Albiruni(semester: semester, session: session);

    List<Subject> subjects = await _retrieveSubjects(albiruni, kull);

    print("📚 Fetched ${subjects.length} subjects");
    numberOfEntriesFetched.add(subjects.length);
    String jsonString = _prettyJson(subjects);

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
  print('📊 Set statistics');
  if (isRunOnGithubAction) {
    _setToGithubOutput('chart_link', chartLink);
  } else {
    print(chartLink);
  }
  // the key will be use in the workflow yml file
}

Future<List<Subject>> _retrieveSubjects(
    Albiruni albiruni, Kulliyyah kulliyyah) async {
  List<Subject> subjects = [];

  try {
    for (int i = 1;; i++) {
      var res = await albiruni.fetch(kulliyyah.code, page: i);
      subjects.addAll(res.$1);

      // delay a few seconds to avoid 'DDOS'
      Future.delayed(Duration(seconds: 1));
    }
  } catch (e) {
    // tell me if unexpected error occurs
    if (!(e is NoSubjectsException || e is EmptyBodyException)) {
      print('Error: $e');
    }
  }

  return subjects;
}

String _prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

/// Ref: https://github.com/orgs/community/discussions/28146#discussioncomment-4110404
/// https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/
void _setToGithubOutput(String key, String value) {
  final outputFile = Platform.environment['GITHUB_OUTPUT'];

  final file = File(outputFile!);
  file.writeAsStringSync('$key=$value', mode: FileMode.append);
}
