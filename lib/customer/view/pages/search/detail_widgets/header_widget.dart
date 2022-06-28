import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rent_home/customer/view/pages/search/detail_page.dart';
import 'package:rent_home/services/hive_service.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      width: 100.sw,
      child: Stack(
        fit: StackFit.expand,
        children: const [
          /// * images
          _Images(),

          /// * image tap control
          _TapControl(),

          /// * top Icons
          _TopIcons(),

          /// * top Indicators
          _TopWhiteImageIndicators(),
        ],
      ),
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailModel = DetailPageInherit.read(context)!.detailModel;
    final pageController = detailModel.pageController;
    final homeImages = detailModel.homeImages;

    return PageView.builder(
      controller: pageController,
      itemCount: homeImages.length,
      itemBuilder: (BuildContext context, int index) {
        return CachedNetworkImage(
          imageUrl: homeImages[index],
          placeholder: (context, url) => const ColoredBox(
            color: Color(0x999f9f9f),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        );
      },
      onPageChanged: detailModel.changedPage,
    );
  }
}

class _TapControl extends StatelessWidget {
  const _TapControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailModel = DetailPageInherit.read(context)!.detailModel;

    return SizedBox(
      height: 250.h,
      width: 100.sw,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: detailModel.moveLeft,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: detailModel.moveRight,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: detailModel.moveRight,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopIcons extends StatelessWidget {
  const _TopIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailModel = DetailPageInherit.read(context)!.detailModel;

    return Padding(
      padding: EdgeInsets.all(6.w),
      child: Column(
        children: [
          SizedBox(height: HiveService.box.get("height")),
          // top iconButtons
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconButtons(
                color: Colors.white,
                icon: Icons.arrow_back,
                onPressed: () => detailModel.goBack(context),
              ),
              const Spacer(),
              Row(
                children: [
                  _IconButtons(
                    color: Colors.white,
                    icon: Icons.share_outlined,
                    onPressed: () => detailModel.showBottomSheet(context),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _TopWhiteImageIndicators extends StatelessWidget {
  const _TopWhiteImageIndicators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailModel = DetailPageInherit.watch(context)!.detailModel;
    final homeImages = detailModel.homeImages;

    return Padding(
      padding: EdgeInsets.only(
        top: HiveService.box.get("height"),
        left: 5.w,
        right: 5.w,
        bottom: 5.h,
      ),
      child: SizedBox(
        height: 5.h,
        width: 100.sw,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < homeImages.length; i++)
              Expanded(
                child: AnimatedContainer(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  color: (i == detailModel.currentPage)
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                  duration: const Duration(milliseconds: 200),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _IconButtons extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final Color color;

  const _IconButtons({
    Key? key,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: color,
        shape: const CircleBorder(),
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.black,
        size: 18.sp,
      ),
    );
  }
}
