// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:user/app/util/color_constant.dart';
import 'package:user/app/util/size_utils.dart';


class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.width,
      this.height,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        visualDensity: VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        iconSize: getSize(height ?? 0),
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll4:
        return getPadding(
          all: 4,
        );
      case IconButtonPadding.PaddingAll17:
        return getPadding(
          all: 17,
        );
      default:
        return getPadding(
          all: 9,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.FillPink50:
        return ColorConstant.pink50;
      case IconButtonVariant.OutlineGray300:
        return ColorConstant.whiteA700;
      case IconButtonVariant.OutlineGray9000f:
        return ColorConstant.pink800;
      case IconButtonVariant.OutlineBlack9000f_1:
        return ColorConstant.pink800;
      case IconButtonVariant.FillPink800:
        return ColorConstant.pink800;
      case IconButtonVariant.FillGray100:
        return ColorConstant.gray100;
      case IconButtonVariant.FillRed60001:
        return ColorConstant.red60001;
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setBorder() {
    switch (variant) {
      case IconButtonVariant.OutlineGray300:
        return Border.all(
          color: ColorConstant.gray300,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.FillWhiteA700:
      case IconButtonVariant.FillPink50:
      case IconButtonVariant.OutlineGray9000f:
      case IconButtonVariant.OutlineBlack9000f_1:
      case IconButtonVariant.FillPink800:
      case IconButtonVariant.FillGray100:
      case IconButtonVariant.FillRed60001:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.RoundedBorder8:
        return BorderRadius.circular(
          getVerticalSize(
            8.00,
          ),
        );
      case IconButtonShape.CircleBorder12:
        return BorderRadius.circular(
          getVerticalSize(
            12.00,
          ),
        );
      case IconButtonShape.CircleBorder29:
        return BorderRadius.circular(
          getVerticalSize(
            29.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getVerticalSize(
            20.00,
          ),
        );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case IconButtonVariant.OutlineGray9000f:
        return [
          BoxShadow(
            color: ColorConstant.gray9000f,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              4,
            ),
          ),
        ];
      case IconButtonVariant.OutlineBlack9000f_1:
        return [
          BoxShadow(
            color: ColorConstant.black9000f,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              0,
            ),
          ),
        ];
      case IconButtonVariant.FillWhiteA700:
      case IconButtonVariant.FillPink50:
      case IconButtonVariant.OutlineGray300:
      case IconButtonVariant.FillPink800:
      case IconButtonVariant.FillGray100:
      case IconButtonVariant.FillRed60001:
        return null;
      default:
        return null;
    }
  }
}

enum IconButtonShape {
  CircleBorder20,
  RoundedBorder8,
  CircleBorder12,
  CircleBorder29,
}

enum IconButtonPadding {
  PaddingAll9,
  PaddingAll4,
  PaddingAll17,
}

enum IconButtonVariant {
  FillWhiteA700,
  FillPink50,
  OutlineGray300,
  OutlineGray9000f,
  OutlineBlack9000f_1,
  FillPink800,
  FillGray100,
  FillRed60001,
}
