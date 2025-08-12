part of '../on_process_button_widget.dart';

/// Theme data class that holds all the default values for OnProcessButtonWidget
class OnProcessButtonThemeData {
  const OnProcessButtonThemeData({
    // Callback Functions
    this.onLongPress,
    this.onStatusChange,
    this.onTap,
    this.onDone,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.onHover,
    this.onHovering,
    this.onDoubleTap,
    this.onFocusChange,
    this.onHighlightChanged,
    this.onSecondaryTap,
    this.onSecondaryTapCancel,
    this.onSecondaryTapUp,
    this.onSecondaryTapDown,

    // Appearance & Layout
    this.useMaterial3,
    this.expanded,
    this.expandedIcon,
    this.enable,
    this.enableFeedback,
    this.autofocus,
    this.roundBorderWhenRunning,
    this.backgroundColor,
    this.iconColor,
    this.fontColor,
    this.focusColor,
    this.splashColor,
    this.highlightColor,
    this.hoverColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.width,
    this.height,
    this.iconHeight,
    this.margin,
    this.contentPadding,
    this.constraints,
    this.alignment,
    this.animationAlignment,
    this.animationDuration,
    this.statusShowingDuration,
    this.mouseCursor,
    this.textStyle,
    this.fontWeight,
    this.textAlign,
    this.textOverflow,
    this.textHeightBehavior,
    this.textMaxLines,
    this.textWrap,
    this.textWidthBasis,
    this.focusNode,
    this.splashFactory,

    // Status Widgets
    this.onRunningWidget,
    this.onSuccessWidget,
    this.onErrorWidget,
    this.showRunningStatusWidget,
  });

  // ────────────────────────────────────────
  // 🧩 Callback Functions
  // ────────────────────────────────────────

  /// Called when the button is long-pressed.
  final void Function()? onLongPress;

  /// Called when the button status changes.
  final Function(int i)? onStatusChange;

  /// Called when the button is tapped.
  final Future<bool?> Function()? onTap;

  /// Called when the button process is done.
  final Function(bool? isSuccess)? onDone;

  /// Called when the button is tapped up.
  final void Function(TapUpDetails tapUpDetails)? onTapUp;

  /// Called when the button is tapped down.
  final void Function(TapDownDetails tapDownDetails)? onTapDown;

  /// Called when the tap is canceled.
  final void Function()? onTapCancel;

  /// Called when the button is hovered.
  final void Function(bool isEnter)? onHover;

  /// Called when the button is hovered with a pointer.
  final void Function(PointerHoverEvent offset)? onHovering;

  /// Called when the button is double-tapped.
  final void Function()? onDoubleTap;

  /// Called when the focus state changes.
  final void Function(bool isFocused)? onFocusChange;

  final void Function(bool isHighlighted)? onHighlightChanged;
  final void Function()? onSecondaryTap;
  final void Function()? onSecondaryTapCancel;
  final void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp;
  final void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown;

  // ────────────────────────────────────────
  // 🎨 Appearance & Layout
  // ────────────────────────────────────────

  final bool? useMaterial3;
  final bool? expanded;
  final bool? expandedIcon;
  final bool? enable;
  final bool? enableFeedback;
  final bool? autofocus;
  final bool? roundBorderWhenRunning;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? fontColor;
  final Color? focusColor;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final double? iconHeight;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final AlignmentGeometry? animationAlignment;
  final Duration? animationDuration;
  final Duration? statusShowingDuration;
  final MouseCursor? mouseCursor;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextHeightBehavior? textHeightBehavior;
  final int? textMaxLines;
  final bool? textWrap;
  final TextWidthBasis? textWidthBasis;
  final FocusNode? focusNode;
  final InteractiveInkFeatureFactory? splashFactory;

  // ────────────────────────────────────────
  // ✅ Status Widgets
  // ────────────────────────────────────────

  final Widget? onRunningWidget;
  final Widget? onSuccessWidget;
  final Widget? onErrorWidget;
  final bool? showRunningStatusWidget;

  /// Creates a copy of this theme data with the given fields replaced by new values.
  OnProcessButtonThemeData copyWith({
    void Function()? onLongPress,
    Function(int i)? onStatusChange,
    Future<bool?> Function()? onTap,
    Function(bool? isSuccess)? onDone,
    void Function(TapUpDetails tapUpDetails)? onTapUp,
    void Function(TapDownDetails tapDownDetails)? onTapDown,
    void Function()? onTapCancel,
    void Function(bool isEnter)? onHover,
    void Function(PointerHoverEvent offset)? onHovering,
    void Function()? onDoubleTap,
    void Function(bool isFocused)? onFocusChange,
    void Function(bool isHighlighted)? onHighlightChanged,
    void Function()? onSecondaryTap,
    void Function()? onSecondaryTapCancel,
    void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp,
    void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown,
    bool? useMaterial3,
    bool? expanded,
    bool? expandedIcon,
    bool? enable,
    bool? enableFeedback,
    bool? autofocus,
    bool? roundBorderWhenRunning,
    Color? backgroundColor,
    Color? iconColor,
    Color? fontColor,
    Color? focusColor,
    Color? splashColor,
    Color? highlightColor,
    Color? hoverColor,
    BorderRadius? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    double? width,
    double? height,
    double? iconHeight,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? contentPadding,
    BoxConstraints? constraints,
    AlignmentGeometry? alignment,
    AlignmentGeometry? animationAlignment,
    Duration? animationDuration,
    Duration? statusShowingDuration,
    MouseCursor? mouseCursor,
    TextStyle? textStyle,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    TextHeightBehavior? textHeightBehavior,
    int? textMaxLines,
    bool? textWrap,
    TextWidthBasis? textWidthBasis,
    FocusNode? focusNode,
    InteractiveInkFeatureFactory? splashFactory,
    Widget? onRunningWidget,
    Widget? onSuccessWidget,
    Widget? onErrorWidget,
    bool? showRunningStatusWidget,
  }) {
    return OnProcessButtonThemeData(
      onLongPress: onLongPress ?? this.onLongPress,
      onStatusChange: onStatusChange ?? this.onStatusChange,
      onTap: onTap ?? this.onTap,
      onDone: onDone ?? this.onDone,
      onTapUp: onTapUp ?? this.onTapUp,
      onTapDown: onTapDown ?? this.onTapDown,
      onTapCancel: onTapCancel ?? this.onTapCancel,
      onHover: onHover ?? this.onHover,
      onHovering: onHovering ?? this.onHovering,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      onFocusChange: onFocusChange ?? this.onFocusChange,
      onHighlightChanged: onHighlightChanged ?? this.onHighlightChanged,
      onSecondaryTap: onSecondaryTap ?? this.onSecondaryTap,
      onSecondaryTapCancel: onSecondaryTapCancel ?? this.onSecondaryTapCancel,
      onSecondaryTapUp: onSecondaryTapUp ?? this.onSecondaryTapUp,
      onSecondaryTapDown: onSecondaryTapDown ?? this.onSecondaryTapDown,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      expanded: expanded ?? this.expanded,
      expandedIcon: expandedIcon ?? this.expandedIcon,
      enable: enable ?? this.enable,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      autofocus: autofocus ?? this.autofocus,
      roundBorderWhenRunning: roundBorderWhenRunning ?? this.roundBorderWhenRunning,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      fontColor: fontColor ?? this.fontColor,
      focusColor: focusColor ?? this.focusColor,
      splashColor: splashColor ?? this.splashColor,
      highlightColor: highlightColor ?? this.highlightColor,
      hoverColor: hoverColor ?? this.hoverColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      width: width ?? this.width,
      height: height ?? this.height,
      iconHeight: iconHeight ?? this.iconHeight,
      margin: margin ?? this.margin,
      contentPadding: contentPadding ?? this.contentPadding,
      constraints: constraints ?? this.constraints,
      alignment: alignment ?? this.alignment,
      animationAlignment: animationAlignment ?? this.animationAlignment,
      animationDuration: animationDuration ?? this.animationDuration,
      statusShowingDuration: statusShowingDuration ?? this.statusShowingDuration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      textStyle: textStyle ?? this.textStyle,
      fontWeight: fontWeight ?? this.fontWeight,
      textAlign: textAlign ?? this.textAlign,
      textOverflow: textOverflow ?? this.textOverflow,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      textMaxLines: textMaxLines ?? this.textMaxLines,
      textWrap: textWrap ?? this.textWrap,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      focusNode: focusNode ?? this.focusNode,
      splashFactory: splashFactory ?? this.splashFactory,
      onRunningWidget: onRunningWidget ?? this.onRunningWidget,
      onSuccessWidget: onSuccessWidget ?? this.onSuccessWidget,
      onErrorWidget: onErrorWidget ?? this.onErrorWidget,
      showRunningStatusWidget: showRunningStatusWidget ?? this.showRunningStatusWidget,
    );
  }
}

/// An inherited widget that provides OnProcessButtonThemeData to its descendants.
class OnProcessButtonTheme extends InheritedWidget {
  const OnProcessButtonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final OnProcessButtonThemeData data;

  /// Returns the [OnProcessButtonThemeData] from the closest [OnProcessButtonTheme] ancestor.
  /// If there is no ancestor, it returns null.
  static OnProcessButtonThemeData? of(BuildContext context) {
    final OnProcessButtonTheme? theme = context.dependOnInheritedWidgetOfExactType<OnProcessButtonTheme>();
    return theme?.data;
  }

  @override
  bool updateShouldNotify(OnProcessButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// A convenience widget that provides OnProcessButtonThemeData to its descendants.
class OnProcessButtonThemeProvider extends StatelessWidget {
  const OnProcessButtonThemeProvider({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final OnProcessButtonThemeData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OnProcessButtonTheme(
      data: data,
      child: child,
    );
  }
}
