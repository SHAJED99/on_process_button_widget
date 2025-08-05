part of '../on_process_button_widget.dart';

class OnProcessButtonWidget extends StatefulWidget {
  const OnProcessButtonWidget({
    Key? key,
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
    this.constraints,
    this.iconHeight,
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
    // this.overlayColor,
    this.onSecondaryTapUp,
    this.onSecondaryTapDown,
    this.splashFactory,
    // this.statesController,
    this.textAlign = TextAlign.center,
    this.textOverflow = TextOverflow.clip,
    this.textHeightBehavior,
    this.textMaxLines,
    this.textWrap = true,
    this.textWidthBasis = TextWidthBasis.parent,
    this.useMaterial3 = true,
    this.fontColor,
    this.animationAlignment = Alignment.center,
  }) : super(key: key);

  /// Callback function for long press
  final void Function()? onLongPress;

  /// Callback function for changing button status. Running = 1, Success = 2, Success = -1, Stable = 0
  final Function(int i)? onStatusChange;

  /// Callback function for pressing
  final Future<bool?>? Function()? onTap;

  /// Callback function. It is called when the onTap is done
  final Function(bool? isSuccess)? onDone;

  /// Callback function for tapping up
  final void Function(TapUpDetails tapUpDetails)? onTapUp;

  /// Callback function for tapping down
  final void Function(TapDownDetails tapDownDetails)? onTapDown;

  /// Callback function for cancelling tap
  final void Function()? onTapCancel;

  /// Callback function showing hovering status
  final Function(bool isEnter)? onHover;

  /// Callback function showing hovering offset
  final void Function(PointerHoverEvent offset)? onHovering;

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

  /// Child alignment
  final AlignmentGeometry alignment;

  /// Animation Alignment
  final AlignmentGeometry animationAlignment;

  /// Animation Duration.
  /// Default:
  ///   Duration(milliseconds: 500
  final Duration animationDuration;

  /// Button auto focus
  final bool autofocus;

  /// Button background color
  /// Default:
  ///   Theme.of(context).primaryColor
  final Color? backgroundColor;

  /// Button border
  final BoxBorder? border;

  /// Border radius.
  /// Default:
  ///   BorderRadius.all(Radius.circular(8))
  final BorderRadius borderRadius;

  /// Button shadow
  final List<BoxShadow>? boxShadow;

  /// Button child
  final Widget? child;

  /// Button constraints.
  /// Default:
  ///   BoxConstraints(minHeight: Theme.of(context).buttonTheme.height)
  final BoxConstraints? constraints;

  /// Button padding.
  /// Default:
  ///   EdgeInsets.symmetric(horizontal: 12, vertical: 4)
  final EdgeInsetsGeometry? contentPadding;

  /// Button clickable.
  /// Default true
  final bool enable;

  /// Button pressing feedback showing
  final bool enableFeedback;

  /// Button width is expanded or not
  final bool expanded;

  /// On processing and status showing indicator is expanded or not
  final bool? expandedIcon;

  /// Button focus color
  final Color? focusColor;

  /// Button focus Node
  final FocusNode? focusNode;

  /// Font color
  final Color? fontColor;

  /// Button height. Try to avoid static height. Use constraints instead
  final double? height;

  /// Button highlight color
  final Color? highlightColor;

  /// Button hover color
  final Color? hoverColor;

  /// Icon color.
  /// Default:
  ///   Theme.of(context).canvasColor
  final Color? iconColor;

  /// Button icon height
  final double? iconHeight;

  /// If the app is doing some work and wants to show a loading indicator, use this with the passing key
  final bool isRunning;

  /// Margin
  final EdgeInsetsGeometry? margin;

  /// Button mouse cursor
  final MouseCursor? mouseCursor;

  /// On error widget.
  /// Default:
  ///   Icon(Icons.error)
  final Widget? onErrorWidget;

  /// On running widget.
  /// Default:
  ///   CircularProgressIndicator()
  final Widget? onRunningWidget;

  /// On success widget.
  /// Default:
  ///   Icon(Icons.done)
  final Widget? onSuccessWidget;

  // /// Button overlay color
  // final WidgetStateProperty<Color?>? overlayColor;

  /// Make the shape circular when processing
  final bool roundBorderWhenRunning;

  /// Splash color
  final Color? splashColor;

  /// Button splashFactory
  final InteractiveInkFeatureFactory? splashFactory;

  // /// Button state controller
  // final WidgetStatesController? statesController;

  /// Status showing duration.
  /// Default:
  ///   Duration(seconds: 2)
  final Duration statusShowingDuration;

  /// Button text alignment
  final TextAlign textAlign;

  /// Button text height behavior
  final TextHeightBehavior? textHeightBehavior;

  /// Button text max line
  final int? textMaxLines;

  /// Button text overflow
  final TextOverflow textOverflow;

  /// Button text style.
  /// Default:
  ///   Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).canvasColor, fontWeight: FontWeight.bold)
  final TextStyle? textStyle;

  /// Button text width basis
  final TextWidthBasis textWidthBasis;

  /// Button text wrap
  final bool textWrap;

  /// Use material 3
  final bool useMaterial3;

  /// Button widget
  final double? width;

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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: widget.iconHeight ?? 24,
              maxWidth: widget.iconHeight ?? 24,
            ),
            height: widget.iconHeight ?? ____contentHeight,
            width: widget.iconHeight ?? ____contentHeight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: c,
            ),
          ),
        ],
      ),
    );
  }

  Widget child(BuildContext context) {
    Color c = widget.iconColor ?? (widget.useMaterial3 ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).canvasColor);
    if (isRunning == _ButtonStatus.running) {
      return widget.onRunningWidget ?? statusChild(CircularProgressIndicator(color: c));
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
      borderRadius = BorderRadius.circular(MediaQuery.of(context).size.height);
    }

    return BoxDecoration(
      borderRadius: borderRadius,
      border: widget.border,
      boxShadow: widget.boxShadow,
      color: widget.boxShadow == null ? null : Theme.of(context).colorScheme.surface,
    );
  }

  double get _____buttonConstraints {
    var c = widget.constraints ?? BoxConstraints(minHeight: Theme.of(context).buttonTheme.height - (widget.border?.top.width ?? 0) - (widget.border?.bottom.width ?? 0));
    return min(c.minHeight, c.minHeight);
  }

  double get ____contentHeight {
    double f = _____buttonConstraints - ((widget.contentPadding?.vertical ?? 0) * 2);
    double fontSize = (widget.textStyle ?? Theme.of(context).textTheme.titleMedium)?.fontSize ?? 0;
    double height = (widget.textStyle ?? Theme.of(context).textTheme.titleMedium)?.height ?? 0;
    fontSize = MediaQuery.of(context).textScaler.scale(fontSize) - MediaQuery.of(context).textScaler.scale(height);
    if (f < fontSize) f = fontSize;
    return f;
  }

  EdgeInsetsGeometry? get _____padding {
    if (isRunning != _ButtonStatus.stable) {
      return EdgeInsets.all((widget.contentPadding?.vertical ?? 0) / 2);
    }

    return widget.contentPadding;
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
          color: widget.backgroundColor ?? (widget.useMaterial3 ? Theme.of(context).colorScheme.primary : Theme.of(context).primaryColor),
          child: InkWell(
            onLongPress: widget.onLongPress ?? OnProcessButtonDefaultValues.onLongPress,
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
            // overlayColor: widget.overlayColor,
            splashFactory: widget.splashFactory,
            // statesController: widget.statesController,
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
              alignment: widget.animationAlignment,
              duration: widget.animationDuration,
              child: DefaultTextStyle(
                textAlign: widget.textAlign,
                textHeightBehavior: widget.textHeightBehavior,
                maxLines: widget.textMaxLines,
                overflow: widget.textOverflow,
                softWrap: widget.textWrap,
                textWidthBasis: widget.textWidthBasis,
                style: widget.textStyle ?? Theme.of(context).textTheme.titleMedium?.copyWith(color: widget.fontColor ?? (widget.useMaterial3 ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).primaryColor), fontWeight: FontWeight.bold) ?? const TextStyle(),
                child: Container(
                  height: widget.height,
                  width: widget.width,
                  padding: _____padding,
                  constraints: widget.constraints ?? BoxConstraints(minWidth: _____buttonConstraints, minHeight: _____buttonConstraints),
                  alignment: isRunning == _ButtonStatus.stable
                      ? widget.expanded
                          ? widget.alignment
                          : null
                      : widget.expandedIcon ?? widget.expanded
                          ? widget.alignment
                          : null,
                  child: widget.expanded
                      ? child(context)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            child(context),
                          ],
                        ),
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
