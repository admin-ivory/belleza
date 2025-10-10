// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:user/app/util/color_constant.dart';
import 'package:user/app/util/size_utils.dart';


class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.prefixWidget,
      this.suffixWidget});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  Widget? prefixWidget;

  Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? getVerticalSize(40),
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      side: _setTextButtonBorder(),
      shadowColor: _setTextButtonShadowColor(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingT17:
        return getPadding(
          top: 17,
          right: 17,
          bottom: 17,
        );
      case ButtonPadding.PaddingAll26:
        return getPadding(
          all: 26,
        );
      case ButtonPadding.PaddingT47:
        return getPadding(
          top: 47,
          right: 47,
          bottom: 47,
        );
      case ButtonPadding.PaddingT44:
        return getPadding(
          top: 44,
          right: 44,
          bottom: 44,
        );
      case ButtonPadding.PaddingAll8:
        return getPadding(
          all: 8,
        );
      case ButtonPadding.PaddingAll5:
        return getPadding(
          all: 5,
        );
      case ButtonPadding.PaddingT1:
        return getPadding(
          top: 1,
          bottom: 1,
        );
      default:
        return getPadding(
          all: 15,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.OutlineBlack9000f:
        return ColorConstant.whiteA700;
      case ButtonVariant.White:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillPink50:
        return ColorConstant.pink50;
      case ButtonVariant.FillGray300:
        return ColorConstant.gray300;
      case ButtonVariant.FillGray600:
        return ColorConstant.gray600;
      case ButtonVariant.FillGray100:
        return ColorConstant.gray100;
      case ButtonVariant.FillGreen60001:
        return ColorConstant.green60001;
      case ButtonVariant.FillGreen500:
        return ColorConstant.green500;
      case ButtonVariant.FillRed600:
        return ColorConstant.red600;
      case ButtonVariant.OutlineGray300:
      case ButtonVariant.OutlinePink800:
        return null;
      default:
        return ColorConstant.pink800;
    }
  }

  _setTextButtonBorder() {
    switch (variant) {
      case ButtonVariant.OutlineGray300:
        return BorderSide(
          color: ColorConstant.gray300,
          width: getVerticalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlinePink800:
        return BorderSide(
          color: ColorConstant.pink800,
          width: getVerticalSize(
            1.00,
          ),
        );
      case ButtonVariant.FillPink800:
      case ButtonVariant.OutlineBlack9000f:
      case ButtonVariant.White:
      case ButtonVariant.FillPink50:
      case ButtonVariant.FillGray300:
      case ButtonVariant.FillGray600:
      case ButtonVariant.FillGray100:
      case ButtonVariant.FillGreen60001:
      case ButtonVariant.FillGreen500:
      case ButtonVariant.FillRed600:
        return null;
      default:
        return null;
    }
  }

  _setTextButtonShadowColor() {
    switch (variant) {
      case ButtonVariant.OutlineBlack9000f:
        return ColorConstant.black9000f;
      case ButtonVariant.FillPink800:
      case ButtonVariant.OutlineGray300:
      case ButtonVariant.White:
      case ButtonVariant.OutlinePink800:
      case ButtonVariant.FillPink50:
      case ButtonVariant.FillGray300:
      case ButtonVariant.FillGray600:
      case ButtonVariant.FillGray100:
      case ButtonVariant.FillGreen60001:
      case ButtonVariant.FillGreen500:
      case ButtonVariant.FillRed600:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder8:
        return BorderRadius.circular(
          getVerticalSize(
            8.00,
          ),
        );
      case ButtonShape.CircleBorder15:
        return BorderRadius.circular(
          getVerticalSize(
            15.00,
          ),
        );
      case ButtonShape.RoundedBorder19:
        return BorderRadius.circular(
          getVerticalSize(
            19.00,
          ),
        );
      case ButtonShape.CustomBorderTL16:
        return BorderRadius.only(
          topLeft: Radius.circular(
            getVerticalSize(
              16.00,
            ),
          ),
          topRight: Radius.circular(
            getVerticalSize(
              16.00,
            ),
          ),
          bottomLeft: Radius.circular(
            getVerticalSize(
              16.00,
            ),
          ),
          bottomRight: Radius.circular(
            getVerticalSize(
              0.00,
            ),
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getVerticalSize(
            26.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.SFProTextSemibold17:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            17,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SFProTextBold20:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            20,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.SFProTextBold28:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            28,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.SFProTextRegular13:
        return TextStyle(
          color: ColorConstant.pink800,
          fontSize: getFontSize(
            13,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.SFProTextBold18Pink800:
        return TextStyle(
          color: ColorConstant.pink800,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.SFProTextSemibold16:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SFProTextSemibold16Gray600:
        return TextStyle(
          color: ColorConstant.gray600,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SFProTextBold18Gray300:
        return TextStyle(
          color: ColorConstant.gray300,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.SFProTextRegular13Black900:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            13,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.SFProTextRegular17:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            17,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.SFProTextSemibold18:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SFProTextBold15:
        return TextStyle(
          color: ColorConstant.pink800,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.SFProTextBold15WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.SFProTextSemibold16WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SFProTextSemibold18WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SFProTextSemibold18Pink800:
        return TextStyle(
          color: ColorConstant.pink800,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SFProTextRegular16WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w400,
        );
      default:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder26,
  RoundedBorder8,
  CircleBorder15,
  RoundedBorder19,
  CustomBorderTL16,
}
enum ButtonPadding {
  PaddingAll15,
  PaddingT17,
  PaddingAll26,
  PaddingT47,
  PaddingT44,
  PaddingAll8,
  PaddingAll5,
  PaddingT1,
}
enum ButtonVariant {
  FillPink800,
  OutlineBlack9000f,
  OutlineGray300,
  White,
  OutlinePink800,
  FillPink50,
  FillGray300,
  FillGray600,
  FillGray100,
  FillGreen60001,
  FillGreen500,
  FillRed600,
}
enum ButtonFontStyle {
  SFProTextBold18,
  SFProTextSemibold17,
  SFProTextBold20,
  SFProTextBold28,
  SFProTextRegular13,
  SFProTextBold18Pink800,
  SFProTextSemibold16,
  SFProTextSemibold16Gray600,
  SFProTextBold18Gray300,
  SFProTextRegular13Black900,
  SFProTextRegular17,
  SFProTextSemibold18,
  SFProTextBold15,
  SFProTextBold15WhiteA700,
  SFProTextSemibold16WhiteA700,
  SFProTextSemibold18WhiteA700,
  SFProTextSemibold18Pink800,
  SFProTextRegular16WhiteA700,
}
