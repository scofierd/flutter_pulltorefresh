/**
    Author: Jpeng
    Email: peng8350@gmail.com
    createTime:2018-05-14 17:39
 */

import 'package:flutter/material.dart' hide RefreshIndicator,RefreshIndicatorState;
import 'package:flutter/widgets.dart';
import '../internals/default_constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum IconPosition { left, right, top, bottom }

class ClassicHeader extends RefreshIndicator {
  final String releaseText, idleText, refreshingText, completeText, failedText;

  final Widget releaseIcon, idleIcon, refreshingIcon, completeIcon, failedIcon;

  final double spacing;

  final IconPosition iconPos;

  final TextStyle textStyle;

  ClassicHeader({
    Key key,
    RefreshStyle refreshStyle:default_refreshStyle,
    this.textStyle: const TextStyle(color: const Color(0xff555555)),
    double triggerDistance: default_refresh_triggerDistance,
    this.releaseText: 'Refresh when release',
    this.refreshingText: 'Refreshing...',
    this.completeText: 'Refresh complete',
    double height:default_height,
    this.failedText: 'Refresh failed',
    this.idleText: 'Pull down to refresh',
    this.iconPos: IconPosition.left,
    this.spacing: 15.0,
    this.refreshingIcon: const CircularProgressIndicator(strokeWidth: 2.0),
    this.failedIcon: const Icon(Icons.clear, color: Colors.grey),
    this.completeIcon: const Icon(Icons.done, color: Colors.grey),
    this.idleIcon = const Icon(Icons.arrow_downward, color: Colors.grey),
    this.releaseIcon = const Icon(Icons.arrow_upward, color: Colors.grey),
  }) : super(
            key: key ?? GlobalKey(),
            refreshStyle: refreshStyle,
            height: height,
            triggerDistance: triggerDistance);

  @override
  State createState() {
    // TODO: implement createState
    return _ClassicHeaderState();
  }
}

class _ClassicHeaderState extends State<ClassicHeader> {
  Widget _buildText(mode) {
    return Text(
        mode == RefreshStatus.canRefresh
            ? widget.releaseText
            : mode == RefreshStatus.completed
                ? widget.completeText
                : mode == RefreshStatus.failed
                    ? widget.failedText
                    : mode == RefreshStatus.refreshing
                        ? widget.refreshingText
                        : widget.idleText,
        style: widget.textStyle);
  }

  Widget _buildIcon(mode) {
    Widget icon = mode == RefreshStatus.canRefresh
        ? widget.releaseIcon
        : mode == RefreshStatus.idle
            ? widget.idleIcon
            : mode == RefreshStatus.completed
                ? widget.completeIcon
                : mode == RefreshStatus.failed
                    ? widget.failedIcon
                    : SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: widget.refreshingIcon,
                      );
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildContent
    final RefreshStatus mode =
        SmartRefresher.of(context).controller.headerStatus;
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    List<Widget> children = <Widget>[
      iconWidget,
      Container(
        width: widget.spacing,
      ),
      textWidget
    ];
    Widget container = (widget.iconPos == IconPosition.top ||
            widget.iconPos == IconPosition.bottom)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: widget.iconPos == IconPosition.top
                ? VerticalDirection.down
                : VerticalDirection.up,
            children: children,
          )
        : Row(
            textDirection: widget.iconPos == IconPosition.right
                ? TextDirection.rtl
                : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
    return Container(
      height: widget.height,
      child: Center(
        child: container,
      ),
    );
  }
}

class ClassicFooter extends LoadIndicator {
  final bool autoLoad;

  final double triggerDistance;

  final String idleText, loadingText, noDataText;

  final Widget idleIcon, loadingIcon, noMoreIcon;

  final double height;

  final double spacing;

  final IconPosition iconPos;

  final TextStyle textStyle;

  const ClassicFooter({
    Key key,
    this.autoLoad:default_AutoLoad,
    this.triggerDistance:default_refresh_triggerDistance,
    this.textStyle: const TextStyle(color: const Color(0xff555555)),
    this.loadingText: 'Loading...',
    this.noDataText: 'No more data',
    this.height: 60.0,
    this.noMoreIcon: const Icon(Icons.clear, color: Colors.grey),
    this.idleText: 'Pull down to refresh',
    this.iconPos: IconPosition.left,
    this.spacing: 15.0,
    this.loadingIcon: const CircularProgressIndicator(strokeWidth: 2.0),
    this.idleIcon = const Icon(Icons.arrow_downward, color: Colors.grey),
  }) : super(key: key, triggerDistance: triggerDistance);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _ClassicFooterState();
  }
}

class _ClassicFooterState extends State<ClassicFooter> {
  Widget _buildText(LoadStatus mode) {
    return Text(
        mode == LoadStatus.loading
            ? widget.loadingText
            : LoadStatus.noMore == mode ? widget.noDataText : widget.idleText,
        style: widget.textStyle);
  }

  Widget _buildIcon(LoadStatus mode) {
    Widget icon = mode == LoadStatus.loading
        ? widget.loadingIcon
        : mode == LoadStatus.noMore ? widget.noMoreIcon : widget.idleIcon;
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildContent
    final LoadStatus mode = SmartRefresher.of(context).controller.footerStatus;
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    List<Widget> children = <Widget>[
      iconWidget,
      Container(
        width: widget.spacing,
      ),
      textWidget
    ];
    Widget container = (widget.iconPos == IconPosition.top ||
            widget.iconPos == IconPosition.bottom)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: widget.iconPos == IconPosition.top
                ? VerticalDirection.down
                : VerticalDirection.up,
            children: children,
          )
        : Row(
            textDirection: widget.iconPos == IconPosition.right
                ? TextDirection.rtl
                : TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
    return Container(
      height: widget.height,
      child: Center(
        child: container,
      ),
    );
  }
}
