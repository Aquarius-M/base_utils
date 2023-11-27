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
  String? buildSignature = "";
  String? getCachePath = "";
  String? getPhoneLocalPath = "";
  String? installerStore = "";
  String? appName = "";

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
    appName = await DeviceUtils.appName();
    packageName = await DeviceUtils.packageName();
    packageVersion = await DeviceUtils.version();
    buildNumber = await DeviceUtils.buildNumber();
    buildSignature = await DeviceUtils.buildSignature();
    getCachePath = await DeviceUtils.getCachePath();
    getPhoneLocalPath = await DeviceUtils.getPhoneLocalPath();
    installerStore = await DeviceUtils.installerStore();
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
            _buildPanel('appName', text: '$appName', onTap: () {
              StringUtils.copy(appName);
            }),
            _buildPanel('packageName', text: '$packageName', onTap: () {
              StringUtils.copy(packageName);
            }),
            _buildPanel('packageVersion', text: '$packageVersion', onTap: () {
              StringUtils.copy(packageVersion);
            }),
            _buildPanel('buildNumber', text: '$buildNumber', onTap: () {
              StringUtils.copy(buildNumber);
            }),
            _buildPanel('Signature', text: '$buildSignature', onTap: () {
              StringUtils.copy(buildSignature);
            }),
            _buildPanel('CachePath', text: '$getCachePath', onTap: () {
              StringUtils.copy(getCachePath);
            }),
            _buildPanel('LocalPath', text: '$getPhoneLocalPath', onTap: () {
              StringUtils.copy(getPhoneLocalPath);
            }),
            _buildPanel('installerStore', text: '$installerStore', onTap: () {
              StringUtils.copy(installerStore);
            }),
            _buildPanel('IP', text: wifiIP, onTap: () {
              StringUtils.copy(wifiIP);
            }),
            _buildPanel('LogPath', text: logUrl, onTap: () {
              StringUtils.copy(logUrl);
            }),
            _buildPanel('Delete Database', onTap: () {
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
    return InkWell(
      onTap: onTap ??
          () {
            StringUtils.copy(title);
          },
      onLongPress: onLongTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                '$title${text != null ? ':' : ''}',
                strutStyle: const StrutStyle(
                  forceStrutHeight: true,
                  height: 1.5,
                ),
              ),
            ),
            Expanded(
              child: child ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: text != null
                            ? RichText(
                                // strutStyle: const StrutStyle(
                                //   forceStrutHeight: true,
                                //   height: 1,
                                // ),
                                text: TextSpan(
                                    text: text,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: const [
                                      // WidgetSpan(
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(left: 4),
                                      //     child: GestureDetector(
                                      //       onTap: onTap,
                                      //       child: const Icon(
                                      //         Icons.copy,
                                      //         size: 16,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ]),
                              )
                            : const SizedBox(),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
