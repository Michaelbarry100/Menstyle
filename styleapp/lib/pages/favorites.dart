import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:styleapp/cubits/request/request_cubit.dart';
import 'package:styleapp/utils/utils.dart';
import 'package:styleapp/widgets/widgets.dart';

import '../data/models/models.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key})
      : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isLoading = true;
  bool gainedReward = false;
  RewardedAd? _rewardedAd;
  int page = 1;
  List styles = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RequestCubit>(context).getFavouriteStyles();
  }

  showRewardedAd() {
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
      });
      setState(() {
        _rewardedAd = null;
      });
    }
  }

  addToFavourite(Style style) {
    // BlocProvider.of<RequestCubit>(context).addToFavourites(style);
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
            styles = state.data;
          });
        }
      },
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          return LayoutWidget(
            isLoading: isLoading,
            pageTitle: "Favorite Styles",
            hPadding: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const GoogleBannerAd(
                  height: 48,
                ),
                styles.isNotEmpty ? Expanded(
                  child: GridView.builder(
                    itemCount: styles.length,
                    padding: const EdgeInsets.only(bottom: 26),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      // maxCrossAxisExtent: 200,
                      childAspectRatio: 0.86,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (contex, index) {
                      var style = styles[index] as Style;
                      return StyleCard(
                        name: style.name,
                        isSaved: true,
                        style: style,
                        onSave: () {},
                        image: style.images[0],
                      );
                    },
                  ),
                ) : const EmptyData(text: "No Styles yet"),
              ],
            ),
          );
        },
      ),
    );
  }
}
