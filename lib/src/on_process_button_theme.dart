part of '../on_process_button_widget.dart';

/// Theme data class that holds all the default values for OnProcessButtonWidget
class OnProcessButtonThemeData {
  /// Creates a new instance of [OnProcessButtonThemeData] with the provided
  /// values.
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
  /// - `1` = running
  /// - `2` = success
  /// - `-1` = error
  /// - `0` = stable
  final Function(int i)? onStatusChange;

  /// Called when the button is tapped.
  /// Should return `true` if operation is successful.
  final Future<bool?>? Function()? onTap;

  /// Called after [onTap] completes.
  /// `isSuccess` is true if the operation was successful, false otherwise.
  final Function(bool? isSuccess)? onDone;

  /// Called when a tap is released.
  final void Function(TapUpDetails tapUpDetails)? onTapUp;

  /// Called when a tap is initiated.
  final void Function(TapDownDetails tapDownDetails)? onTapDown;

  /// Called when a tap is canceled.
  final void Function()? onTapCancel;

  /// Called when the mouse pointer enters or exits the button.
  /// `isEnter` is true if the mouse pointer enters the button, false if it
  /// exits.
  final void Function(bool isEnter)? onHover;

  /// Called when the mouse pointer hovers over the button.
  final void Function(PointerHoverEvent offset)? onHovering;

  /// Called on a double tap.
  final void Function()? onDoubleTap;

  /// Called when the focus changes.
  /// `isFocused` is true if the button gains focus, false otherwise.
  final void Function(bool isFocused)? onFocusChange;

  /// Called when the highlight state changes.
  /// `isHighlighted` is true if the button is highlighted, false otherwise.
  final void Function(bool isHighlighted)? onHighlightChanged;

  /// Called on secondary (right) tap.
  final void Function()? onSecondaryTap;

  /// Called when a secondary tap is canceled.
  final void Function()? onSecondaryTapCancel;

  /// Called when a secondary tap is released.
  final void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp;

  /// Called when a secondary tap is initiated.
  final void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown;

  // ────────────────────────────────────────
  // 🎨 Appearance & Layout
  // ────────────────────────────────────────

  /// Whether to use Material 3 design.
  final bool? useMaterial3;

  /// Whether the button width should expand to fit its container.
  final bool? expanded;

  /// Whether the icon should expand during animations.
  final bool? expandedIcon;

  /// Whether the button is enabled. When false, the button will be disabled.
  final bool? enable;

  /// Whether to show visual feedback for interactions.
  final bool? enableFeedback;

  /// Whether the button should autofocus.
  final bool? autofocus;

  /// Whether the border should be rounded when loading.
  final bool? roundBorderWhenRunning;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The color of the status icons (e.g. loading, success).
  final Color? iconColor;

  /// The color of the button text.
  final Color? fontColor;

  /// The focus color of the button.
  final Color? focusColor;

  /// The splash color of the button.
  final Color? splashColor;

  /// The highlight color when the button is pressed.
  final Color? highlightColor;

  /// The color when the mouse hovers over the button.
  final Color? hoverColor;

  /// The border radius of the button.
  final BorderRadius? borderRadius;

  /// The border around the button.
  final BoxBorder? border;

  /// The shadow around the button.
  final List<BoxShadow>? boxShadow;

  /// The width of the button. Prefer using constraints instead.
  final double? width;

  /// The height of the button. Prefer using constraints instead.
  final double? height;

  /// The size of the status icon inside the button.
  final double? iconHeight;

  /// The outer margin of the button.
  final EdgeInsetsGeometry? margin;

  /// The inner padding around the content.
  final EdgeInsetsGeometry? contentPadding;

  /// The constraints for the button's size.
  final BoxConstraints? constraints;

  /// Alignment of the button's content.
  final AlignmentGeometry? alignment;

  /// Alignment for status animation.
  final AlignmentGeometry? animationAlignment;

  /// Duration of animation transitions.
  final Duration? animationDuration;

  /// Duration to show success/error indicator before resetting.
  final Duration? statusShowingDuration;

  /// The cursor to show when hovering.
  final MouseCursor? mouseCursor;

  /// The text style of the button label.
  final TextStyle? textStyle;

  /// The font weight of the button text.
  final FontWeight? fontWeight;

  /// Alignment of the button text.
  final TextAlign? textAlign;

  /// Overflow behavior of the button text.
  final TextOverflow? textOverflow;

  /// Line height behavior of the text.
  final TextHeightBehavior? textHeightBehavior;

  /// Max number of lines for the button text.
  final int? textMaxLines;

  /// Whether the text should wrap if it overflows.
  final bool? textWrap;

  /// Text width calculation strategy.
  final TextWidthBasis? textWidthBasis;

  /// Focus node for managing keyboard focus.
  final FocusNode? focusNode;

  /// The ink splash factory used by the button.
  final InteractiveInkFeatureFactory? splashFactory;

  // ────────────────────────────────────────
  // ✅ Status Widgets
  // ────────────────────────────────────────

  /// Custom widget shown when the button is loading.
  final Widget? onRunningWidget;

  /// Custom widget shown when the action is successful.
  final Widget? onSuccessWidget;

  /// Custom widget shown when the action fails.
  final Widget? onErrorWidget;

  /// Whether to show the running status widget.
  /// Default is `true`.
  final bool? showRunningStatusWidget;

  /// Creates a copy of this theme data with the given fields replaced by new
  /// values.
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
      roundBorderWhenRunning:
          roundBorderWhenRunning ?? this.roundBorderWhenRunning,
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
      statusShowingDuration:
          statusShowingDuration ?? this.statusShowingDuration,
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
      showRunningStatusWidget:
          showRunningStatusWidget ?? this.showRunningStatusWidget,
    );
  }
}

/// An inherited widget that provides OnProcessButtonThemeData to its
/// descendants.
class OnProcessButtonTheme extends InheritedWidget {
  /// Creates a new instance of [OnProcessButtonTheme] with the provided
  /// theme data.
  /// The [child] widget is the subtree that will have access to this theme.
  const OnProcessButtonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// The theme data for OnProcessButtonWidget.
  /// This holds all the default values for the button's appearance and
  /// behavior.
  /// It can be overridden by providing a custom [OnProcessButtonThemeData]
  /// when using [OnProcessButtonThemeProvider].
  /// It is immutable and should be created using the
  /// [OnProcessButtonThemeData] constructor
  final OnProcessButtonThemeData data;

  /// Returns the [OnProcessButtonThemeData] from the closest
  /// [OnProcessButtonTheme] ancestor.
  /// If there is no ancestor, it returns null.
  static OnProcessButtonThemeData? of(BuildContext context) {
    final OnProcessButtonTheme? theme =
        context.dependOnInheritedWidgetOfExactType<OnProcessButtonTheme>();
    return theme?.data;
  }

  @override
  bool updateShouldNotify(OnProcessButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// A convenience widget that provides OnProcessButtonThemeData to its
/// descendants.
class OnProcessButtonThemeProvider extends StatelessWidget {
  /// Creates a new instance of [OnProcessButtonThemeProvider] with themeData
  const OnProcessButtonThemeProvider({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  /// The theme data for OnProcessButtonWidget.
  /// This holds all the default values for the button's appearance and
  /// behavior.
  /// It can be overridden by providing a custom [OnProcessButtonThemeData]
  /// when using [OnProcessButtonThemeProvider].
  /// It is immutable and should be created using the
  /// [OnProcessButtonThemeData] constructor
  ///
  /// The [child] widget is the subtree that will have access to this theme.
  /// It should be a widget that uses [OnProcessButtonWidget] or its
  /// descendants.
  final OnProcessButtonThemeData data;

  /// The child widget that will have access to this theme.
  /// This should be a widget that uses [OnProcessButtonWidget] or its
  /// descendants.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OnProcessButtonTheme(
      data: data,
      child: child,
    );
  }
}
