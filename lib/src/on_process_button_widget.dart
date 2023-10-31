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
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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

  /// Button clickable. Default true
  final bool enable;

  /// Animation Duration
  final Duration animationDuration;

  /// Margin
  final EdgeInsetsGeometry? margin;

  /// Make the shape circular when processing
  final bool roundBorderWhenRunning;

  /// Border radius
  final BorderRadius borderRadius;

  /// Button border
  final BoxBorder? border;

  /// Button shadow
  final List<BoxShadow>? boxShadow;

  /// Button background color. Default color Theme.of(context).primaryColor
  final Color? backgroundColor;

  /// Callback function for long press
  final void Function()? onLongPress;

  /// Callback function for changing button status. Running = 1, Success = 2, Success = -1, Stable = 0
  final Function(int i)? onStatusChange;

  /// Callback function for pressing
  final Future<bool?>? Function()? onTap;

  /// Status showing duration
  final Duration statusShowingDuration;

  /// Callback function. It is called when the onTap is done
  final Function(bool? isSuccess)? onDone;

  /// Button height. Try to avoid static height. Use constraints instead
  final double? height;

  /// Button widget
  final double? width;

  /// If the app is doing some work and wants to show a loading indicator, use this with the passing key
  final bool isRunning;

  /// Button width is expanded or not
  final bool expanded;

  /// Button padding
  final EdgeInsetsGeometry? contentPadding;

  /// Button constraints
  final BoxConstraints? constraints;

  /// Button icon height
  final double iconHeight;

  /// Button child
  final Widget? child;

  /// On processing and status showing indicator is expanded or not
  final bool? expandedIcon;

  /// Child alignment
  final AlignmentGeometry alignment;

  /// On running widget. Default widget CircularProgressIndicator()
  final Widget? onRunningWidget;

  /// On success widget. Default widget Icon(Icons.done)
  final Widget? onSuccessWidget;

  /// On error widget. Default widget Icon(Icons.error)
  final Widget? onErrorWidget;

  /// Icon color. Default color Theme.of(context).canvasColor
  final Color? iconColor;

  /// Callback function for tapping up
  final void Function(TapUpDetails tapUpDetails)? onTapUp;

  /// Callback function for tapping down
  final void Function(TapDownDetails tapDownDetails)? onTapDown;

  /// Callback function for cancelling tap
  final void Function()? onTapCancel;

  /// Button auto focus
  final bool autofocus;

  /// Splash color
  final Color? splashColor;

  /// Button pressing feedback showing
  final bool enableFeedback;

  /// Button text style. Default Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).canvasColor, fontWeight: FontWeight.bold)
  final TextStyle? textStyle;

  /// Button text alignment
  final TextAlign textAlign;

  /// Button text overflow
  final TextOverflow textOverflow;

  /// Button text wrap
  final bool textWrap;

  /// Button text width basis
  final TextWidthBasis textWidthBasis;

  /// Button text height behavior
  final TextHeightBehavior? textHeightBehavior;

  /// Button text max line
  final int? textMaxLines;

  /// Callback function showing hovering status
  final Function(bool isEnter)? onHover;

  /// Callback function showing hovering offset
  final void Function(PointerHoverEvent offset)? onHovering;

  /// Button focus Node
  final FocusNode? focusNode;

  /// Button focus color
  final Color? focusColor;

  /// Button highlight color
  final Color? highlightColor;

  /// Button hover color
  final Color? hoverColor;

  /// Button mouse cursor
  final MouseCursor? mouseCursor;

  /// Callback function for double tap
  final void Function()? onDoubleTap;

  /// Callback function runs when focus is changed
  final void Function(bool isFocused)? onFocusChange;

  /// Callback function runs when high light is changed
  final void Function(bool isHighlighted)? onHighlightChanged;

  /// Callback function for Secondary Tap
  final void Function()? onSecondaryTap;

  /// Callback function for Secondary Tap up
  final void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp;

  /// Callback function for Secondary Tap down
  final void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown;

  /// Callback function for Secondary Tap cancel
  final void Function()? onSecondaryTapCancel;

  /// Button overlay color
  final MaterialStateProperty<Color?>? overlayColor;

  /// Button splashFactory
  final InteractiveInkFeatureFactory? splashFactory;

  /// Button state controller
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
    if (isRunning == _ButtonStatus.running) {
      return widget.onRunningWidget ??
          statusChild(CircularProgressIndicator(color: c));
    }
    if (isRunning == _ButtonStatus.success) {
      return widget.onSuccessWidget ?? statusChild(Icon(Icons.done, color: c));
    }
    if (isRunning == _ButtonStatus.error) {
      return widget.onErrorWidget ?? statusChild(Icon(Icons.error, color: c));
    }

    return widget.child ?? const SizedBox();
  }

  BoxDecoration boxDecoration() {
    BorderRadiusGeometry? borderRadius = widget.borderRadius;

    if (widget.roundBorderWhenRunning && isRunning != _ButtonStatus.stable) {
      borderRadius = BorderRadius.circular(100);
    }

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
                    if (mounted) {
                      setState(() => isRunning = _ButtonStatus.running);
                    }
                    if (widget.onStatusChange != null) {
                      widget.onStatusChange!(1); // Running = 1
                    }
                    if (widget.onTap != null) {
                      result = await widget.onTap!();
                      if (result != null) {
                        if (result! && mounted) {
                          setState(() => isRunning = _ButtonStatus.success);
                          if (widget.onStatusChange != null) {
                            widget.onStatusChange!(2); // Success = 2
                          }
                        }
                        if (!result! && mounted) {
                          setState(() => isRunning = _ButtonStatus.error);
                          if (widget.onStatusChange != null) {
                            widget.onStatusChange!(-1); // Success = -1
                          }
                        }
                        await Future.delayed(widget.statusShowingDuration);
                      }
                    }
                    if (widget.onDone != null) {
                      if (mounted) {
                        setState(() => isRunning = _ButtonStatus.running);
                      }
                      if (widget.onStatusChange != null) {
                        widget.onStatusChange!(1);
                      }
                      await widget.onDone!(result);
                    }

                    if (mounted) {
                      setState(() => isRunning = _ButtonStatus.stable);
                    }
                    if (widget.onStatusChange != null) {
                      widget.onStatusChange!(0); // Stable = 0
                    }
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
                style: widget.textStyle ??
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).canvasColor,
                        fontWeight: FontWeight.bold) ??
                    const TextStyle(),
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

enum _ButtonStatus { stable, running, success, error }
