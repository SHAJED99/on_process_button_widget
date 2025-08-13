part of '../on_process_button_widget.dart';

/// An enumeration representing the status of the OnProcessButton.
/// - `stable`: The button is in a stable state.
/// - `running`: The button is currently processing an action.
/// - `success`: The action was successful.
/// - `error`: The action encountered an error.
/// This enum is used to manage the state of the button and trigger appropriate
/// callbacks based on the button's status.
/// It is part of the [OnProcessButtonWidget] configuration.
enum OnProcessButtonStatus {
  /// The button is in a stable state.
  stable,

  /// The button is currently processing an action.
  running,

  /// The action was successful.
  success,

  /// The action encountered an error.
  error,
}
