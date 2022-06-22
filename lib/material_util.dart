import 'dart:ui' as ui;

class MaterialUtils {
  static double screenWidth() {
    return ui.window.physicalSize.width / ui.window.devicePixelRatio;
  }

  static double screenHeight() {
    return ui.window.physicalSize.height / ui.window.devicePixelRatio;
  }
}