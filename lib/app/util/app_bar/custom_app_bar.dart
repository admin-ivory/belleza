import 'package:flutter/material.dart';
import 'package:user/app/util/color_constant.dart';
import 'package:user/app/util/size_utils.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    required this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  });

  double height;

  Style? styleType;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  bool? centerTitle;

  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        size.width,
        height,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgFillWhiteA700:
        return Container(
          height: getVerticalSize(
            81,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: ColorConstant.whiteA700,
          ),
        );
      case Style.bgFillGray50:
        return Container(
          height: getVerticalSize(
            46,
          ),
          width: getHorizontalSize(
            336,
          ),
          margin: getMargin(
            left: 16,
            right: 76,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.gray50,
            borderRadius: BorderRadius.circular(
              getHorizontalSize(
                16,
              ),
            ),
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFillWhiteA700,
  bgFillGray50,
}
