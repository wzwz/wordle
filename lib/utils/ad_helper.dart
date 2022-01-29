import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-0972625975358020/4027522140';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-0972625975358020/2681160194';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-0972625975358020/2535311222";
    } else if (Platform.isIOS) {
      return "ca-app-pub-0972625975358020/5115751843";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-0972625975358020/1403737544";
    } else if (Platform.isIOS) {
      return "ca-app-pub-0972625975358020/2298016815";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}