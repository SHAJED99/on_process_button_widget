part of '../on_process_button_widget.dart';

/// A configuration class that allows setting default values
/// for the [OnProcessButtonWidget] properties.
class OnProcessButtonDefaultValues {
  // ────────────────────────────────────────
  // 🧩 Callback Functions
  // ────────────────────────────────────────

  /// Called when the button is long-pressed.
  static void Function()? onLongPress;

  /// Called when the button status changes.
  /// - `1` = running
  /// - `2` = success
  /// - `-1` = error
  /// - `0` = stable
  static Function(int i)? onStatusChange;

  /// Called when the button is tapped.
  /// Should return `true` if operation is successful.
  static Future<bool?> Function()? onTap;

  /// Called after [onTap] completes.
  static Function(bool? isSuccess)? onDone;

  /// Called when a tap is released.
  static void Function(TapUpDetails tapUpDetails)? onTapUp;

  /// Called when a tap is initiated.
  static void Function(TapDownDetails tapDownDetails)? onTapDown;

  /// Called when a tap is canceled.
  static void Function()? onTapCancel;

  /// Called when the mouse pointer enters or exits the button.
  static void Function(bool isEnter)? onHover;

  /// Called when the mouse pointer hovers over the button.
  static void Function(PointerHoverEvent offset)? onHovering;

  /// Called on a double tap.
  static void Function()? onDoubleTap;

  /// Called when the focus changes.
  static void Function(bool isFocused)? onFocusChange;

  /// Called when the highlight state changes.
  static void Function(bool isHighlighted)? onHighlightChanged;

  /// Called on secondary (right) tap.
  static void Function()? onSecondaryTap;

  /// Called when a secondary tap is canceled.
  static void Function()? onSecondaryTapCancel;

  /// Called when a secondary tap is released.
  static void Function(TapUpDetails tapUpDetails)? onSecondaryTapUp;

  /// Called when a secondary tap is initiated.
  static void Function(TapDownDetails tapDownDetails)? onSecondaryTapDown;

  // ────────────────────────────────────────
  // 🎨 Appearance & Layout
  // ────────────────────────────────────────

  /// Whether to use Material 3 design.
  static bool? useMaterial3;

  /// Whether the button width should expand to fit its container.
  static bool? expanded;

  /// Whether the icon should expand during animations.
  static bool? expandedIcon;

  /// Whether the button is enabled.
  static bool? enable; // TODO: End here

  /// Whether to show visual feedback for interactions.
  static bool? enableFeedback;

  /// Whether the button should autofocus.
  static bool? autofocus;

  /// Whether the border should be rounded when loading.
  static bool? roundBorderWhenRunning;

  /// The background color of the button.
  static Color? backgroundColor;

  /// The color of the status icons (e.g. loading, success).
  static Color? iconColor;

  /// The color of the button text.
  static Color? fontColor;

  /// The focus color of the button.
  static Color? focusColor;

  /// The splash color of the button.
  static Color? splashColor;

  /// The highlight color when the button is pressed.
  static Color? highlightColor;

  /// The color when the mouse hovers over the button.
  static Color? hoverColor;

  /// The border radius of the button.
  static BorderRadius? borderRadius;

  /// The border around the button.
  static BoxBorder? border;

  /// The shadow around the button.
  static List<BoxShadow>? boxShadow; //

  /// The width of the button.
  static double? width;

  /// The height of the button.
  static double? height;

  /// The size of the status icon inside the button.
  static double? iconHeight;

  /// The outer margin of the button.
  static EdgeInsetsGeometry? margin;

  /// The inner padding around the content.
  static EdgeInsetsGeometry? contentPadding;

  /// The constraints for the button's size.
  static BoxConstraints? constraints;

  /// Alignment of the button's content.
  static AlignmentGeometry? alignment;

  /// Alignment for status animation.
  static AlignmentGeometry? animationAlignment;

  /// Duration of animation transitions.
  static Duration? animationDuration;

  /// Duration to show success/error indicator before resetting.
  static Duration? statusShowingDuration;

  /// The cursor to show when hovering.
  static MouseCursor? mouseCursor;

  /// The text style of the button label.
  static TextStyle? textStyle;

  /// The font weight of the button text.
  static FontWeight? fontWeight;

  /// Alignment of the button text.
  static TextAlign? textAlign;

  /// Overflow behavior of the button text.
  static TextOverflow? textOverflow;

  /// Line height behavior of the text.
  static TextHeightBehavior? textHeightBehavior;

  /// Max number of lines for the button text.
  static int? textMaxLines;

  /// Whether the text should wrap if it overflows.
  static bool? textWrap;

  /// Text width calculation strategy.
  static TextWidthBasis? textWidthBasis;

  /// Focus node for managing keyboard focus.
  static FocusNode? focusNode;

  /// The ink splash factory used by the button.
  static InteractiveInkFeatureFactory? splashFactory;

  // ────────────────────────────────────────
  // ✅ Status Widgets
  // ────────────────────────────────────────

  /// Custom widget shown when the button is loading.
  static Widget? onRunningWidget;

  /// Custom widget shown when the action is successful.
  static Widget? onSuccessWidget;

  /// Custom widget shown when the action fails.
  static Widget? onErrorWidget;

  /// Whether to show the running status widget.
  /// Default is `true`.
  static bool? showRunningStatusWidget;
}
