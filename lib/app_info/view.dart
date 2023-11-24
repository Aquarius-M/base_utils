import 'package:base_utils/device_utils.dart';
import 'package:base_utils/loading_utils.dart';
import 'package:base_utils/log_utils/app_log_utils.dart';
import 'package:base_utils/string_utils.dart';
import 'package:base_utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '../db/manager.dart';

/// 应用信息页面
class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});

  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  String logUrl = '';
  String? wifiIP = '';
  String? proxyIp = '';
  String? packageName = '';
  String? packageVersion = "";
  String? buildNumber = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final info = NetworkInfo();

    wifiIP = await info.getWifiIP();
    if (wifiIP != null) {
      setState(() {
        logUrl = "${wifiIP!}:8002/${AppLog.fileName}";
      });
    } else {
      ToastUtils.toast(msg: "未找到ip");
    }
    packageName = await DeviceUtils.packageName();
    packageVersion = await DeviceUtils.version();
    buildNumber = await DeviceUtils.buildNumber();
    setState(() {});
  }

  /// 清理日志
  Future<void> cleanLog() async {
    LoadingUtils.loading();
    await AppLog.clean();
    LoadingUtils.dismiss();
    ToastUtils.toast(msg: "清理完成");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '应用信息',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPanel(
              '包版本',
              text: '$packageName ${packageVersion}_$buildNumber',
            ),
            _buildPanel('设备IP', text: wifiIP, onTap: () {
              StringUtils.copy(wifiIP);
            }),
            _buildPanel('日志', text: logUrl, onTap: () {
              StringUtils.copy(logUrl);
            }),
            _buildPanel('删除数据库表', onTap: () {
              SqlManager.deleteSql(name: ["soul.db"]);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel(
    String title, {
    String? text,
    Widget? child,
    VoidCallback? onTap,
    VoidCallback? onLongTap,
  }) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black26),
      ),
      child: InkWell(
        onTap: onTap ??
            () {
              StringUtils.copy(title);
            },
        onLongPress: onLongTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text('$title${text != null ? ':' : ''}'),
              ),
              Expanded(
                child: child ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: text != null ? Text(text) : const SizedBox(),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff333333),
                          size: 14,
                        ),
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
