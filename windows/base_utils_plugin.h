#ifndef FLUTTER_PLUGIN_BASE_UTILS_PLUGIN_H_
#define FLUTTER_PLUGIN_BASE_UTILS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace base_utils {

class BaseUtilsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BaseUtilsPlugin();

  virtual ~BaseUtilsPlugin();

  // Disallow copy and assign.
  BaseUtilsPlugin(const BaseUtilsPlugin&) = delete;
  BaseUtilsPlugin& operator=(const BaseUtilsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace base_utils

#endif  // FLUTTER_PLUGIN_BASE_UTILS_PLUGIN_H_
