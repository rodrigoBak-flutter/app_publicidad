import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  static String? get interstitialAdUnitId {
    return 'ca-app-pub-3940256099942544/1033173712';
  }

  static String? get rewardedAdUnitId {
    return 'ca-app-pub-3940256099942544/5224354917';
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: ((ad) => debugPrint('Publicidad cargada')),
    onAdFailedToLoad: ((ad, error) {
      ad.dispose();
      debugPrint('Algo salio mal $error');
    }),
    onAdOpened: (ad) => debugPrint('Entrando en la publicidad'),
    onAdClosed: ((ad) => debugPrint('Saliendo de la publicidad')),
  );
}
