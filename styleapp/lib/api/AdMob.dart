import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobAPI {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5333424817197074/1379398109';
    }
    // else if(Platform.isIOS) {
    //   return 'ca-app-pub-5333424817197074/1379398109';
    // }
    return null;
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5333424817197074/3201963270';
    }
    // else if(Platform.isIOS) {
    //   return 'ca-app-pub-5333424817197074/1379398109';
    // }
    return null;
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5333424817197074/1888881607';
    }
    // else if(Platform.isIOS) {
    //   return 'ca-app-pub-5333424817197074/1379398109';
    // }
    return null;
  }

  static final BannerAdListener bannerAdListenner = BannerAdListener(
    onAdLoaded: (ad) => debugPrint("Ad Loaded"),
    onAdFailedToLoad: (ad, err) {
      ad.dispose();
      debugPrint("Ad Failed to load");
    },
    onAdOpened: (ad) => debugPrint("Ad Opened"),
    onAdClosed: (ad) => debugPrint("Ad Closed"),
  );

}

class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    print('New AppState state: $appState');
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}

/// Utility class that manages loading and showing app open ads.
class AppOpenAdManager {
  final Duration maxCacheDuration = Duration(hours: 4);

  DateTime? _appOpenLoadTime;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  // String adUnitId = Platform.isAndroid
  //     ? 'ca-app-pub-5333424817197074/6949636592'
  //     : 'ca-app-pub-5333424817197074/6949636592';

    String adUnitId = 'ca-app-pub-5333424817197074/6949636592';

  /// Load an [AppOpenAd].
  void loadAd() {
    AppOpenAd.load(
      adUnitId: adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print('$ad loaded');
          _appOpenLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (!isAdAvailable) {
      loadAd();
      return;
    }
    if (_isShowingAd) {
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}