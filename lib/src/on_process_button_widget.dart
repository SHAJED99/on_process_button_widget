part of '../on_process_button_widget.dart';

/// A customizable button widget that provides visual feedback for
/// asynchronous operations.
class OnProcessButtonWidget extends StatefulWidget {
  /// A customizable button widget that provides visual feedback for
  /// asynchronous operations.
  /// It supports various states like running, success, and error, with
  /// customizable animations,
  /// styling, and callback functions for different user interactions.
  const OnProcessButtonWidget({
    Key? key,
    this.enable,
    this.animationDuration,
    this.margin,
    this.roundBorderWhenRunning,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.backgroundColor,
    this.onLongPress,
    this.onStatusChange,
    this.onTap,
    this.statusShowingDuration,
    this.onDone,
    this.height,
    this.width,
    this.isRunning = false,
    this.expanded,
    this.contentPadding,
    this.constraints,
    this.iconHeight,
    this.child,
    this.expandedIcon,
    this.alignment,
    this.onRunningWidget,
    this.onSuccessWidget,
    this.onErrorWidget,
    this.iconColor,
    this.autofocus,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.enableFeedback,
    this.splashColor,
    this.textStyle,
    this.fontWeight,
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
    this.textAlign,
    this.textOverflow,
    this.textHeightBehavior,
    this.textMaxLines,
    this.textWrap,
    this.textWidthBasis,
    this.useMaterial3,
    this.fontColor,
    this.animationAlignment,
  }) : super(key: key);

  /// Callback function for long press
  final void Function()? onLongPress;

  /// Callback function for changing button status. Running = 1, Success = 2,
  /// Success = -1, Stable = 0
  final void Function(BuildContext? context, OnProcessButtonStatus i)?
      onStatusChange;

  /// Callback function for pressing. Returns a Future<bool?> indicating
  /// success or failure.
  final Future<bool?>? Function()? onTap;

  /// Callback function. It is called when the onTap is done. `isSuccess` is
  /// true if the operation was successful, false otherwise.
  final Function(bool? isSuccess)? onDone;

  /// Callback function for tapping up
  final void Function(TapUpDetails tapUpDetails)? onTapUp;

  /// Callback function for tapping down
  final void Function(TapDownDetails tapDownDetails)? onTapDown;

  /// Callback function for cancelling tap
  final void Function()? onTapCancel;

  /// Callback function showing hovering status. `isEnter` is true if the mouse
  /// pointer enters the button, false if it exits.
  final Function(bool isEnter)? onHover;

  /// Callback function showing hovering offset
  final void Function(PointerHoverEvent offset)? onHovering;

  /// Callback function for double tap
  final void Function()? onDoubleTap;

  /// Callback function runs when focus is changed. `isFocused` is true if the
  /// button gains focus, false otherwise.
  final void Function(bool isFocused)? onFocusChange;

  /// Callback function runs when high light is changed. `isHighlighted` is
  /// true if the button is highlighted, false otherwise.
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
  final AlignmentGeometry? alignment;

  /// Animation Alignment
  final AlignmentGeometry? animationAlignment;

  /// Animation Duration.
  /// Default:
  ///   Duration(milliseconds: 500)
  final Duration? animationDuration;

  /// Button auto focus
  final bool? autofocus;

  /// Button background color
  /// Default:
  ///   Theme.of(context).primaryColor
  final Color? backgroundColor;

  /// Button border
  final BoxBorder? border;

  /// Border radius.
  /// Default:
  ///   BorderRadius.all(Radius.circular(8))
  final BorderRadius? borderRadius;

  /// Button shadow
  final List<BoxShadow>? boxShadow;

  /// Button child widget to display inside the button.
  final Widget? child;

  /// Button constraints.
  /// Default:
  ///   BoxConstraints(minHeight: Theme.of(context).buttonTheme.height)
  final BoxConstraints? constraints;

  /// Button padding.
  /// Default:
  ///   EdgeInsets.symmetric(horizontal: 12, vertical: 4)
  final EdgeInsetsGeometry? contentPadding;

  /// Button clickable. Set to `false` to disable the button.
  /// Default: `true`
  final bool? enable;

  /// Button pressing feedback showing
  final bool? enableFeedback;

  /// Button width is expanded or not. If `true`, the button will take the full
  /// available width.
  final bool? expanded;

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

  /// If the app is doing some work and wants to show a loading indicator,
  /// use this with the passing key
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
  final bool? roundBorderWhenRunning;

  /// Splash color
  final Color? splashColor;

  /// Button splashFactory
  final InteractiveInkFeatureFactory? splashFactory;

  // /// Button state controller
  // final WidgetStatesController? statesController;

  /// Status showing duration.
  /// Default:
  ///   Duration(seconds: 2)
  final Duration? statusShowingDuration;

  /// Button text alignment
  final TextAlign? textAlign;

  /// Button text height behavior
  final TextHeightBehavior? textHeightBehavior;

  /// Button text max line
  final int? textMaxLines;

  /// Button text overflow
  final TextOverflow? textOverflow;

  /// Button text style.
  /// Default:
  ///   Theme.of(context).textTheme.titleMedium?.copyWith(color:
  ///   Theme.of(context).canvasColor, fontWeight: FontWeight.bold)
  final TextStyle? textStyle;

  /// Button text width basis
  /// Default:
  ///  FontWeight.bold
  final FontWeight? fontWeight;

  /// Button text width basis
  final TextWidthBasis? textWidthBasis;

  /// Button text wrap
  final bool? textWrap;

  /// Use material 3
  final bool? useMaterial3;

  /// Button widget
  final double? width;

  @override
  State<OnProcessButtonWidget> createState() => _OnProcessButtonWidgetState();
}

class _OnProcessButtonWidgetState extends State<OnProcessButtonWidget> {
  late OnProcessButtonStatus isRunning;
  late final OnProcessButtonThemeData? themeData;
  bool? result;

  late final void Function()? onLongPress;
  late final void Function(BuildContext? context, OnProcessButtonStatus i)?
      onStatusChange;
  late final Future<bool?>? Function()? onTap;
  late final Function(bool? isSuccess)? onDone;
  late final void Function(TapUpDetails tapUpDetails)? onTapUp;
  late final void Function(TapDownDetails tapDownDetails)? onTapDown;
  late final void Function()? onTapCancel;
  late final void Function(bool isEnter)? onHover;
  late final void Function(PointerHoverEvent offset)? onHovering;
  late final void Function()? onDoubleTap;
  late final void Function(bool isFocused)? onFocusChange;
  late final void Function(bool isHighlighted)? onHighlightChanged;
  late final void Function()? onSecondaryTap;
  late final void Function()? onSecondaryTapCancel;
  late final void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp;
  late final void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown;
  late final bool useMaterial3;
  late final bool expanded;
  late final bool? expandedIcon;
  late final bool enable;
  late final bool enableFeedback;
  late final bool autofocus;
  late final bool roundBorderWhenRunning;
  late Color backgroundColor;
  late Color iconColor;
  late Color fontColor;
  late final Color? focusColor;
  late final Color? splashColor;
  late final Color? highlightColor;
  late final Color? hoverColor;
  late final BorderRadius borderRadius;
  late final BoxBorder? border;
  late final List<BoxShadow>? boxShadow;
  late final double? width;
  late final double? height;
  late final double? iconHeight;
  late final EdgeInsetsGeometry? margin;
  late final EdgeInsetsGeometry contentPadding;
  late final BoxConstraints? constraints;
  late final AlignmentGeometry alignment;
  late final AlignmentGeometry animationAlignment;
  late final Duration animationDuration;
  late final Duration statusShowingDuration;
  late final MouseCursor? mouseCursor;
  late TextStyle textStyle;
  late final FontWeight fontWeight;
  late final TextAlign textAlign;
  late final TextOverflow textOverflow;
  late final TextHeightBehavior? textHeightBehavior;
  late final int? textMaxLines;
  late final bool textWrap;
  late final TextWidthBasis textWidthBasis;
  late final FocusNode? focusNode;
  late final InteractiveInkFeatureFactory? splashFactory;
  late final Widget? onRunningWidget;
  late final Widget? onSuccessWidget;
  late final Widget? onErrorWidget;
  late final bool showRunningStatusWidget;

  @override
  void initState() {
    super.initState();
    ____setFinalValues(context);
  }

  Widget statusChild(Widget c) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxHeight: iconHeight ?? 24,
              maxWidth: iconHeight ?? 24,
            ),
            height: iconHeight ?? ____contentHeight,
            width: iconHeight ?? ____contentHeight,
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
    Color c = iconColor;

    if (isRunning == OnProcessButtonStatus.running && showRunningStatusWidget) {
      return onRunningWidget ??
          statusChild(CircularProgressIndicator(color: c));
    }
    if (isRunning == OnProcessButtonStatus.success) {
      return onSuccessWidget ?? statusChild(Icon(Icons.done, color: c));
    }
    if (isRunning == OnProcessButtonStatus.error) {
      return onErrorWidget ?? statusChild(Icon(Icons.error, color: c));
    }

    return widget.child ?? const SizedBox();
  }

  BoxDecoration boxDecoration() {
    BorderRadius borderRadius_ = borderRadius;

    if (roundBorderWhenRunning && isRunning != OnProcessButtonStatus.stable) {
      borderRadius_ = BorderRadius.circular(MediaQuery.of(context).size.height);
    }

    return BoxDecoration(
      borderRadius: borderRadius_,
      border: widget.border,
      boxShadow: widget.boxShadow,
      color: widget.boxShadow == null
          ? null
          : Theme.of(context).colorScheme.surface,
    );
  }

  double get _____buttonConstraints {
    BoxConstraints c = widget.constraints ??
        BoxConstraints(
          minHeight: Theme.of(context).buttonTheme.height -
              (widget.border?.top.width ?? 0) -
              (widget.border?.bottom.width ?? 0),
        );
    return min(c.minHeight, c.minHeight);
  }

  double get ____contentHeight {
    double f = _____buttonConstraints - ((contentPadding.vertical) * 2);
    double fontSize = textStyle.fontSize ?? 0;
    double height = textStyle.height ?? 0;
    fontSize = MediaQuery.of(context).textScaler.scale(fontSize) -
        MediaQuery.of(context).textScaler.scale(height);
    if (f < fontSize) f = fontSize;
    return f;
  }

  EdgeInsetsGeometry? get _____padding {
    if (isRunning != OnProcessButtonStatus.stable) {
      return EdgeInsets.all((contentPadding.vertical) / 2);
    }

    return contentPadding;
  }

  @override
  Widget build(BuildContext context) {
    ___setNotFinalVariables(context);
    return MouseRegion(
      onEnter: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (onHover != null) onHover!(true);
        });
      },
      onExit: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (onHover != null) onHover!(false);
        });
      },
      onHover: onHovering,
      child: Container(
        margin: margin,
        clipBehavior: Clip.antiAlias,
        decoration: boxDecoration(),
        child: Material(
          color: backgroundColor,
          child: InkWell(
            onLongPress: onLongPress,
            onTapUp: onTapUp,
            onTapDown: onTapDown,
            onTapCancel: onTapCancel,
            autofocus: autofocus,
            splashColor: splashColor,
            enableFeedback: enableFeedback,
            focusNode: focusNode,
            focusColor: focusColor,
            highlightColor: highlightColor,
            hoverColor: hoverColor,
            mouseCursor: mouseCursor,
            onDoubleTap: onDoubleTap,
            onFocusChange: onFocusChange,
            onHighlightChanged: onHighlightChanged,
            onSecondaryTap: onSecondaryTap,
            onSecondaryTapUp: onSecondaryTapUp,
            onSecondaryTapDown: onSecondaryTapDown,
            onSecondaryTapCancel: onSecondaryTapCancel,
            // overlayColor: widget.overlayColor,
            splashFactory: splashFactory,
            // statesController: widget.statesController,
            onTap: !enable
                ? null
                : () async {
                    if (!enable) return;
                    if (isRunning != OnProcessButtonStatus.stable) return;
                    if (mounted) {
                      setState(() => isRunning = OnProcessButtonStatus.running);
                    }
                    if (onStatusChange != null) {
                      onStatusChange!(
                        context.mounted ? context : null,
                        OnProcessButtonStatus.running,
                      ); // Running = 1
                    }
                    if (onTap != null) {
                      result = await onTap!();
                      if (result != null) {
                        if (result! && mounted) {
                          setState(
                            () => isRunning = OnProcessButtonStatus.success,
                          );
                          if (onStatusChange != null) {
                            onStatusChange!(
                              context.mounted ? context : null,
                              OnProcessButtonStatus.success,
                            ); // Success = 2
                          }
                        }
                        if (!result! && mounted) {
                          setState(
                            () => isRunning = OnProcessButtonStatus.error,
                          );
                          if (onStatusChange != null) {
                            onStatusChange!(
                              context.mounted ? context : null,
                              OnProcessButtonStatus.error,
                            ); // Success = -1
                          }
                        }
                        await Future<void>.delayed(statusShowingDuration);
                      }
                    }
                    if (onDone != null) {
                      if (mounted) {
                        setState(
                          () => isRunning = OnProcessButtonStatus.running,
                        );
                      }
                      if (onStatusChange != null) {
                        onStatusChange!(
                          context.mounted ? context : null,
                          OnProcessButtonStatus.running,
                        );
                      }
                      await onDone!(result);
                    }

                    if (mounted) {
                      setState(() => isRunning = OnProcessButtonStatus.stable);
                    }
                    if (onStatusChange != null) {
                      onStatusChange!(
                        context.mounted ? context : null,
                        OnProcessButtonStatus.stable,
                      );
                    }
                  },
            child: AnimatedSize(
              alignment: animationAlignment,
              duration: animationDuration,
              child: DefaultTextStyle(
                textAlign: textAlign,
                textHeightBehavior: textHeightBehavior,
                maxLines: textMaxLines,
                overflow: textOverflow,
                softWrap: textWrap,
                textWidthBasis: textWidthBasis,
                style: textStyle,
                child: Container(
                  height: height,
                  width: width,
                  padding: _____padding,
                  constraints: widget.constraints ??
                      BoxConstraints(
                        minWidth: _____buttonConstraints,
                        minHeight: _____buttonConstraints,
                      ),
                  alignment: isRunning == OnProcessButtonStatus.stable
                      ? expanded
                          ? alignment
                          : null
                      : expandedIcon ?? expanded
                          ? alignment
                          : null,
                  child: expanded
                      ? child(context)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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

  void ____setFinalValues(BuildContext context) {
    themeData = OnProcessButtonTheme.of(context);

    isRunning = widget.isRunning
        ? OnProcessButtonStatus.running
        : OnProcessButtonStatus.stable;

    onLongPress = widget.onLongPress ??
        themeData?.onLongPress ??
        OnProcessButtonDefaultValues.onLongPress;
    onStatusChange = widget.onStatusChange ??
        themeData?.onStatusChange ??
        OnProcessButtonDefaultValues.onStatusChange;
    onTap =
        widget.onTap ?? themeData?.onTap ?? OnProcessButtonDefaultValues.onTap;
    onDone = widget.onDone ??
        themeData?.onDone ??
        OnProcessButtonDefaultValues.onDone;
    onTapUp = widget.onTapUp ??
        themeData?.onTapUp ??
        OnProcessButtonDefaultValues.onTapUp;
    onTapDown = widget.onTapDown ??
        themeData?.onTapDown ??
        OnProcessButtonDefaultValues.onTapDown;
    onTapCancel = widget.onTapCancel ??
        themeData?.onTapCancel ??
        OnProcessButtonDefaultValues.onTapCancel;
    onHover = widget.onHover ??
        themeData?.onHover ??
        OnProcessButtonDefaultValues.onHover;
    onHovering = widget.onHovering ??
        themeData?.onHovering ??
        OnProcessButtonDefaultValues.onHovering;
    onDoubleTap = widget.onDoubleTap ??
        themeData?.onDoubleTap ??
        OnProcessButtonDefaultValues.onDoubleTap;
    onFocusChange = widget.onFocusChange ??
        themeData?.onFocusChange ??
        OnProcessButtonDefaultValues.onFocusChange;
    onHighlightChanged = widget.onHighlightChanged ??
        themeData?.onHighlightChanged ??
        OnProcessButtonDefaultValues.onHighlightChanged;
    onSecondaryTap = widget.onSecondaryTap ??
        themeData?.onSecondaryTap ??
        OnProcessButtonDefaultValues.onSecondaryTap;
    onSecondaryTapCancel = widget.onSecondaryTapCancel ??
        themeData?.onSecondaryTapCancel ??
        OnProcessButtonDefaultValues.onSecondaryTapCancel;
    onSecondaryTapUp = widget.onSecondaryTapUp ??
        themeData?.onSecondaryTapUp ??
        OnProcessButtonDefaultValues.onSecondaryTapUp;
    onSecondaryTapDown = widget.onSecondaryTapDown ??
        themeData?.onSecondaryTapDown ??
        OnProcessButtonDefaultValues.onSecondaryTapDown;
    useMaterial3 = widget.useMaterial3 ??
        themeData?.useMaterial3 ??
        OnProcessButtonDefaultValues.useMaterial3 ??
        true;
    expanded = widget.expanded ??
        themeData?.expanded ??
        OnProcessButtonDefaultValues.expanded ??
        true;
    expandedIcon = widget.expandedIcon ??
        themeData?.expandedIcon ??
        OnProcessButtonDefaultValues.expandedIcon;
    enable = widget.enable ??
        themeData?.enable ??
        OnProcessButtonDefaultValues.enable ??
        true;
    enableFeedback = widget.enableFeedback ??
        themeData?.enableFeedback ??
        OnProcessButtonDefaultValues.enableFeedback ??
        true;
    autofocus = widget.autofocus ??
        themeData?.autofocus ??
        OnProcessButtonDefaultValues.autofocus ??
        true;
    roundBorderWhenRunning = widget.roundBorderWhenRunning ??
        themeData?.roundBorderWhenRunning ??
        OnProcessButtonDefaultValues.roundBorderWhenRunning ??
        true;

    focusColor = widget.focusColor ??
        themeData?.focusColor ??
        OnProcessButtonDefaultValues.focusColor;
    splashColor = widget.splashColor ??
        themeData?.splashColor ??
        OnProcessButtonDefaultValues.splashColor;
    highlightColor = widget.highlightColor ??
        themeData?.highlightColor ??
        OnProcessButtonDefaultValues.highlightColor;
    hoverColor = widget.hoverColor ??
        themeData?.hoverColor ??
        OnProcessButtonDefaultValues.hoverColor;
    borderRadius = widget.borderRadius ??
        themeData?.borderRadius ??
        OnProcessButtonDefaultValues.borderRadius ??
        const BorderRadius.all(Radius.circular(8));
    border = widget.border ??
        themeData?.border ??
        OnProcessButtonDefaultValues.border;
    boxShadow = widget.boxShadow ??
        themeData?.boxShadow ??
        OnProcessButtonDefaultValues.boxShadow;
    width =
        widget.width ?? themeData?.width ?? OnProcessButtonDefaultValues.width;
    height = widget.height ??
        themeData?.height ??
        OnProcessButtonDefaultValues.height;
    iconHeight = widget.iconHeight ??
        themeData?.iconHeight ??
        OnProcessButtonDefaultValues.iconHeight;
    margin = widget.margin ??
        themeData?.margin ??
        OnProcessButtonDefaultValues.margin;
    contentPadding = widget.contentPadding ??
        themeData?.contentPadding ??
        OnProcessButtonDefaultValues.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
    constraints = widget.constraints ??
        themeData?.constraints ??
        OnProcessButtonDefaultValues.constraints;
    alignment = widget.alignment ??
        themeData?.alignment ??
        OnProcessButtonDefaultValues.alignment ??
        Alignment.center;
    animationAlignment = widget.animationAlignment ??
        themeData?.animationAlignment ??
        OnProcessButtonDefaultValues.animationAlignment ??
        Alignment.center;
    animationDuration = widget.animationDuration ??
        themeData?.animationDuration ??
        OnProcessButtonDefaultValues.animationDuration ??
        const Duration(milliseconds: 500);
    statusShowingDuration = widget.statusShowingDuration ??
        themeData?.statusShowingDuration ??
        OnProcessButtonDefaultValues.statusShowingDuration ??
        const Duration(seconds: 2);
    mouseCursor = widget.mouseCursor ??
        themeData?.mouseCursor ??
        OnProcessButtonDefaultValues.mouseCursor;
    fontWeight = widget.fontWeight ??
        themeData?.fontWeight ??
        OnProcessButtonDefaultValues.fontWeight ??
        FontWeight.bold;

    textAlign = widget.textAlign ??
        themeData?.textAlign ??
        OnProcessButtonDefaultValues.textAlign ??
        TextAlign.center;
    textOverflow = widget.textOverflow ??
        themeData?.textOverflow ??
        OnProcessButtonDefaultValues.textOverflow ??
        TextOverflow.clip;
    textHeightBehavior = widget.textHeightBehavior ??
        themeData?.textHeightBehavior ??
        OnProcessButtonDefaultValues.textHeightBehavior;
    textMaxLines = widget.textMaxLines ??
        themeData?.textMaxLines ??
        OnProcessButtonDefaultValues.textMaxLines;
    textWrap = widget.textWrap ??
        themeData?.textWrap ??
        OnProcessButtonDefaultValues.textWrap ??
        true;
    textWidthBasis = widget.textWidthBasis ??
        themeData?.textWidthBasis ??
        OnProcessButtonDefaultValues.textWidthBasis ??
        TextWidthBasis.parent;
    focusNode = widget.focusNode ??
        themeData?.focusNode ??
        OnProcessButtonDefaultValues.focusNode;
    splashFactory = widget.splashFactory ??
        themeData?.splashFactory ??
        OnProcessButtonDefaultValues.splashFactory;
    onRunningWidget = widget.onRunningWidget ??
        themeData?.onRunningWidget ??
        OnProcessButtonDefaultValues.onRunningWidget;
    onSuccessWidget = widget.onSuccessWidget ??
        themeData?.onSuccessWidget ??
        OnProcessButtonDefaultValues.onSuccessWidget;
    onErrorWidget = widget.onErrorWidget ??
        themeData?.onErrorWidget ??
        OnProcessButtonDefaultValues.onErrorWidget;
    showRunningStatusWidget = themeData?.showRunningStatusWidget ??
        OnProcessButtonDefaultValues.showRunningStatusWidget ??
        true;
  }

  void ___setNotFinalVariables(BuildContext context) {
    Color primaryColor() => useMaterial3
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).primaryColor;
    Color onPrimaryColor() => useMaterial3
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).canvasColor;

    backgroundColor = widget.backgroundColor ??
        themeData?.backgroundColor ??
        OnProcessButtonDefaultValues.backgroundColor ??
        primaryColor();
    iconColor = widget.iconColor ??
        themeData?.iconColor ??
        OnProcessButtonDefaultValues.iconColor ??
        onPrimaryColor();
    fontColor = widget.fontColor ??
        themeData?.fontColor ??
        OnProcessButtonDefaultValues.fontColor ??
        onPrimaryColor();

    textStyle = widget.textStyle ??
        themeData?.textStyle ??
        OnProcessButtonDefaultValues.textStyle ??
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: fontColor,
              fontWeight: fontWeight,
            ) ??
        const TextStyle();
  }
}
