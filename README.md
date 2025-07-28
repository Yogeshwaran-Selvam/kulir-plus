# 🌬️ KULIR+ – Smart AC Controller

A modern, modular Flutter app for controlling and scheduling AC units with a sleek UI, built using **Flutter**, **Provider**, **Lottie**, and **fl_chart**.

---

## 📱 Overview

KULIR+ offers an intuitive interface for managing AC units with scheduling, real-time controls, insights, and a glassmorphic login experience.

---

## 🎥 Demo

Watch a quick demo of KULIR+ in action:

![Preview](/demo.gif)

---

## 🧩 Screens & Features

### 🔧 `AcDetails` Screen
- Animated `PageView` with 4 tabs:
  1. **SchedulesView**: Manage AC schedules.
  2. **CoreControls**: Mode, temp, and power settings.
  3. **InsightsView**: Energy usage and trends.
  4. **MaintenanceControls**: Tips and service logs.
- Features: `Lottie` animations, `CurvedNavigationBar`, `Provider` power toggle, shimmer `nickname`.

### 🔌 `Add AC Page`
- Simulates adding ACs via:
  - Bluetooth simulation with Lottie feedback.
  - Room nickname input.
  - SVG room icons and Lottie animation selector.
- Stateful logic for connection and animation.

### 📅 `Add Scheduler`
- Components:
  - `DateInput`: Custom date picker.
  - `TimeInput`: `TimeOfDay` selector.
  - `ModeSelector`: Scrollable AC modes.
  - `ACSelectionWidget`: Multi-select ACs via `Provider`.
- Usage: Schedule AC automation with time, mode, and unit selection.

### 🔐 `LoginPage`
- Glassmorphic UI with login/register toggle.
- Features: Social logins (Google, Apple), `GlassTextField`, Lottie animation.
- Navigation: To splash screen via `AppRouter`.

### ⏳ `LoadingScreen`
- 2-second Lottie animation splash.
- Theme-aware (`AppLotties.loadingLottie`).
- Navigates to home screen.

### 🧭 `MenuBody`
- Scrollable profile menu with:
  - Lottie avatar, username, status.
  - Actions: Sign Out, Delete Account with dialogs.
  - Tiles: Help, Contact, About, Notifications.

### 📅 `Schedules Page`
- Features:
  - Draggable calendar panel (`DateSelector`, `CalendarWidget`).
  - Dynamic schedule list via `SchedulesListBuilder`.
  - Custom AppBar with Lottie icon.
- Providers: `SelectedItemProvider`, `ScheduleProvider`, `ThemeProvider`.

---

## 🛠 Tech Stack
- **State**: `Provider` + `Selector`.
- **UI Libs**: `flutter_animate`, `fl_chart`, `lottie`, `curved_navigation_bar`.
- **Custom Themes**: `AppTexts`, `AppCards`, `AppIcons`, `AppLotties`.

---

## 📌 Usage
- Control ACs (Cool, Eco, Turbo, Sleep modes).
- Schedule automation with date, time, and mode.
- Monitor energy usage and maintenance tips.
- Login/register with glassmorphic UI.

---

## 🧪 Status
✅ Production-ready UI, modular, smooth animations.

---

## 💡 Suggestions
- Refactor `PageView` widgets into method list.
- Add accessibility tooltips.
- Ensure dark/light theme contrast compliance.
- Integrate backend for schedule storage.

---

**Made with Flutter ❤️**
