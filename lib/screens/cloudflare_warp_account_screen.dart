// ignore_for_file: empty_catches, unused_catch_stack

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karing/app/modules/setting_manager.dart';
import 'package:karing/app/runtime/return_result.dart';
import 'package:karing/app/utils/cloudflare_warp_utils.dart';
import 'package:karing/app/utils/cloudflare_warp_api.dart';
import 'package:karing/app/utils/proxy_conf_utils.dart';

import 'package:karing/screens/dialog_utils.dart';
import 'package:karing/screens/group_item_creator.dart';
import 'package:karing/screens/group_item_options.dart';
import 'package:karing/screens/theme_config.dart';
import 'package:karing/screens/widgets/framework.dart';
import 'package:karing/screens/theme_define.dart';

class CloudflareWarpAccountScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routSettings() {
    return const RouteSettings(name: "CloudflareWarpAccountScreen");
  }

  const CloudflareWarpAccountScreen({super.key});

  @override
  State<CloudflareWarpAccountScreen> createState() =>
      _CloudflareWarpAccountScreenState();
}

class _CloudflareWarpAccountScreenState
    extends LasyRenderingState<CloudflareWarpAccountScreen>
    with AfterLayoutMixin {
  static bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    var settingConfig = SettingManager.getConfig();
    if (settingConfig.warp.account.license.isNotEmpty) {
      await CloudflareWarpApi.getDevice(
        settingConfig.warp.account.deviceId,
        settingConfig.warp.account.token,
      );
      //await CloudflareWarpApi.getDevices(
      //    warpConfig.warpAccount.deviceId, warpConfig.warpAccount.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final tcontext = Translations.of(context);
    Size windowSize = MediaQuery.of(context).size;
    var settingConfig = SettingManager.getConfig();

    return Scaffold(
      backgroundColor: ThemeDefine.kColorBgPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_outlined, size: 24),
          ),
          title: const Text(
            "Account",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: ThemeConfig.kFontWeightTitle,
              fontSize: ThemeConfig.kFontSizeTitle,
              color: ThemeDefine.kColorOnSurface,
            ),
          ),
          centerTitle: true,
          actions: [
            _loading
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: 26,
                      height: 26,
                      child: RepaintBoundary(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ThemeDefine.kColorPrimary,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      if (settingConfig.warp.account.license.isNotEmpty) {
                        settingConfig.warp.account = WarpAccount();
                        SettingManager.save();
                        if (!mounted) return;
                        setState(() {});
                        return;
                      }
                      if (_loading) return;
                      _loading = true;
                      setState(() {});

                      ReturnResult<WarpAccount> account =
                          await CloudflareWarpUtils.gen25PBWarpAccount();

                      if (account.error != null) {
                        if (!context.mounted) return;
                        DialogUtils.showAlertDialog(
                          context,
                          account.error!.message,
                          showCopy: true,
                          showFAQ: true,
                          withVersion: true,
                        );
                      } else {
                        settingConfig.warp.account = account.data!;
                        SettingManager.save();
                      }
                      _loading = false;
                      if (!mounted) return;
                      setState(() {});
                    },
                    icon: settingConfig.warp.account.license.isNotEmpty
                        ? const Icon(Icons.clear_outlined,
                            size: 24, color: Colors.red)
                        : const Icon(Icons.cloud_download_outlined, size: 24),
                    color: ThemeDefine.kColorOnSurface,
                  ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ThemeDefine.kColorBgPrimary,
              ThemeDefine.kColorBgSecondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Column(
              children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: getGroupOptions(),
                        builder:
                            (
                              BuildContext context,
                              AsyncSnapshot<List<GroupItem>> snapshot,
                            ) {
                              List<GroupItem> data = snapshot.hasData
                                  ? snapshot.data!
                                  : [];
                              return Column(
                                children: GroupItemCreator.createGroups(
                                  context,
                                  data,
                                ),
                              );
                            },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<GroupItem>> getGroupOptions() async {
    //final tcontext = Translations.of(context);
    var settingConfig = SettingManager.getConfig();

    List<GroupItem> groupOptions = [];
    List<GroupItemOptions> options = [
      GroupItemOptions(
        textOptions: GroupItemTextOptions(
          name: "Account Type",
          text: settingConfig.warp.account.accountType,
        ),
      ),
      GroupItemOptions(
        textOptions: GroupItemTextOptions(
          name: "Account Id",
          text: settingConfig.warp.account.id,
          onPush: () async {
            try {
              await Clipboard.setData(
                ClipboardData(text: settingConfig.warp.account.id),
              );
            } catch (e) {}
          },
        ),
      ),
      GroupItemOptions(
        textOptions: GroupItemTextOptions(
          name: "Warp+",
          text: settingConfig.warp.account.warpPlus ? "YES" : "NO",
        ),
      ),
      GroupItemOptions(
        textOptions: GroupItemTextOptions(
          name: "License",
          text: settingConfig.warp.account.license,
          onPush: () async {
            try {
              await Clipboard.setData(
                ClipboardData(text: settingConfig.warp.account.license),
              );
            } catch (e) {}
          },
        ),
      ),
      GroupItemOptions(
        textOptions: GroupItemTextOptions(
          name: "Premium Data",
          text: ProxyConfUtils.convertTrafficToStringDouble(
            settingConfig.warp.account.premiumData,
          ),
        ),
      ),
      /* GroupItemOptions(
          textOptions: GroupItemTextOptions(
        name: "Usage",
        text: ProxyConfUtils.convertTrafficToStringDouble(
            warpConfig.warpAccount.usage),
      )),*/
    ];
    groupOptions.add(GroupItem(options: options));
    return groupOptions;
  }
}
