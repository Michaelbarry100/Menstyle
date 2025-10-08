import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styleapp/data/models/styles.dart';
import 'package:styleapp/utils/utils.dart';
import '../theme.dart';

class CollectionCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int? id;
  final double hMargin;

  const CollectionCard({
    required this.name,
    this.id,
    required this.imageUrl,
    this.hMargin = 22,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('categories', extra: {"collection": id});
      },
      child: Container(
        height: 138,
        width: double.maxFinite,
        margin: EdgeInsets.only(bottom: 12, left: hMargin, right: hMargin),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12,
          ),
          image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter),
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: 14,
                right: 14,
                child: Text(
                  name,
                  style: GoogleFonts.aclonica(
                      fontSize: 22, color: AppColors.white),
                ))
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final String image;
  final double rMarging;
  final int id;

  const CategoryCard({
    required this.name,
    this.rMarging = 12,
    required this.image,
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("designs", extra: {"category": id});
      },
      child: Container(
        height: 142,
        width: 136,
        margin: EdgeInsets.only(right: rMarging),
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
                      color: Colors.white),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class StyleCard extends StatelessWidget {
  final String name;
  final String image;
  final bool isSaved;
  final Style style;
  final Function onSave;
  const StyleCard({
    required this.name,
    required this.image,
    required this.onSave,
    required this.style,
    this.isSaved = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('design', extra: style);
      },
      child: Container(
        height: 468,
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
            border: Border.all(width: 2, color: Colors.grey.shade300)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                width: double.maxFinite,
                // height: double.,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                ),
              ),
            ),
            verticalSpacing(6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark),
                        ),
                        Text(
                          "${style.category}",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onSave();
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color:
                            isSaved ? AppColors.textFaded : AppColors.primary,
                      ),
                      child: Icon(
                        Icons.star,
                        size: 24,
                        color: Colors.amber.shade100,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
