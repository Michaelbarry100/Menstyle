import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styleapp/data/models/models.dart';
import 'package:styleapp/utils/utils.dart';
import 'package:styleapp/widgets/widgets.dart';

import '../cubits/request/request_cubit.dart';

class CategoriesPage extends StatefulWidget {
  final int? collection;
  const CategoriesPage({super.key, this.collection});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool isLoading = true;
  List categories = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RequestCubit>(context)
        .getCategories(collectionId: widget.collection);

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
            categories = state.data;
          });
        }
      },
      child: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          return LayoutWidget(
            isLoading: isLoading,
            pageTitle: "Categories",
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const GoogleBannerAd(),
                verticalSpacing(6),
                categories.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          itemCount: categories.length,
                            // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // maxCrossAxisExtent: 200,
                              childAspectRatio: 1,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemBuilder: (context, index) {
                              Category category =
                                  categories[index] as Category;
                              return CategoryCard(
                                name: category.name,
                                id: category.id,
                                rMarging: 0,
                                image: category.image,
                              );
                            }),
                      )
                    : const EmptyData(text: "No Categories"),
              ],
            ),
          );
        },
      ),
    );
  }
}
