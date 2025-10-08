import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:styleapp/data/models/styles.dart';
import 'package:styleapp/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:styleapp/widgets/widgets.dart';

import '../cubits/request/request_cubit.dart';
import '../theme.dart';

class DesignPage extends StatefulWidget {
  final Style style;
  const DesignPage({super.key, required this.style});

  @override
  _DesignPageState createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  late final CarouselController _campaignController = CarouselController();
  int _campaignIndex = 0;
  String selectedImage = '';

  @override
  void initState() {
    super.initState();
    _loadAds();
  }

  RewardedAd? _rewardedAd;
  _loadAds() {
    createRewardedAd(
        onLoaded: (ad) => setState(() => _rewardedAd = ad),
        onFailed: (error) => setState(() {
              _rewardedAd = null;
            }));
  }

  addToFavourite() {
    if (_rewardedAd != null) {
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
        BlocProvider.of<RequestCubit>(context).addToFavourites(widget.style);
      });
      setState(() {
        _rewardedAd = null;
      });
    }
  }

  sharePhoto() async {
    await _screenshotController.capture().then((image) async {
      var imageFile = image as Uint8List;
      // saveImage(imageFile);
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File(
          '${appStorage.path}/${widget.style.name.toLowerCase()}_$_campaignIndex.png');
      file.writeAsBytes(imageFile);
      Share.shareFiles([file.path], text: '${widget.style.name}-Design')
          .then((_) {});
    });
  }

  openModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: AppColors.accent,
          elevation: 0,
          alignment: Alignment.center,
          backgroundColor: AppColors.white,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.58,
                child: Column(
                  children: [
                    Screenshot(
                      controller: _screenshotController,
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              imageUrl: selectedImage,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: sharePhoto,
                      child: Container(
                        height: 44,
                        color: AppColors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.share,
                              size: 18,
                              color: AppColors.accent,
                            ),
                            horizontalSpacing(12),
                            Text(
                              "Share",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is SavedStyle) {
          toastMessage("Styles Saved");
        }
      },
      child: LayoutWidget(
          isLoading: false,
          pageTitle: "Design",
          hPadding: 16,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GoogleBannerAd(),
                verticalSpacing(4),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: CarouselSlider.builder(
                    itemCount: widget.style.images.length,
                    options: CarouselOptions(
                        enlargeCenterPage: false,
                        height: MediaQuery.of(context).size.height * 0.56,
                        autoPlay: false,
                        viewportFraction: 1.0,
                        autoPlayInterval: const Duration(seconds: 3),
                        reverse: false,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        aspectRatio: 5.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _campaignIndex = index;
                          });
                        }),
                    itemBuilder: (context, i, id) {
                      //for onTap to redirect to another screen
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          //ClipRRect for image border radius
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                                imageUrl: widget.style.images[i],
                                width: double.infinity,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedImage = widget.style.images[i];
                          });
                          openModal();
                          // print(url.toString());
                        },
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.style.images.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () =>
                            _campaignController.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accent.withOpacity(
                                  _campaignIndex == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    },
                  ).toList(),
                ),
                verticalSpacing(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.style.name,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accent),
                            ),
                            Text(
                              "${widget.style.category}",
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      horizontalSpacing(12),
                      InkWell(
                        onTap: () {
                          addToFavourite();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 16,
                              ),
                              horizontalSpacing(4),
                              Text(
                                "Add to Favorite",
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
                    ],
                  ),
                ),
                verticalSpacing(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "${widget.style.description}",
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
