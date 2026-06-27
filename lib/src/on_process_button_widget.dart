part of '../on_process_button_widget.dart';

/// A customizable button widget that provides visual feedback for
/// asynchronous operations.
///
/// Use [OnProcessButtonWidget] when you want to replace a standard button
/// (like [ElevatedButton]) with one that handles loading states and
/// success/error feedback automatically.
///
/// Example:
/// ```dart
/// OnProcessButtonWidget(
///   onTap: () async {
///     await Future.delayed(Duration(seconds: 1));
///     return true; // Shows success icon
///   },
///   child: Text('Submit'),
/// )
/// ```
class OnProcessButtonWidget extends StatefulWidget {
  /// Creates an [OnProcessButtonWidget].
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
    this.showRunningStatusWidget,
  }) : super(key: key);

  /// Called when the button is long-pressed.
  final void Function()? onLongPress;

  /// Called when the button status changes.
  ///
  /// The [OnProcessButtonStatus] enum represents the current state:
  /// - `stable`: The button is idle.
  /// - `running`: The `onTap` future is executing.
  /// - `success`: The `onTap` future returned `true`.
  /// - `error`: The `onTap` future returned `false`.
  final void Function(BuildContext? context, OnProcessButtonStatus i)?
      onStatusChange;

  /// The async operation to perform when the button is tapped.
  ///
  /// - Return `true`: Shows the [onSuccessWidget] (green check by default).
  /// - Return `false`: Shows the [onErrorWidget] (red error icon by default).
  /// - Return `null`: Skips the status display and returns to `stable`
  /// immediately.
  ///
  /// While the future is running, the button is disabled and shows
  /// [onRunningWidget].
  final Future<bool?>? Function()? onTap;

  /// Called after [onTap] is finished and the status (success/error) has been
  /// displayed for [statusShowingDuration].
  ///
  /// `isSuccess` will be the boolean result returned by [onTap].
  final void Function(bool? isSuccess)? onDone;

  /// Called when a tap up event occurs.
  final void Function(TapUpDetails tapUpDetails)? onTapUp;

  /// Called when a tap down event occurs.
  final void Function(TapDownDetails tapDownDetails)? onTapDown;

  /// Called when a tap is canceled.
  final void Function()? onTapCancel;

  /// Called when the mouse pointer enters or exits the button area.
  final void Function(bool isEnter)? onHover;

  /// Called when the mouse pointer moves within the button area.
  final void Function(PointerHoverEvent offset)? onHovering;

  /// Called on a double tap.
  final void Function()? onDoubleTap;

  /// Called when the focus state changes.
  final void Function(bool isFocused)? onFocusChange;

  /// Called when the highlight state changes.
  final void Function(bool isHighlighted)? onHighlightChanged;

  /// Called on a secondary (right-click) tap.
  final void Function()? onSecondaryTap;

  /// Called when a secondary tap up event occurs.
  final void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp;

  /// Called when a secondary tap down event occurs.
  final void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown;

  /// Called when a secondary tap is canceled.
  final void Function()? onSecondaryTapCancel;

  /// Alignment of the [child] within the button.
  final AlignmentGeometry? alignment;

  /// Alignment for the [AnimatedSize] transition.
  final AlignmentGeometry? animationAlignment;

  /// Duration of the size transition when switching states.
  ///
  /// Default: `Duration(milliseconds: 500)`
  final Duration? animationDuration;

  /// Whether the button should be focused automatically.
  final bool? autofocus;

  /// The background color of the button.
  ///
  /// If not provided, it uses the primary color from the [Theme].
  final Color? backgroundColor;

  /// The border to draw around the button.
  final BoxBorder? border;

  /// The border radius of the button.
  ///
  /// Default: `BorderRadius.circular(8)`
  final BorderRadius? borderRadius;

  /// The box shadow to display behind the button.
  final List<BoxShadow>? boxShadow;

  /// The primary content of the button (usually a [Text] widget).
  final Widget? child;

  /// Size constraints for the button.
  ///
  /// By default, it follows the standard button height from the [Theme].
  final BoxConstraints? constraints;

  /// Inner padding for the button content.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether the button is interactive. If `false`, `onTap` will not trigger.
  final bool? enable;

  /// Whether to provide haptic/visual feedback on tap.
  final bool? enableFeedback;

  /// Whether the button should expand to fill the available width.
  final bool? expanded;

  /// Whether the status indicator should expand to fill the available width.
  final bool? expandedIcon;

  /// The color to show when the button has focus.
  final Color? focusColor;

  /// The [FocusNode] for managing keyboard focus.
  final FocusNode? focusNode;

  /// The color of the text when using the default [TextStyle].
  final Color? fontColor;

  /// Fixed height for the button. Using [constraints] is generally preferred.
  final double? height;

  /// The color to show when the button is highlighted (pressed).
  final Color? highlightColor;

  /// The color to show when the mouse is hovering over the button.
  final Color? hoverColor;

  /// The color for the status icons (loading, success, error).
  final Color? iconColor;

  /// Fixed height for the status icons.
  final double? iconHeight;

  /// Manually force the button into a running/loading state.
  final bool isRunning;

  /// Outer margin around the button.
  final EdgeInsetsGeometry? margin;

  /// The cursor to show when the mouse is over the button.
  final MouseCursor? mouseCursor;

  /// Widget to show when [onTap] returns `false`.
  final Widget? onErrorWidget;

  /// Widget to show while [onTap] is executing.
  final Widget? onRunningWidget;

  /// Widget to show when [onTap] returns `true`.
  final Widget? onSuccessWidget;

  /// If `true`, the button becomes a circle when in a status state.
  final bool? roundBorderWhenRunning;

  /// The color of the splash effect when tapped.
  final Color? splashColor;

  /// The factory used to create the splash effect.
  final InteractiveInkFeatureFactory? splashFactory;

  /// How long to display the success or error widget before resetting to
  /// stable.
  ///
  /// Default: `Duration(seconds: 2)`
  final Duration? statusShowingDuration;

  /// Alignment of the text within its container.
  final TextAlign? textAlign;

  /// Text height behavior for the default [DefaultTextStyle].
  final TextHeightBehavior? textHeightBehavior;

  /// Maximum lines for the text.
  final int? textMaxLines;

  /// Overflow behavior for the text.
  final TextOverflow? textOverflow;

  /// The [TextStyle] for the button text.
  final TextStyle? textStyle;

  /// Font weight for the default text style.
  final FontWeight? fontWeight;

  /// Width basis for the text.
  final TextWidthBasis? textWidthBasis;

  /// Whether the text should wrap.
  final bool? textWrap;

  /// Whether to use Material 3 styling defaults.
  final bool? useMaterial3;

  /// Whether to show the running status widget.
  /// Default is `true`.
  final bool? showRunningStatusWidget;

  /// Fixed width for the button.
  final double? width;

  @override
  State<OnProcessButtonWidget> createState() => _OnProcessButtonWidgetState();
}

class _OnProcessButtonWidgetState extends State<OnProcessButtonWidget> {
  late OnProcessButtonStatus isRunning;
  OnProcessButtonThemeData? themeData;
  bool? result;

  late void Function()? onLongPress;
  late void Function(BuildContext? context, OnProcessButtonStatus i)?
      onStatusChange;
  late Future<bool?>? Function()? onTap;
  late void Function(bool? isSuccess)? onDone;
  late void Function(TapUpDetails tapUpDetails)? onTapUp;
  late void Function(TapDownDetails tapDownDetails)? onTapDown;
  late void Function()? onTapCancel;
  late void Function(bool isEnter)? onHover;
  late void Function(PointerHoverEvent offset)? onHovering;
  late void Function()? onDoubleTap;
  late void Function(bool isFocused)? onFocusChange;
  late void Function(bool isHighlighted)? onHighlightChanged;
  late void Function()? onSecondaryTap;
  late void Function()? onSecondaryTapCancel;
  late void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp;
  late void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown;
  late bool useMaterial3;
  late bool expanded;
  late bool? expandedIcon;
  late bool enable;
  late bool enableFeedback;
  late bool autofocus;
  late bool roundBorderWhenRunning;
  late Color backgroundColor;
  late Color iconColor;
  late Color fontColor;
  late Color? focusColor;
  late Color? splashColor;
  late Color? highlightColor;
  late Color? hoverColor;
  late BorderRadius borderRadius;
  late BoxBorder? border;
  late List<BoxShadow>? boxShadow;
  late double? width;
  late double? height;
  late double? iconHeight;
  late EdgeInsetsGeometry? margin;
  late EdgeInsetsGeometry contentPadding;
  late BoxConstraints? constraints;
  late AlignmentGeometry alignment;
  late AlignmentGeometry animationAlignment;
  late Duration animationDuration;
  late Duration statusShowingDuration;
  late MouseCursor? mouseCursor;
  late TextStyle textStyle;
  late FontWeight fontWeight;
  late TextAlign textAlign;
  late TextOverflow textOverflow;
  late TextHeightBehavior? textHeightBehavior;
  late int? textMaxLines;
  late bool textWrap;
  late TextWidthBasis textWidthBasis;
  late FocusNode? focusNode;
  late InteractiveInkFeatureFactory? splashFactory;
  late Widget? onRunningWidget;
  late Widget? onSuccessWidget;
  late Widget? onErrorWidget;
  late bool showRunningStatusWidget;

  @override
  void initState() {
    super.initState();
    isRunning = widget.isRunning
        ? OnProcessButtonStatus.running
        : OnProcessButtonStatus.stable;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ____setValues(context);
    ___setNotFinalVariables(context);
  }

  @override
  void didUpdateWidget(covariant OnProcessButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning != oldWidget.isRunning) {
      isRunning = widget.isRunning
          ? OnProcessButtonStatus.running
          : OnProcessButtonStatus.stable;
    }
    ____setValues(context);
    ___setNotFinalVariables(context);
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
      border: border,
      boxShadow: boxShadow,
      color: boxShadow == null
          ? null
          : Theme.of(context).colorScheme.surface,
    );
  }

  double get _____buttonConstraints {
    BoxConstraints c = widget.constraints ??
        BoxConstraints(
          minHeight: Theme.of(context).buttonTheme.height -
              (border?.top.width ?? 0) -
              (border?.bottom.width ?? 0),
        );
    return c.minHeight;
  }

  double get ____contentHeight {
    double f = _____buttonConstraints - contentPadding.vertical;
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
                      onDone!(result);
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

  void ____setValues(BuildContext context) {
    themeData = OnProcessButtonTheme.of(context);

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
    showRunningStatusWidget = widget.showRunningStatusWidget ??
        themeData?.showRunningStatusWidget ??
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
