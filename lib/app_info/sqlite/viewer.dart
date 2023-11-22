import 'package:flutter/material.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';

class SqliteViewPage extends StatelessWidget {
  const SqliteViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const DatabaseList();
  }
}
