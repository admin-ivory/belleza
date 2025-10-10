// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:user/app/util/color_constant.dart';
import 'package:user/app/util/size_utils.dart';


class CustomFloatingButton extends StatelessWidget {
  CustomFloatingButton(
      {this.shape,
      this.variant,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.child});

  FloatingButtonShape? shape;

  FloatingButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildFabWidget(),
          )
        : _buildFabWidget();
  }

  _buildFabWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: FloatingActionButton(
        backgroundColor: _setColor(),
        onPressed: onTap,
        child: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          decoration: _buildDecoration(),
          child: child,
        ),
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      borderRadius: _setBorderRadius(),
    );
  }

  _setColor() {
    switch (variant) {
      case FloatingButtonVariant.FillGray100:
        return ColorConstant.gray100;
      default:
        return ColorConstant.pink800;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case FloatingButtonShape.CircleBorder29:
        return BorderRadius.circular(
          getHorizontalSize(
            29.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
        );
    }
  }
}

enum FloatingButtonShape {
  CircleBorder20,
  CircleBorder29,
}
enum FloatingButtonVariant {
  FillPink800,
  FillGray100,
}
