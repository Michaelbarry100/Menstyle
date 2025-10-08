import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:styleapp/cubits/request/request_cubit.dart';
import 'package:styleapp/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  InterstitialAd? _interstitialAd;
  bool isLoading = true;
  bool shownAd = false;
  bool isRewarded = false;
  final CountdownTimer _countdownTimer = CountdownTimer();
  var _coins = 0;
  final Uri _developerPageUrl = Uri.parse('https://play.google.com/store/apps/dev?id=6152631053281890644');

  // var _showWatchVideoButton = false;

  Map response = {'designs': [], 'collections': []};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RequestCubit>(context).loadHomeData();
    // _countdownTimer.addListener(() => setState(() {
    //       if (_countdownTimer.isComplete) {
    //         _showWatchVideoButton = true;
    //         _coins += 1;
    //       } else {
    //         _showWatchVideoButton = false;
    //       }
    //     }));
    _loadAds();
  }

  _loadAds() {
    loadInterstitialAd(onFailed: () {
      setState(() => _interstitialAd = null);
    }, onLoaded: (ad) {
      setState(() => _interstitialAd = ad);
    });

    createRewardedAd(
        onLoaded: (ad) => setState(() => _rewardedAd = ad),
        onFailed: (error) => setState(() {
              _rewardedAd = null;
            }));
    _countdownTimer.start();
  }

  RewardedAd? _rewardedAd;

  showRewardedAd() {
    if (_rewardedAd != null || _coins < 5) {
      _rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createRewardedAd(
            onLoaded: (ad) => setState(() => _rewardedAd = ad),
            onFailed: (error) => setState(() {
                  _rewardedAd = null;
                }));
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
      });
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        setState(() {
          _coins += 5;
        });
      });
      setState(() {
        _rewardedAd = null;
      });
    } else {
      setState(() {
        _coins = _coins - 5;
      });
      context.pushNamed('designs', extra: {"premium": true});
    }
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitialAd(onFailed: () {
          setState(() => _interstitialAd = null);
        }, onLoaded: (ad) {
          setState(() => _interstitialAd = ad);
        });
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        loadInterstitialAd(onFailed: () {
          setState(() => _interstitialAd = null);
        }, onLoaded: (ad) {
          setState(() => _interstitialAd = ad);
        });
      }));
      _interstitialAd!.show();
      setState(() {
        _interstitialAd = null;
        shownAd = true;
      });
    }
  }

  locatePage(path) {
    showInterstitialAd();
    setState(() => shownAd = true);
    context.push(path);
  }

  _showPremiumDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: AppColors.accent.withOpacity(1),
          elevation: 0,
          alignment: Alignment.center,
          backgroundColor: AppColors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.maxFinite,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 28,
                        color: AppColors.accent,
                      ),
                    )
                  ],
                ),
                verticalSpacing(30),
                Text(
                  "Premium Designs",
                  style: GoogleFonts.montserrat(
                      color: AppColors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                verticalSpacing(8),
                Text(
                  "Watch video to gain 10coins for viewing premium designs",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                verticalSpacing(38),
                SizedBox(
                    width: 106,
                    child: Button(
                        label: "Watch Video", action: () => showRewardedAd()))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is RequestLoading) {
          setState(() => isLoading = true);
        } else if (state is RequestFailed) {
          setState(() => isLoading = false);
        } else if (state is RequestApproved) {
          setState(() {
            isLoading = false;
            response = state.data;
          });
        }
      },
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          return Scaffold(
            key: _key,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.8),
                child: Container(
                  color: AppColors.primary,
                  height: 0.8,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  // showInterstitialAd();
                  context.pushNamed('favorites');
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 22,
                        color: AppColors.primary,
                      ),
                      horizontalSpacing(4),
                      Text(
                        "Favorites",
                        style: GoogleFonts.plusJakartaSans(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () => _key.currentState!.openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.menu,
                      size: 22,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
              leadingWidth: 140,
              title: SizedBox(
                child: Image.asset(
                  "assets/icon.png",
                  semanticLabel: 'AfriStyle Logo',
                  width: 40,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            drawer: Drawer(
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      height: 102,
                      decoration: const BoxDecoration(color: AppColors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/icon.png'),
                            semanticLabel: 'AfriStyle Logo',
                            height: 80,
                          ),
                          horizontalSpacing(12),
                          Text(
                            "Men Fashion Styles",
                            style: GoogleFonts.plusJakartaSans(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                    DrawerItem(
                        title: "Collections",
                        action: () => locatePage('/collections')),
                    DrawerItem(
                        title: "Style Categories",
                        action: () => locatePage('/categories')),
                    DrawerItem(
                        title: "Designs", action: () => locatePage('/designs')),
                    InkWell(
                      onTap: () async {
                        if (!await launchUrl(_developerPageUrl)) {
                          throw Exception('Could not launch $_developerPageUrl');
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See Other Apps",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    // DrawerItem(
                    //     title: "Premium Designs",
                    //     action: () {
                    //       if(_showWatchVideoButton && _coins < 5){
                    //         setState(() {
                    //           _showWatchVideoButton = false;
                    //         });
                    //         _showPremiumDialog();
                    //       }else {
                    //         setState(() {
                    //           _coins = _coins-5;
                    //         });
                    //         context.pushNamed('designs', extra: {"premium": true});
                    //       }
                    //     }),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: !isLoading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "New Designs",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                ShowAllBtn(
                                    label: "See All",
                                    onTap: () {
                                      shownAd
                                          ? locatePage('/categories')
                                          : showInterstitialAd();
                                    })
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: SizedBox(
                              height: 142,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: response['designs'].length,
                                  itemBuilder: (context, index) {
                                    var design = response['designs'][index];
                                    return GestureDetector(
                                      onTap: () {
                                        context.pushNamed("designs",
                                            extra: {"category": design['id']});
                                      },
                                      child: NewStyleCard(
                                        name: design['name'],
                                        image: design['featured_image'],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          verticalSpacing(22),
                          const GoogleBannerAd(),
                          verticalSpacing(4),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Collections",
                                  style: GoogleFonts.plusJakartaSans(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                ShowAllBtn(
                                    label: "See All",
                                    onTap: () {
                                      context.push('/collections');
                                      showInterstitialAd();
                                    })
                              ],
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                            itemCount: response['collections'].length,
                            itemBuilder: (context, index) {
                              var collection = response['collections'][index];
                              return CollectionCard(
                                name: collection['name'],
                                imageUrl: collection['featured_image'],
                                id: collection['id'],
                              );
                            },
                          )),
                        ],
                      )
                    : const LaodingWidget(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _rewardedAd?.dispose();
    _countdownTimer.dispose();
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final Function action;
  const DrawerItem({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 0.6,
            color: AppColors.primary,
          ),
        )),
        child: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
              color: AppColors.accent,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class NewStyleCard extends StatelessWidget {
  final String name;
  final String image;

  const NewStyleCard({
    required this.name,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142,
      width: 136,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
            image: CachedNetworkImageProvider(image),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter),
      ),
      child: Stack(
        children: [
          Positioned(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            width: double.maxFinite,
            // height: double.,
            decoration: BoxDecoration(
                color: AppColors.black.withOpacity(.4),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                name,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white70),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class ShowAllBtn extends StatelessWidget {
  final String label;
  final Function onTap;

  const ShowAllBtn({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String label;
  final bool primary;

  final Function action;
  const Button(
      {super.key,
      required this.label,
      this.primary = true,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
