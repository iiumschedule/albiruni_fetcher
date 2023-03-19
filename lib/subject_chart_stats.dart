import 'dart:convert';

/// https://quickchart.io/documentation/
String buildChartLink(List<String> kulliyyahCodes, List<int> numberOfEntries) {
  var params = {
    "type": 'bar',
    "data": {
      "labels": kulliyyahCodes,
      "datasets": [
        {
          "label": 'Number of entries',
          "data": numberOfEntries,
          "backgroundColor": 'rgba(54, 162, 235, 0.5)',
          "borderColor": 'rgb(54, 162, 235)',
          "borderWidth": 1,
        },
      ],
    },
    "options": {
      "plugins": {
        "datalabels": {
          "anchor": 'center',
          "align": 'center',
          "color": '#fff',
          "font": {
            "weight": 'bold',
          },
        },
      },
    },
  };

  return Uri.https(
      'quickchart.io', 'chart', {'v': '3', 'c': jsonEncode(params)}).toString();
}
