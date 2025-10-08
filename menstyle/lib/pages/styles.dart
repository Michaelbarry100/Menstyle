import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:styleapp/cubits/request/request_cubit.dart';
import 'package:styleapp/utils/utils.dart';
import 'package:styleapp/widgets/widgets.dart';

import '../data/models/models.dart';
import '../theme.dart';

class StylesPage extends StatefulWidget {
  final bool isPremium;
  final int? category;
  const StylesPage({super.key, this.isPremium = false, this.category});

  @override
  _StylesPageState createState() => _StylesPageState();
}

class _StylesPageState extends State<StylesPage> {
  late ScrollController _scrollController;
  bool isLoading = true;
  bool gainedReward = false;
  bool fetching = false;
  RewardedAd? _rewardedAd;
  int page = 1;
  Map response = {};
  List styles = [];
  int shuffled = 0;

  @override
  void initState() {
    super.initState();
    loadStyles();
    _scrollController = ScrollController();
    _scrollController
      .addListener(() {
        var triggerFetchMoreSize =
            0.9 * _scrollController.position.maxScrollExtent;
        if (_scrollController.position.pixels > triggerFetchMoreSize) {
          loadMoreStyles();
        }
      });
  }

  addToFavourite(Style style) {
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
        setState(() {
          gainedReward = true;
        });
        BlocProvider.of<RequestCubit>(context).addToFavourites(style);
      });
      setState(() {
        _rewardedAd = null;
      });
    }
  }

  loadStyles() {
    BlocProvider.of<RequestCubit>(context).getStyles(
      page: page,
      isPremium: widget.isPremium,
      categoryId: widget.category,
    );
  }

  loadMoreStyles() {
    if (response['next_page_url'] != null && !fetching) {
      setState(() {
        page = page++;
      });
      loadStyles();
    } else if (styles.isNotEmpty && response['next_page_url'] == null && !fetching) {
      setState(() => fetching = true);
      List newData = styles;
      newData.shuffle();
      setState(() {
        styles =  [ ...styles, ...newData ];
        fetching = false;
      });
      print("Refreshing styles");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is RequestLoading) {
          if (styles.isEmpty) {
            setState(() => isLoading = true);
          } else {
            setState(() => fetching = true);
          }
        } else if (state is RequestFailed) {
          setState(() {
            isLoading = false;
            fetching = false;
          });
        } else if (state is RequestApproved) {
          List newStyles = [...styles, ...state.data['data']];
          setState(() {
            isLoading = false;
            response = state.data;
            styles = newStyles;
            fetching = false;
          });
        } else if (state is SavedStyle) {
          toastMessage("Styles Saved");
        }
      },
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          return LayoutWidget(
            isLoading: isLoading,
            pageTitle: "${widget.isPremium ? 'Premium' : ''} Styles",
            hPadding: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const GoogleBannerAd(
                  height: 48,
                ),
                styles.isNotEmpty
                    ? Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          itemCount: styles.length,
                          padding: const EdgeInsets.only(top: 12, bottom: 24),
                          itemBuilder: (contex, index) {
                            var style = styles[index] as Style;
                            // return Container();
                            return StyleCard(
                              name: style.name,
                              style: styles[index] as Style,
                              onSave: () =>
                                  addToFavourite(styles[index] as Style),
                              image: style.images[0],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return (index + 4) % 3 == 0 &&
                                    index + 1 != styles.length
                                ? GoogleBannerAd(
                                    height: 80,
                                  )
                                : verticalSpacing(18);
                          },
                        ),
                      )
                    : const EmptyData(text: "Not Styles Yet"),
                fetching
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: SpinKitThreeBounce(
                            color: AppColors.primary,
                            size: 18.0,
                          ),
                        ),
                      ).animate().fade(duration: 400.ms)
                    : verticalSpacing(0),
              ],
            ),
          );
        },
      ),
    );
  }
}
