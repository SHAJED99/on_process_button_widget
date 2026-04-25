# ⚡ OnProcessButtonWidget

> A sleek, production-ready Flutter button widget with built-in loading states, progress indicators, and tap feedback.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Pub](https://img.shields.io/badge/Pub-1.0.0-blue?style=flat-square)

📦 **Ready for pub.dev!** Drop-in replacement for Flutter's `ElevatedButton`, `OutlinedButton`, and `TextButton` with superpowers.

---

## ✨ Features

- ⏳ **Loading State** — Built-in circular progress indicator, disables button while loading
- 🎨 **Customizable** — Colors, radius, elevation, borders, icons, shadows
- 🚫 **Disabled State** — Auto-disabled during loading with configurable opacity
- 🔄 **Loading Text** — Swap label with "Processing..." while loading
- 🎯 **Ripple Effect** — Material ripple on tap
- 💫 **Scale Animation** — Shrinks slightly on press for tactile feedback
- 📱 **Platform Ready** — Android, iOS, Web, macOS, Windows, Linux

---

## 📦 Installation

```bash
flutter pub add on_process_button_widget
```

Or add manually to `pubspec.yaml`:

```yaml
dependencies:
  on_process_button_widget: ^1.0.0
```

---

## 🚀 Quick Start

```dart
import 'package:on_process_button_widget/on_process_button_widget.dart';

// Basic usage — just wrap your async action
OnProcessButton(
  onPressed: () async {
    await Future.delayed(Duration(seconds: 2));
    print('Action complete!');
  },
  child: Text('Submit'),
)

// With custom text during loading
OnProcessButton(
  loadingText: 'Submitting...',
  child: Text('Submit'),
  onPressed: () => submitForm(),
)

// With icon
OnProcessButton.icon(
  icon: Icons.send,
  label: 'Send',
  onPressed: () => sendMessage(),
)
```

---

## 🎛️ Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onPressed` | `AsyncCallback?` | `required` | Async press handler |
| `child` | `Widget` | `required` | Button content |
| `loadingText` | `String?` | `null` | Text shown while loading |
| `loadingColor` | `Color` | `Colors.white` | Spinner color |
| `loadingSize` | `double` | `20.0` | Spinner diameter |
| `borderRadius` | `double` | `8.0` | Button radius |
| `backgroundColor` | `Color` | `null` | Button background |
| `foregroundColor` | `Color` | `null` | Text/icon color |
| `elevation` | `double` | `2.0` | Shadow elevation |
| `enabled` | `bool` | `true` | Enable/disable |
| `height` | `double` | `48.0` | Button height |
| `width` | `double` | `null` | Button width (full if null) |

---

## 🎨 Customization Examples

### Primary Button (Full Width)
```dart
OnProcessButton(
  width: double.infinity,
  backgroundColor: Color(0xFF6C63FF),
  borderRadius: 12,
  child: Text(
    'Sign In',
    style: TextStyle(color: Colors.white, fontSize: 16),
  ),
  onPressed: () => signIn(),
)
```

### Outlined Style
```dart
OnProcessButton(
  backgroundColor: Colors.transparent,
  foregroundColor: Color(0xFF6C63FF),
  border: Border.all(color: Color(0xFF6C63FF), width: 2),
  borderRadius: 12,
  child: Text('View Details'),
  onPressed: () => openDetails(),
)
```

### Icon Button (Circular)
```dart
OnProcessButton.icon(
  width: 56,
  height: 56,
  borderRadius: 28,
  backgroundColor: Color(0xFF2196F3),
  icon: Icons.favorite,
  loadingIcon: Icons.favorite_border,
  onPressed: () => toggleLike(),
)
```

### Upload Button with Progress
```dart
OnProcessButton(
  icon: Icons.cloud_upload,
  label: 'Upload Document',
  loadingLabel: 'Uploading...',
  backgroundColor: Color(0xFF4CAF50),
  borderRadius: 8,
  onPressed: () => uploadFile(),
)
```

---

## 📸 Screenshots

| Default | Loading | Disabled |
|---------|---------|----------|
| ![Default](screenshots/default.png) | ![Loading](screenshots/loading.png) | ![Disabled](screenshots/disabled.png) |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

---

## 📄 License

```
MIT License
Copyright (c) 2024 Shajedur Rahman Panna
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/SHAJED99">Shajedur Rahman Panna</a>
</p>
