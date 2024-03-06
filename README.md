![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

> [!WARNING]
> This project is :alembic: **EXPERIMENTAL** :alembic:

# albiruni fetcher

Fetches subject information from [IIUM'S Course Schedule](https://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php) and store in DB.

## Getting Started

**Dart** is required to run this project. You can download it from [here](https://dart.dev/get-dart).

```powershell
dart bin\albiruni_fetcher.dart --session <session> --sem <semester>
```

Where `<session>` is the academic session (eg: `2023/2024`) and `<semester>` is the semester number (eg: `1` or `2` or `3`).

The data is then saved to `db/{session}/{semester}.{kulliyyah}json`.

## Related projects

- [IIUM Schedule](https://github.com/iqfareez/iium_schedule) - Make IIUM schedule using this app
- [albiruni](https://github.com/iqfareez/albiruni) - Dart package to scrape IIUM's Course Schedule
- [albiruni-api](https://github.com/iqfareez/albiruni-api) - IIUM Subjects REST API that uses this fetched database **[:alembic: Experimental]**
