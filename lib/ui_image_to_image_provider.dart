import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 实际使用
/// 
/// LoadImage loadImage = LoadImage(image);
class LoadImage extends ImageProvider<LoadImage> {
  const LoadImage(this.image, {this.scale = 1.0});

  final ui.Image image;
  final double scale;

  ImageStreamCompleter load(LoadImage key, decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key),
      scale: key.scale,
    );
  }

  Future<ui.Codec> _loadAsync(LoadImage key) async {
    assert(key == this);
    //image转ByteData
    final a = await image.toByteData(format: ui.ImageByteFormat.png);
    var codec = await PaintingBinding.instance
        .instantiateImageCodecWithSize(a!.buffer as ui.ImmutableBuffer);
    return codec;
  }

  @override
  Future<LoadImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<LoadImage>(this);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final LoadImage typedOther = other;
    return image == typedOther.image && scale == typedOther.scale;
  }

  @override
  int get hashCode => Object.hash(image.hashCode, scale);

  @override
  String toString() =>
      '$runtimeType(${describeIdentity(image)}, scale: $scale)';
}
