/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/April.png
  AssetGenImage get april => const AssetGenImage('assets/images/April.png');

  /// File path: assets/images/August.png
  AssetGenImage get august => const AssetGenImage('assets/images/August.png');

  /// File path: assets/images/December.png
  AssetGenImage get december =>
      const AssetGenImage('assets/images/December.png');

  /// File path: assets/images/February.png
  AssetGenImage get february =>
      const AssetGenImage('assets/images/February.png');

  /// File path: assets/images/January.png
  AssetGenImage get january => const AssetGenImage('assets/images/January.png');

  /// File path: assets/images/July.png
  AssetGenImage get july => const AssetGenImage('assets/images/July.png');

  /// File path: assets/images/June.png
  AssetGenImage get june => const AssetGenImage('assets/images/June.png');

  /// File path: assets/images/March.png
  AssetGenImage get march => const AssetGenImage('assets/images/March.png');

  /// File path: assets/images/May.png
  AssetGenImage get may => const AssetGenImage('assets/images/May.png');

  /// File path: assets/images/November.png
  AssetGenImage get november =>
      const AssetGenImage('assets/images/November.png');

  /// File path: assets/images/October.png
  AssetGenImage get october => const AssetGenImage('assets/images/October.png');

  /// File path: assets/images/September.png
  AssetGenImage get september =>
      const AssetGenImage('assets/images/September.png');

  /// File path: assets/images/checklist.png
  AssetGenImage get checklist =>
      const AssetGenImage('assets/images/checklist.png');

  /// File path: assets/images/messy-opendoodle.png
  AssetGenImage get messyOpendoodle =>
      const AssetGenImage('assets/images/messy-opendoodle.png');

  /// File path: assets/images/reading-opendoodle.png
  AssetGenImage get readingOpendoodle =>
      const AssetGenImage('assets/images/reading-opendoodle.png');

  /// File path: assets/images/selfie-opendoodle.png
  AssetGenImage get selfieOpendoodle =>
      const AssetGenImage('assets/images/selfie-opendoodle.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        april,
        august,
        december,
        february,
        january,
        july,
        june,
        march,
        may,
        november,
        october,
        september,
        checklist,
        messyOpendoodle,
        readingOpendoodle,
        selfieOpendoodle
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
