import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:app_publicidad/src/service/adMob_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? _banner;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  int _rewardedScore = 0;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
    _createIntersterialAd();
    _createrewardedAd();
  }

  void _createBannerAd() {
    _banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: AdRequest())
      ..load();
  }

  void _createIntersterialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId!,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => _interstitialAd = ad,
          onAdFailedToLoad: (LoadAdError) => _interstitialAd = null),
    );
  }

  void _createrewardedAd() {
    RewardedAd.load(
      adUnitId: AdMobService.rewardedAdUnitId!,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: ((ad) => setState(() => _rewardedAd = ad)),
        onAdFailedToLoad: ((error) => setState(() => _rewardedAd = null)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showInterstetialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createIntersterialAd();
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        ad.dispose();
        _createIntersterialAd();
      }));
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void _showrewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _createrewardedAd();
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        ad.dispose();
        _createrewardedAd();
      }));
      _rewardedAd!.show(
          onUserEarnedReward: (ad, reward) => setState(() => _rewardedScore++));
      _rewardedAd = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            width: double.infinity,
            height: size.width * 0.3,
            child: AdWidget(
              ad: _banner!,
            ),
          ),
          ElevatedButton(
              onPressed: _showInterstetialAd,
              child: Text('Publiciadad Imagen grande')),
          Text('Video reproducidos: $_rewardedScore'),
          ElevatedButton(
              onPressed: _showrewardedAd, child: Text('Publiciadad Video')),
        ],
      ),
    );
  }
}
