import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key key,
    @required Widget content,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.behavior = SnackBarBehavior.floating,
    Widget action,
    this.duration = const Duration(milliseconds: 4000),
    this.animation,
    this.onVisible,
  })  : action = null,
        content = MultilineSnackBar(
          content: Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: content,
          ),
          action: action != null
              ? ButtonTheme(
                  textTheme: ButtonTextTheme.accent,
                  height: 22.0,
                  minWidth: 44.0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: action,
                )
              : const SizedBox(),
          verticalSpacing: 8.0,
        ),
        super(
          key: key,
          content: content,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: shape,
          behavior: behavior,
          action: null,
          duration: duration,
          animation: animation,
          onVisible: onVisible,
        );

  final Widget content;

  final Color backgroundColor;

  final double elevation;

  final ShapeBorder shape;

  final SnackBarBehavior behavior;

  final SnackBarAction action;

  final Duration duration;

  final Animation<double> animation;

  final VoidCallback onVisible;
}

class MultilineSnackBar extends MultiChildRenderObjectWidget {
  MultilineSnackBar({
    Key key,
    this.content,
    this.action = const SizedBox(),
    this.verticalSpacing = 8.0,
  })  : assert(content != null),
        assert(action != null),
        assert(verticalSpacing != null),
        super(key: key, children: [content, action]);

  final Widget content;
  final Widget action;
  final double verticalSpacing;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMultilineSnackBar(
      spacing: verticalSpacing,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderMultilineSnackBar renderObject) {
    renderObject..spacing = verticalSpacing;
  }
}

class RenderMultilineSnackBar extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _MultilineSnackBarParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            _MultilineSnackBarParentData> {
  RenderMultilineSnackBar({
    double spacing,
    List<RenderBox> children,
  }) : _spacing = spacing {
    addAll(children);
  }

  double _spacing;
  double get spacing => _spacing;

  set spacing(double value) {
    if (value == _spacing) return;
    _spacing = value;
    markNeedsLayout();
  }

  RenderBox get content => firstChild;

  RenderBox get action => lastChild;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _MultilineSnackBarParentData) {
      child.parentData = _MultilineSnackBarParentData();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) => 0.0;

  @override
  double computeMaxIntrinsicWidth(double height) => 0.0;

  @override
  double computeMinIntrinsicHeight(double width) {
    return math.max(
      content.getMinIntrinsicHeight(width),
      action.getMinIntrinsicHeight(width),
    );
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return content.getMaxIntrinsicHeight(width) +
        action.getMaxIntrinsicHeight(width) +
        spacing;
  }

  // @override
  // Size get size => super.size ?? Size(0, 0);

  @override
  void performLayout() {
    assert(constraints.hasBoundedWidth);

    final width = constraints.maxWidth;
    if (constraints.hasBoundedHeight) {
      final height = constraints.maxHeight;
      size = constraints.constrain(Size(width, height));
    } else {
      size = constraints.constrain(Size(width, 10000.0));
    }

    final minHeight = computeMinIntrinsicHeight(width);
    final maxHeight = computeMaxIntrinsicHeight(width);

    action.layout(
      BoxConstraints.loose(size),
      parentUsesSize: true,
    );
    final actionData = action.parentData as _MultilineSnackBarParentData;

    //print('Action: ${action.size}');

    content.layout(
      BoxConstraints(
        minWidth: 0.0,
        maxWidth: width,
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      parentUsesSize: true,
    );
    //print('Content: ${content.size}');
    //print('Size: $size');
    var totalHeight = content.size.height;

    if (content.size.width > width - action.size.width) {
      //print('Text size larger than width - action');
      final verticalOffset = content.size.height + spacing;
      totalHeight = verticalOffset + action.size.height;
      actionData.offset = Offset(width - action.size.width, verticalOffset);
    } else {
      //print('Text size smaller than width - action');
      actionData.offset = Offset(width - action.size.width, 0.0);
    }

    size = constraints.constrain(Size(width, totalHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

class _MultilineSnackBarParentData extends ContainerBoxParentData<RenderBox> {}
