# OnProcessButtonWidget Example

Demonstrates all features of the `on_process_button_widget` package:

| # | Feature | Description |
|---|---|---|
| 1 | Basic filled button | Default style with hover callback |
| 2 | Success feedback | `onTap` returns `true` → shows `Icons.done` |
| 3 | Error feedback | `onTap` returns `false` → shows `Icons.error` |
| 4 | Double process | Chain operations via `onDone` callback |
| 5 | Shadow + icon color | Custom box shadow and icon styling |
| 6 | Custom status widgets | Replace default loading/success/error widgets |
| 7 | Card mode | Disabled button used as a styled card |
| 8 | Compact icon button | Small button returning `null` to skip status |
| 9 | Outlined style | Transparent background with colored border |

## Running the Example

```bash
cd example
flutter run
```
