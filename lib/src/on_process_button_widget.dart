import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OnProcessButtonWidget extends StatefulWidget {
  const OnProcessButtonWidget({
    super.key,
    this.enable = true,
    this.animationDuration = const Duration(milliseconds: 500),
    this.margin,
    this.roundBorderWhenRunning = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.border,
    this.boxShadow,
    this.backgroundColor,
    this.onLongPress,
    this.onStatusChange,
    this.onTap,
    this.statusShowingDuration = const Duration(seconds: 2),
    this.onDone,
    this.height,
    this.width,
    this.isRunning = false,
    this.expanded = true,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    this.constraints = const BoxConstraints(minHeight: 48),
    this.iconHeight = 24,
    this.child,
    this.expandedIcon = false,
    this.alignment = Alignment.center,
    this.onRunningWidget,
    this.onSuccessWidget,
    this.onErrorWidget,
    this.iconColor,
    this.autofocus = false,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.enableFeedback = true,
    this.splashColor,
    this.textStyle,
    this.onHover,
    this.onHovering,
    this.focusNode,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.mouseCursor,
    this.onDoubleTap,
    this.onFocusChange,
    this.onHighlightChanged,
    this.onSecondaryTap,
    this.onSecondaryTapCancel,
    this.overlayColor,
    this.onSecondaryTapUp,
    this.onSecondaryTapDown,
    this.splashFactory,
    this.statesController,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.clip,
    this.textHeightBehavior,
    this.textMaxLines,
    this.textWrap = true,
    this.textWidthBasis = TextWidthBasis.parent,
  });

  final bool enable;
  final Duration animationDuration;
  final EdgeInsetsGeometry? margin;
  final bool roundBorderWhenRunning;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Color? backgroundColor;
  final void Function()? onLongPress;
  final Function(int i)? onStatusChange;
  final Future<bool?>? Function()? onTap;
  final Duration statusShowingDuration;
  final Function(bool? isSuccess)? onDone;
  final double? height;
  final double? width;
  final bool isRunning;
  final bool expanded;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? constraints;
  final double iconHeight;
  final Widget? child;
  final bool? expandedIcon;
  final AlignmentGeometry alignment;
  final Widget? onRunningWidget;
  final Widget? onSuccessWidget;
  final Widget? onErrorWidget;
  final Color? iconColor;
  final void Function(TapUpDetails tapUpDetails)? onTapUp;
  final void Function(TapDownDetails tapDownDetails)? onTapDown;
  final void Function()? onTapCancel;
  final bool autofocus;
  final Color? splashColor;
  final bool enableFeedback;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final bool textWrap;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final int? textMaxLines;
  final Function(bool isEnter)? onHover;
  final void Function(PointerHoverEvent offset)? onHovering;
  final FocusNode? focusNode;
  final Color? focusColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final MouseCursor? mouseCursor;
  final void Function()? onDoubleTap;
  final void Function(bool isFocused)? onFocusChange;
  final void Function(bool isHighlighted)? onHighlightChanged;
  final void Function()? onSecondaryTap;
  final void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp;
  final void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown;
  final void Function()? onSecondaryTapCancel;
  final MaterialStateProperty<Color?>? overlayColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final MaterialStatesController? statesController;

  @override
  State<OnProcessButtonWidget> createState() => _OnProcessButtonWidgetState();
}

class _OnProcessButtonWidgetState extends State<OnProcessButtonWidget> {
  late _ButtonStatus isRunning;
  bool? result;

  @override
  void initState() {
    super.initState();
    isRunning = widget.isRunning ? _ButtonStatus.running : _ButtonStatus.stable;
  }

  Widget statusChild(Widget c) {
    return SizedBox(
      height: widget.iconHeight,
      width: widget.iconHeight,
      child: FittedBox(child: c),
    );
  }

  Widget child(BuildContext context) {
    Color c = widget.iconColor ?? Theme.of(context).canvasColor;
    if (isRunning == _ButtonStatus.running) return widget.onRunningWidget ?? statusChild(CircularProgressIndicator(color: c));
    if (isRunning == _ButtonStatus.success) return widget.onSuccessWidget ?? statusChild(Icon(Icons.done, color: c));
    if (isRunning == _ButtonStatus.error) return widget.onErrorWidget ?? statusChild(Icon(Icons.error, color: c));

    return widget.child ?? const SizedBox();
  }

  BoxDecoration boxDecoration() {
    BorderRadiusGeometry? borderRadius = widget.borderRadius;

    if (widget.roundBorderWhenRunning && isRunning != _ButtonStatus.stable) borderRadius = BorderRadius.circular(100);

    return BoxDecoration(
      borderRadius: borderRadius,
      border: widget.border,
      boxShadow: widget.boxShadow,
      color: widget.boxShadow == null ? null : Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (widget.onHover != null) widget.onHover!(true);
      },
      onExit: (_) {
        if (widget.onHover != null) widget.onHover!(false);
      },
      onHover: widget.onHovering,
      child: Container(
        margin: widget.margin,
        clipBehavior: Clip.antiAlias,
        decoration: boxDecoration(),
        child: Material(
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          child: InkWell(
            onLongPress: widget.onLongPress,
            onTapUp: widget.onTapUp,
            onTapDown: widget.onTapDown,
            onTapCancel: widget.onTapCancel,
            autofocus: widget.autofocus,
            splashColor: widget.splashColor,
            enableFeedback: widget.enableFeedback,
            focusNode: widget.focusNode,
            focusColor: widget.focusColor,
            highlightColor: widget.highlightColor,
            hoverColor: widget.hoverColor,
            mouseCursor: widget.mouseCursor,
            onDoubleTap: widget.onDoubleTap,
            onFocusChange: widget.onFocusChange,
            onHighlightChanged: widget.onHighlightChanged,
            onSecondaryTap: widget.onSecondaryTap,
            onSecondaryTapUp: widget.onSecondaryTapUp,
            onSecondaryTapDown: widget.onSecondaryTapDown,
            onSecondaryTapCancel: widget.onSecondaryTapCancel,
            overlayColor: widget.overlayColor,
            splashFactory: widget.splashFactory,
            statesController: widget.statesController,
            onTap: !widget.enable
                ? null
                : () async {
                    if (!widget.enable) return;
                    if (isRunning != _ButtonStatus.stable) return;
                    if (mounted) setState(() => isRunning = _ButtonStatus.running);
                    if (widget.onStatusChange != null) widget.onStatusChange!(1); // Running = 1
                    if (widget.onTap != null) {
                      result = await widget.onTap!();
                      if (result != null) {
                        if (result! && mounted) {
                          setState(() => isRunning = _ButtonStatus.success);
                          if (widget.onStatusChange != null) widget.onStatusChange!(2); // Success = 2
                        }
                        if (!result! && mounted) {
                          setState(() => isRunning = _ButtonStatus.error);
                          if (widget.onStatusChange != null) widget.onStatusChange!(-1); // Success = -1
                        }
                        await Future.delayed(widget.statusShowingDuration);
                      }
                    }
                    if (widget.onDone != null) {
                      if (mounted) setState(() => isRunning = _ButtonStatus.running);
                      if (widget.onStatusChange != null) widget.onStatusChange!(1);
                      await widget.onDone!(result);
                    }

                    if (mounted) setState(() => isRunning = _ButtonStatus.stable);
                    if (widget.onStatusChange != null) widget.onStatusChange!(0); // Stable
                  },
            child: AnimatedSize(
              duration: widget.animationDuration,
              child: DefaultTextStyle(
                textAlign: widget.textAlign,
                textHeightBehavior: widget.textHeightBehavior,
                maxLines: widget.textMaxLines,
                overflow: widget.textOverflow,
                softWrap: widget.textWrap,
                textWidthBasis: widget.textWidthBasis,
                style: widget.textStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).canvasColor, fontWeight: FontWeight.bold) ?? const TextStyle(),
                child: Container(
                  height: widget.height,
                  width: widget.width,
                  padding: widget.contentPadding,
                  constraints: widget.constraints,
                  alignment: isRunning == _ButtonStatus.stable
                      ? widget.expanded
                          ? widget.alignment
                          : null
                      : widget.expandedIcon ?? widget.expanded
                          ? widget.alignment
                          : null,
                  child: child(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _ButtonStatus {
  stable,
  running,
  success,
  error
}
