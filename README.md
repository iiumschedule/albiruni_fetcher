![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

> [!WARNING]
> This project is :alembic: **EXPERIMENTAL** :alembic:

# Albiruni Fetcher

Fetches subject information from [IIUM'S Course Schedule](https://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php) and stores it in a local file.

## Getting Started

**Dart** is required to run this project. You can download it from [here](https://dart.dev/get-dart).

```powershell
dart bin\albiruni_fetcher.dart --session <session> --sem <semester>
```

Where `<session>` is the academic session (e.g., `2023/2024`) and `<semester>` is the semester number (e.g., `1`, `2`, or `3`).

The data will be saved to `db/{session}/{semester}.{kulliyyah}.json`.

## How to read the database

Below is the example of the 'database' data:

```json
[
  {
    "code": "AERO 1121",
    "sect": 1,
    "title": "INTRODUCTION TO AEROSPACE ENGINEERING",
    "chr": 1.0,
    "venue": "ENG LRM E0-3-20",
    "lect": ["DR. AMELDA DIANNE BINTI ANDAN"],
    "dayTime": [
      {
        "day": 2,
        "startTime": "08:30",
        "endTime": "09:30"
      }
    ]
  },
  // more subjects...
]
```

| Field     | Type   | Description                                                     |
| --------- | ------ | --------------------------------------------------------------- |
| code      | String | The course code                                                 |
| sect      | int    | The section number                                              |
| title     | String | The subject name                                                |
| chr       | double | The credit hour                                                 |
| venue     | String | The venue of the subject                                        |
| lect      | Array  | The list of lecturers for the subject                           |
| dayTime   | Array  | The list of days and times for the subject                      |
| day       | int    | The day of the week (0 = Sunday, 1 = Monday, ..., 6 = Saturday) |
| startTime | String | The start time of the subject (in 24-hour format)               |
| endTime   | String | The end time of the subject (in 24-hour format)                 |

## Related Projects

- [IIUM Schedule](https://github.com/iqfareez/iium_schedule) - An app to create your IIUM schedule
- [albiruni](https://github.com/iqfareez/albiruni) - Dart package to scrape IIUM's Course Schedule
- [albiruni-api](https://github.com/iqfareez/albiruni-api) - IIUM Subjects REST API that uses this fetched database **[:alembic: Experimental]**
