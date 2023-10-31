# On Process Button Widget

A button with many functionalities


## Getting Started

To use the `TimeRangeSelectorWidget` widget in your project, follow these steps:

1. Install the widget according to the instructions on the install page

2. Add this code in your project
```dart
    OnProcessButtonWidget()
```

## Customizing the button

### Hovering effect

```dart
    //! Hovering effect && On processing loading indicator
    OnProcessButtonWidget(
        backgroundColor: const Color(0XFF86A789),
        onTap: () async => await onCallFunction(),
        onHover: (isEnter) => buttonText.value = isEnter ? "Hi" : "Hover Here - Only works in Mouse hovering.",
        child: Text(buttonText.value),
    ),
```

### Example - Hovering effect && On processing loading indicator