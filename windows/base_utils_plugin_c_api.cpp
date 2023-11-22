#include "include/base_utils/base_utils_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "base_utils_plugin.h"

void BaseUtilsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  base_utils::BaseUtilsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
