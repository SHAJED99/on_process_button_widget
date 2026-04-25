# OnProcessButtonWidget

📦 A powerful Flutter button widget with loading states, hover effects, and request status handling.

[![Pub Version](https://img.shields.io/pub/v/on_process_button_widget?style=flat-square)](https://pub.dev/packages/on_process_button_widget)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?style=flat-square)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue?style=flat-square)](https://dart.dev)
[![License](https://img.shields.io/badge/License-BSD--3-blue?style=flat-square)](LICENSE)

---

## ✨ Features

- ⏳ **Loading States** — Built-in loading indicator during async operations
- 🖱️ **Hover Effects** — Mouse hover text/animation changes
- ✅❌ **Request Status** — Handle success/failure states visually
- 🔄 **Double Process** — Two-step confirmation flows
- 🎨 **Material 3** — Native Material 3 theming support
- 📐 **Button-Matched Height** — Matches `OnTextInputWidget` for cohesive forms

---

## 🚀 Installation

```yaml
dependencies:
  on_process_button_widget: ^latest
```

```dart
import 'package:on_process_button_widget/on_process_button_widget.dart';
```

---

## 🎯 Quick Start

```dart
OnProcessButtonWidget(
  onTap: () async {
    // Handle button press
    await fetchData();
  },
  child: Text("Submit"),
)
```

---

## 📱 Demo

| Loading | Status | Hover |
|---------|--------|-------|
| ![All](https://raw.githubusercontent.com/SHAJED99/on_process_button_widget/main/screenshots/all.gif) | ![Status](https://raw.githubusercontent.com/SHAJED99/on_process_button_widget/main/screenshots/status.gif) | ![Hover](https://raw.githubusercontent.com/SHAJED99/on_process_button_widget/main/screenshots/hover.gif) |

---

## 💡 Usage Examples

### Loading State with Hover Text

```dart
OnProcessButtonWidget(
  backgroundColor: Color(0XFF86A789),
  onTap: () async => await onCallFunction(),
  onHover: (isEnter) => buttonText.value = 
    isEnter ? "Hi" : "Hover Here",
  child: Text(buttonText.value),
)
```

### Request Status (Success/Failure)

```dart
OnProcessButtonWidget(
  backgroundColor: Color(0XFF739072),
  onTap: () async => await onCallFunction(type: true), // success
  child: Text("Success State"),
)

OnProcessButtonWidget(
  backgroundColor: Color(0XFF739072),
  onTap: () async => await onCallFunction(type: false), // failure
  child: Text("Error State"),
)
```

### With Form Validation

```dart
OnProcessButtonWidget(
  onDone: (isSuccess) {
    _formKey.currentState?.validate();
  },
  child: Text("Validate & Submit"),
)
```

---

## 🛠️ Configuration Options

| Property | Type | Description |
|----------|------|-------------|
| `onTap` | `Future<void> Function()?` | Async tap handler |
| `onHover` | `void Function(bool)?` | Hover enter/exit callback |
| `backgroundColor` | `Color?` | Button background |
| `onDone` | `void Function(bool)?` | Completion callback |
| `child` | `Widget?` | Button content |

---

## 📦 Related Packages

| Package | Description |
|---------|-------------|
| [`on_text_input_widget`](https://github.com/SHAJED99/on_text_input_widget) | Text input with search & validation |
| [`on_popup_window_widget`](https://github.com/SHAJED99/on_popup_window_widget) | Popup dialog widget |
| [`time_range_selector_widget`](https://github.com/SHAJED99/time_range_selector_widget) | Time range picker |

---

## 🤝 Contributing

Contributions welcome! Open an issue or submit a PR.

## 📄 License

BSD 3-Clause License — see [LICENSE](LICENSE)