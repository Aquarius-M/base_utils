import 'dart:io';

import 'package:base_utils/log_utils/app_log_utils.dart';
import 'package:base_utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LogListPage extends StatefulWidget {
  const LogListPage({super.key});

  @override
  State<LogListPage> createState() => _LogListPageState();
}

class _LogListPageState extends State<LogListPage> {
  ScrollController scrollController = ScrollController();
  String logStr = '';
  @override
  void initState() {
    super.initState();
    _loadLog();
  }

  Future _loadLog() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String outPath = '${appDocDir.path}/log';
    File file = File(
      '$outPath/.${DateTime.now().toString().replaceAll(RegExp(r'(?<=\d\d-\d\d-\d\d)[\S|\s]+'), '')}.log',
    );
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    var content = file.readAsStringSync();
    setState(() {
      logStr = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '日志',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (scrollController.offset == scrollController.position.maxScrollExtent) {
                scrollController.jumpTo(0);
                setState(() {});
              } else {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
                setState(() {});
              }
            },
            icon: const Icon(Icons.unfold_more_rounded),
          ),
          IconButton(
            onPressed: () async {
              _loadLog().then((value) {
                ToastUtils.toast(msg: "加载完成");
              });
            },
            icon: const Icon(Icons.sync),
          ),
          IconButton(
            onPressed: () async {
              await AppLog.clean().then((value) {
                ToastUtils.toast(msg: "清理完成");
              });
              _loadLog();
            },
            icon: const Icon(Icons.cleaning_services_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Text(
          logStr,
          softWrap: true,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
