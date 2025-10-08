import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:styleapp/data/models/collection.dart';
import 'package:styleapp/utils/utils.dart';
import 'package:styleapp/widgets/widgets.dart';
import '../cubits/request/request_cubit.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  bool isLoading = true;
  List collections = [];
  int page = 1;

  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RequestCubit>(context).getCollections();
    loadInterstitialAd(onFailed: () {
      setState(() => _interstitialAd = null);
    }, onLoaded: (ad) {
      setState(() => _interstitialAd = ad);
    });
    _showInterstitialAd();
  }

  void _showInterstitialAd() {
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
      });
    }
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
            collections = state.data as List;
          });
        }
      },
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          return LayoutWidget(
            isLoading: isLoading,
            pageTitle: "Collections",
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const GoogleBannerAd(),
                verticalSpacing(6),
                collections.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: collections.length,
                          itemBuilder: ((context, index) {
                            Collection collection = collections[index];
                            bool isFourthItem = (index % 4) == 0;
                            return !isFourthItem
                                ? CollectionCard(
                                    name: collection.name,
                                    hMargin: 0,
                                    imageUrl: collection.image,
                                    id: collection.id,
                                  )
                                : Column(
                                    children: [
                                      CollectionCard(
                                        name: collection.name,
                                        hMargin: 0,
                                        imageUrl: collection.image,
                                        id: collection.id,
                                      ),
                                      const GoogleBannerAd(),
                                      verticalSpacing(4),
                                    ],
                                  );
                          }),
                        ),
                      )
                    : const EmptyData(text: "No Collections")
              ],
            ),
          );
        },
      ),
    );
  }
}
