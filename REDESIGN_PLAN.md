# Karing UI Redesign Plan — Comprehensive Report

**Generated:** 2026-06-17
**Project:** Karing v1.2.20+2304 (Flutter 3.35+, Dart 3.9+)
**Location:** `/root/karing`
**Total Dart files in lib/:** 147
**Total Dart files in screens/:** 50
**Total widget files in screens/widgets/:** 22

---

## 1. ALL SCREENS — Inventory

### 1.1 Main Screens (>500 lines)

| Lines | File | Route Name | Purpose |
|-------|------|------------|---------|
| 3673 | `group_helper.dart` | N/A (utility) | Central settings definitions — groups all `GroupItem` configs for settings/profiles |
| 3258 | `settings_screen.dart` | — | Main settings screen with grouped cards |
| 2868 | `home_screen.dart` | `/` | Main home screen — connection button, server cards, widget grid |
| 2588 | `home_screen_widgets.dart` | N/A | Reusable home screen widgets (SwitchCard, ServerSelectCard, etc.) |
| 2377 | `antdesign.dart` | N/A | Font icon definitions (~1400 AntDesign icons as IconData) |
| 1858 | `server_select_screen.dart` | — | Server/proxy selection screen with search, grouping, URL test |
| 1798 | `my_profiles_screen.dart` | — | Subscription/profile management — list, add, edit, reorder, merge profiles |
| 1608 | `net_connections_screen.dart` | — | Active network connections monitor (real-time table, sortable) |
| 1439 | `diversion_group_custom_edit_screen.dart` | — | Edit custom traffic diversion groups |
| 1116 | `net_check_screen.dart` | — | Network connectivity diagnostics/check screen |
| 836 | `inapp_webview_screen.dart` | `InAppWebViewScreen:*` | Embedded webview for FAQ, web content |
| 774 | `dialog_utils.dart` | N/A (utility) | Common dialog helpers (alerts, confirmations, FAQ) |
| 751 | `diversion_rules_screen.dart` | — | Traffic diversion rules management |
| 683 | `group_item_widgets.dart` | N/A | Settings item widgets (text, switch, dropdown, textfield, date/time, color) |
| 637 | `diversion_group_custom_screen.dart` | — | Custom diversion group list |
| 626 | `dns_settings_screen.dart` | — | DNS server configuration |
| 622 | `home_tvos_screen.dart` | — | Apple TV-optimized variant of home screen |
| 622 | `add_profile_by_link_or_content_screen.dart` | — | Add subscription via URL or paste content |
| 608 | `backup_and_sync_webdav_screen.dart` | — | WebDAV backup & sync settings |
| 601 | `about_screen.dart` | `AboutScreen` | App info, version, licenses |
| 595 | `add_profile_by_scan_qrcode_screen.dart` | — | QR code scanner for profile import |
| 552 | `perapp_android_screen.dart` | — | Per-app VPN routing (Android) |
| 505 | `perapp_macos_screen.dart` | — | Per-app VPN routing (macOS) |
| 494 | `dns_auto_setup_screen.dart` | — | Automatic DNS configuration |
| 478 | `diversion_rule_detect_screen.dart` | — | Rule detection for diversions |
| 474 | `my_profiles_edit_screen.dart` | — | Edit individual profile settings |
| 443 | `file_content_viewer_screen.dart` | — | File content viewer/editor |
| 435 | `packageid_multi_select_android_screen.dart` | — | Multi-select package IDs (Android) |
| 381 | `backup_and_sync_icloud_screen.dart` | — | iCloud backup & sync |
| 374 | `backup_and_sync_lan_sync_screen.dart` | — | LAN sync backup |
| 373 | `region_settings_screen.dart` | — | Region/country selection with flags |
| 367 | `net_connections_filter_screen.dart` | — | Filter for connections screen |
| 339 | `add_profile_by_import_from_file_screen.dart` | — | Import profile from local file |
| 329 | `urltest_group_custom_screen.dart` | — | Custom URL test group |
| 297 | `uwp_loopback_exemption_windows_screen.dart` | — | Windows UWP loopback exemption |
| 294 | `backup_and_sync_auto_backup_screen.dart` | — | Auto backup settings |
| 288 | `my_profiles_merge_screen.dart` | — | Merge multiple profiles |
| 288 | `cloudflare_warp_account_screen.dart` | — | Cloudflare WARP account management |
| 282 | `language_settings_screen.dart` | — | Language/locale selection |
| 276 | `server_select_keywords_screen.dart` | — | Keyword-based server filtering |
| 274 | `file_view_screen.dart` | — | File browser for profiles |
| 269 | `scheme_handler.dart` | N/A (utility) | Deep link / URL scheme handler (`karing://` protocol) |
| 268 | `group_screen.dart` | `GroupScreen:*` | Generic reusable settings screen (card groups) |
| 255 | `multi_select_screen.dart` | — | Generic multi-select screen |
| 254 | `diversion_rules_custom_set_screen.dart` | — | Custom diversion rule sets |
| 253 | `map_string_and_string_add_screen.dart` | — | Add key-value pair screen |
| 250 | `qrcode_screen.dart` | — | QR code display screen |
| 240 | `version_update_screen.dart` | — | Version update screen |
| 235 | `map_string_and_list_add_screen.dart` | — | Add key-list pair screen |
| 228 | `speedtest_settings_screen.dart` | — | Speed test configuration |
| 227 | `qrcode_scan_screen.dart` | — | QR code scanner camera |
| 226 | `urltest_settings_screen.dart` | — | URL test configuration |
| 224 | `webview_isp_helper.dart` | N/A | WebView helper for ISP configs |
| 221 | `list_add_screen.dart` | — | Generic list item add screen |

### 1.2 Utility / Support Files (not screens, but critical)

| Lines | File | Purpose |
|-------|------|---------|
| 683 | `group_item_widgets.dart` | Settings row widgets (text, switch, dropdown, textfield, date, time, color picker) |
| 622 | `group_helper.dart` | Central config definitions for all settings screens |
| 269 | `scheme_handler.dart` | Deep link / protocol handler |
| 2377 | `antdesign.dart` | Icon font (~1400 icons) |
| 268 | `group_screen.dart` | Generic reusable settings screen wrapper |

---

## 2. NAVIGATION STRUCTURE

### 2.1 No Bottom Navigation Bar
Karing does **NOT** use `BottomNavigationBar` or `ConvexBottomBar` for navigation. The app is a **single-screen architecture** with modal pushes.

### 2.2 Entry Point
```
main.dart → MaterialApp → HomeScreen (route: "/")
```

### 2.3 Navigation Pattern
- **Primary:** `Navigator.push()` / `Navigator.pushNamed()` — all screens are pushed modally on top of `HomeScreen`
- **HomeScreen** is the root and only persistent screen
- Navigation between settings is via `Navigator.push()` from `SettingsScreen`
- Back button pops to previous screen
- On Android/iOS, back button sends app to background (`MoveToBackgroundUtils`)

### 2.4 Key Navigation Flows
```
HomeScreen
├── SettingsScreen (push)
│   ├── MyProfilesScreen (push)
│   │   ├── MyProfilesEditScreen (push)
│   │   ├── MyProfilesMergeScreen (push)
│   │   └── AddProfileByLinkOrContentScreen (push)
│   ├── DiversionRulesScreen (push)
│   │   ├── DiversionGroupCustomScreen (push)
│   │   │   └── DiversionGroupCustomEditScreen (push)
│   │   └── DiversionRulesCustomSetScreen (push)
│   ├── DnsSettingsScreen (push)
│   ├── DnsAutoSetupScreen (push)
│   ├── NetCheckScreen (push)
│   ├── RegionSettingsScreen (push)
│   ├── LanguageSettingsScreen (push)
│   ├── SpeedtestSettingsScreen (push)
│   ├── UrltestSettingsScreen (push)
│   ├── UseragentSettingsScreen (push)
│   ├── BackupAndSyncWebdavScreen (push)
│   ├── BackupAndSyncIcloudScreen (push)
│   ├── BackupAndSyncLanSyncScreen (push)
│   ├── BackupAndSyncAutoBackupScreen (push)
│   ├── PerAppAndroidScreen (push)
│   ├── PerAppMacosScreen (push)
│   ├── NetConnectionsScreen (push)
│   │   └── NetConnectionsFilterScreen (push)
│   ├── AboutScreen (push)
│   └── ServerSelectScreen (push)
├── ServerSelectScreen (push, from ConvexButton2)
├── NetConnectionsScreen (push)
├── QrcodeScreen (push)
├── QrcodeScanScreen (push)
├── FileContentViewerScreen (push)
├── FileViewScreen (push)
├── InAppWebViewScreen (push)
├── VersionUpdateScreen (push)
└── UserAgreementScreen (push, first launch)
```

### 2.5 Deep Link / Scheme Handler
`scheme_handler.dart` handles `karing://` URLs:
- `karing://install-config?url=...` — import profile
- `karing://connect?background=false` — connect VPN
- `karing://disconnect` — disconnect
- `karing://reconnect` — reconnect

---

## 3. HOME SCREEN STRUCTURE

### 3.1 Layout (Top to Bottom)

```
Scaffold
├── AppBar (hidden, size.zero)
└── Container (full-screen, optional background decoration)
    └── SafeArea
        └── Column
            ├── Top Bar Row (~50px)
            │   ├── Settings icon (left) — with notification dot for updates/notices
            │   ├── Spacer
            │   ├── When in EDIT mode: Add / Import / Export / Done icons
            │   └── Settings icon (right)
            │
            ├── SizedBox(height: 20)
            │
            ├── Expanded — Widget Grid Area
            │   └── SingleChildScrollView
            │       └── Column
            │           ├── SuperGrid (edit mode — drag & drop) OR Grid (view mode)
            │           │   └── Widget cards:
            │           │       ├── SwitchCard — VPN toggle button (large, circular)
            │           │       ├── ServerSelectCard — currently selected server
            │           │       ├── TrafficWidget — upload/download speeds
            │           │       ├── ConnectionsInfoCard — active connections count
            │           │       ├── RuntimeInfoCard — app uptime
            │           │       ├── MemoryInfoCard — memory usage
            │           │       └── ProfileSubTrafficCard — subscription traffic usage
            │           └── SizedBox(height: convexIconSize) — padding for FAB
            │
            └── Bottom: ConvexButton2.fab2 (Connection Button)
                └── 80x80px round button
                    ├── Green when connected
                    ├── Red when disconnected
                    └── Contains ServerSelectCard child (server info)
```

### 3.2 Widget Types on Home Screen

| Widget | Description |
|--------|-------------|
| `SwitchCard` | Abstract circular toggle button — VPN on/off |
| `ServerSelectCard` | Shows selected server name, flag, latency — tappable to open server list |
| `TrafficWidget` | Real-time upload/download speed display |
| `ConnectionsInfoCard` | Shows active connection count |
| `RuntimeInfoCard` | Shows how long VPN has been active |
| `MemoryInfoCard` | Shows memory usage |
| `ProfileSubTrafficCard` | Subscription data usage |
| `HomeWidgetCard1Options` | Base class for info card widgets |

### 3.3 Home Screen Features
- **Customizable widget grid** — Users can add/remove/reorder widgets via edit mode
- **Drag & drop** — `SuperGrid` for reordering widgets in edit mode
- **Widget import/export** — Grid configurations can be shared
- **Background decoration** — Optional image/gradient background
- **Notification dots** — Red dot on settings icon for updates/notices
- **TV mode** — `home_tvos_screen.dart` — Apple TV optimized variant
- **Responsive columns** — Grid auto-calculates columns based on screen width

---

## 4. SETTINGS — Groups & Structure

### 4.1 SettingsScreen (`settings_screen.dart`, 3258 lines)
Uses `GroupItemCreator` pattern — all settings are `GroupItem` lists rendered as cards.

**Top bar:** Back button + "Setting" title (iOS-style navigation bar)

**Settings Groups (from `group_helper.dart`):**
The settings definition is centralized in `group_helper.dart` (3673 lines). It dynamically builds `GroupItem` lists.

**Typical settings screen structure:**
```
Scaffold → SafeArea → Column
├── Top bar (back + title)
└── SingleChildScrollView
    └── Column of Card widgets
        └── Each Card contains rows of:
            ├── GroupItemText (text row with optional tap)
            ├── GroupItemSwitch (toggle)
            ├── GroupItemDropdown (selection)
            ├── GroupItemTextField (text input)
            ├── GroupItemDateTime (date/time picker)
            ├── GroupItemColor (color picker)
            └── GroupItemTips (tips/info text)
```

### 4.2 Settings Categories

**Connection/Proxy:**
- Server selection, URL test config, speed test config
- Traffic diversion rules (DNS-based, domain-based, IP-based)
- Per-app VPN routing (Android/macOS)
- DNS settings (manual, auto-setup)

**Profiles/Subscriptions:**
- My Profiles (list, edit, merge, reorder)
- Add via link/URL, QR code, file import
- Auto-update subscriptions

**Backup & Sync:**
- WebDAV
- iCloud (iOS/macOS)
- LAN Sync
- Auto Backup

**UI/Appearance:**
- Theme (system/light/dark)
- Language/region
- Language selection
- Region selection

**System:**
- User-Agent settings
- Windows UWP loopback exemption
- Net check / diagnostics

**About:**
- Version info, licenses, log export

---

## 5. CUSTOM WIDGETS (`screens/widgets/`)

### 5.1 Complete Widget Inventory

| Lines | File | Widget | Purpose |
|-------|------|--------|---------|
| 1132 | `tab.dart` | `CommonTabBar<T>` | Custom segmented control with spring animations, replaces iOS SegmentedControl |
| 715 | `super_grid.dart` | `SuperGrid` | Draggable grid layout with auto-scroll, used for home screen widget reordering |
| 410 | `grid.dart` | `Grid` | Custom grid layout (MultiChildRenderObjectWidget) with configurable columns/spacing |
| 315 | `text_field.dart` | `TextFieldEx` | Extended TextField with popup editing mode |
| 253 | `card.dart` | `InfoHeader` | Card header with label, icon, tooltip, and actions |
| 157 | `fab2.dart` | `ConvexButton2` | Custom FAB button (convex shape), used for main connect button on home screen |
| 154 | `multi_checkbox.dart` | `MultiCheckBox` | Multi-select checkboxes with expand/collapse |
| 150 | `fade_box.dart` | `FadeBox`, `FadeThroughBox`, `FadeScaleBox` | Transition wrappers (fade, fade-through, fade-scale) using `animations` package |
| 122 | `sheet.dart` | `showSheet()`, `AdaptiveSheetScaffold` | Modal bottom sheet helpers |
| 118 | `color.dart` | `ColorExtension` | Color utility extensions (opacity helpers, lighten, darken) |
| 117 | `framework.dart` | `LasyRenderingStatefulWidget`, `LasyRenderingState` | Base class for lazy-rendering widgets (performance optimization) |
| 110 | `map.dart` | `IterableExt`, `ListExt` | Collection utility extensions (separated, chunks, fill, takeLast, batch, etc.) |
| 99 | `text.dart` | `TooltipText`, `EmojiText` | Text with tooltip, Emoji-aware text rendering |
| 87 | `routes.dart` | `AppRouteObserver` | Route observer for screen change callbacks |
| 86 | `measure.dart` | `Measure` | Text size measurement with caching |
| 77 | `function.dart` | `Debouncer`, `Throttler`, `retry()` | Utility functions for debounce, throttle, retry |
| 57 | `num.dart` | `NumExt`, `DoubleExt`, `OffsetExt`, `RectExt` | Math/geometry extensions |
| 54 | `dropdown.dart` | `DropdownButtonEx` | Custom dropdown button |
| 52 | `constant.dart` | Constants | App-wide constants (padding, durations, sizes, text scale limits) |
| 48 | `enum.dart` | `ChipType`, `CommonCardType`, `KeyboardModifier`, `FontFamily` | Enum definitions for UI types |
| 38 | `rotation.dart` | `Rotation` | Continuous rotation animation (loading spinner) |
| 13 | `activate_box.dart` | `ActivateBox` | Wrapper that disables child interaction when `active=false` |

### 5.2 Key Design Patterns

**Lazy Rendering (`LasyRenderingState`):**
Custom lifecycle that skips frame rendering when app is in background/paused state. Used by all screen state classes extending `LasyRenderingState`.

**Group-based Settings Architecture:**
All settings use a declarative `GroupItem` system:
```dart
GroupItem(
  name: "Group Name",  // Optional section header
  options: [
    GroupItemSwitch(name: "Enable X", onChanged: ...),
    GroupItemDropdown(name: "Mode", items: ..., onChanged: ...),
    GroupItemText(name: "Server", text: currentValue, onPush: openSubScreen),
    GroupItemTextField(name: "Port", ...),
  ]
)
```

**Modal Bottom Sheets:**
`showSheet()` / `showSheetWithBuilder()` used for quick selections and popups.

---

## 6. DEPENDENCIES — UI Related

### 6.1 Core UI Packages

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | 3.35+ | Framework |
| `cupertino_icons` | 1.0.9 | iOS-style icons |
| `animations` | 2.2.0 | Pre-built animations (FadeTransition, FadeThroughTransition) |
| `convex_bottom_bar` | 3.2.0 | Convex app bar (used for connect button) |

### 6.2 Layout & Responsive

| Package | Version | Purpose |
|---------|---------|---------|
| `extended_wrap` | 0.1.5 | Extended Wrap widget (used in MultiCheckBox) |
| `defer_pointer` | 0.0.2 | DeferPointer (used in SuperGrid for drag) |
| `infinite_scroll_pagination` | 5.1.1 | Infinite scroll with pagination |
| `scrollview_observer` | 1.26.3 | ScrollView observer |

### 6.3 Icons & Images

| Package | Version | Purpose |
|---------|---------|---------|
| `antdesign.dart` (custom) | — | ~1400 AntDesign icons as custom font |
| `flutter_emoji` | 2.5.1 | Emoji support |
| `emoji_regex` | 0.0.5 | Emoji regex for text parsing |
| `dash_flags` | 0.1.1 | Country flag icons |
| `fast_cached_network_image` | 1.3.3+5 | Cached network images (server flags) |
| `image` | 4.8.0 | Image processing |

### 6.4 Charts & Data Display

| Package | Version | Purpose |
|---------|---------|---------|
| `fl_chart` | 1.2.0 | Charts (traffic graphs) |
| `data_table_2` | 2.7.2 | Data tables (connections screen) |

### 6.5 Text & Input

| Package | Version | Purpose |
|---------|---------|---------|
| `re_editor` | 0.9.0 | Rich text editor |
| `re_highlight` | 0.0.3 | Syntax highlighting |
| `board_datetime_picker` | 2.8.5 | Date/time picker |
| `string_validator` | 1.2.0 | String validation |
| `slang` / `slang_flutter` | 4.15.0 | i18n / localization |

### 6.6 Navigation & Routing

| Package | Version | Purpose |
|---------|---------|---------|
| `provider` | 6.1.5+1 | State management (Themes, etc.) |
| `after_layout` | 1.2.0 | Post-layout callbacks |

### 6.7 WebView & Browser

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_inappwebview` | 6.2.0-beta.3 | Embedded webview |
| `url_launcher` | 6.3.2 | Open external URLs |

### 6.8 QR Code

| Package | Version | Purpose |
|---------|---------|---------|
| `zxing2` | 0.2.4 | QR code scanning |
| `qr_code_scanner_plus` | 2.1.1 | QR scanner camera |
| `qr_flutter` | (via qrcode_utils) | QR code generation |

### 6.9 Notifications

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_inapp_notifications` | 1.0.0 | In-app toast notifications |
| `flutter_local_notifications` | 21.0.0 | System notifications |

### 6.10 Desktop Integration

| Package | Version | Purpose |
|---------|---------|---------|
| `window_manager` | — | Desktop window management |
| `tray_manager` | 0.5.2 | System tray |
| `hotkey_manager` | 0.2.3 | Global hotkeys |
| `launch_at_startup` | 0.2.2 | Auto-start on boot |
| `screen_capturer` | 0.2.3 | Screen capture |
| `contextmenu` | 3.0.0 | Context menus (desktop) |
| `open_dir` | 0.0.2+1 | Open directory in file manager |

### 6.11 State Management & Data

| Package | Version | Purpose |
|---------|---------|---------|
| `provider` | 6.1.5+1 | State management |
| `dio` | 5.9.2 | HTTP client |
| `sqlite_async` | 0.14.2 | Async SQLite |
| `flutter_secure_storage` | 10.3.1 | Secure key-value storage |
| `shared_preferences` | (via settings) | Key-value storage |

---

## 7. THEMING SYSTEM

### 7.1 Theme Architecture

```
ThemeDefine (theme_define.dart) — Base colors & constants
    ├── kColorBlue, kColorGrey, kColorGreenBright
    ├── kThemeSystem, kThemeLight, kThemeDark
    └── kBorderRadius (0 — sharp corners everywhere)

ThemeConfig (theme_config.dart) — Size constants
    ├── kListItemHeight: 62
    ├── kListItemHeight2: 50
    ├── kGroupItemHeight: 46
    ├── kFontSizeTitle: 18 (w600)
    ├── kFontSizeListItem: 17 (w500)
    ├── kFontSizeListSubItem: 14 (w400)
    └── kFontSizeGroupItem: 15/14 (w400)

Themes (themes.dart) — Theme provider (ChangeNotifier)
    ├── setTheme(theme, notify)
    ├── getTheme(context) → ThemeData
    └── getThemeInvertBgColor(context)

ThemeDataDark (theme_data_dark.dart) — Dark theme
    ├── mainColor: 0xFF303030
    ├── mainBgColor: 0xFF202020
    └── Material3 ColorScheme.fromSeed()

ThemeDataLight (theme_data_light.dart) — Light theme
    └── (similar structure)
```

### 7.2 Key Theme Characteristics
- **Material 3** (`useMaterial3: true`)
- **Sharp corners** — `BorderRadius.all(Radius.circular(0))` — all widgets have square corners
- **iOS platform style** — `TargetPlatform.iOS` forced
- **Dark theme default** — Dark colors are primary design
- **Custom input decoration** — Blue border, grey labels
- **Dense list tiles** — `ListTileThemeData(dense: true)`

### 7.3 Redesign Implications
- All border radii are 0 — need to decide on new radius system
- Font weights are hardcoded per element — need typography scale
- Colors are scattered — need centralized color system
- No elevation system defined — need shadow/depth system

---

## 8. KEY OBSERVATIONS FOR REDESIGN

### 8.1 Architecture Strengths
1. **Clean separation** — Widgets in `screens/widgets/`, utilities separate
2. **Declarative settings** — `GroupItem` pattern makes adding settings easy
3. **Custom grid system** — `SuperGrid` + `Grid` for flexible home screen
4. **Lazy rendering** — Custom `LasyRenderingState` for performance
5. **Responsive** — Grid auto-calculates columns based on screen width

### 8.2 Architecture Concerns
1. **Massive files** — `home_screen.dart` (2868 lines), `settings_screen.dart` (3258 lines), `group_helper.dart` (3673 lines) — need decomposition
2. **No bottom navigation** — Single-screen architecture may feel limiting for some users
3. **Hardcoded values** — Many inline sizes, colors, and styles
4. **No design system** — No token-based spacing, typography, or color system
5. **Sharp corners everywhere** — `kBorderRadius = 0` — may feel dated
6. **Custom icon font** — `antdesign.dart` is 2377 lines of icon definitions — consider using a standard icon set
7. **Provider only** — Only `provider` for state management — may need more robust solution for complex state

### 8.3 Files Needing Most Attention (by size)
1. `group_helper.dart` (3673 lines) — Central settings definitions
2. `settings_screen.dart` (3258 lines) — Main settings UI
3. `home_screen.dart` (2868 lines) — Home screen
4. `home_screen_widgets.dart` (2588 lines) — Home widgets
5. `antdesign.dart` (2377 lines) — Icon font
6. `server_select_screen.dart` (1858 lines) — Server selection
7. `my_profiles_screen.dart` (1798 lines) — Profile management
8. `net_connections_screen.dart` (1608 lines) — Connections monitor

### 8.4 Recommended Redesign Priorities
1. **Design tokens** — Create a proper design system (spacing, typography, color, elevation)
2. **Component library** — Extract reusable UI components from massive files
3. **Navigation** — Consider adding bottom navigation or tab-based navigation
4. **Theming** — Implement proper Material 3 theming with dynamic color
5. **Responsive** — Improve tablet/desktop layouts
6. **Accessibility** — Review and improve accessibility support
7. **Icon system** — Replace custom AntDesign font with Material Symbols or similar
8. **File decomposition** — Split massive files into smaller, focused widgets

---

## 9. SUMMARY STATISTICS

| Metric | Value |
|--------|-------|
| Total screens | 50 |
| Total custom widgets | 22 |
| Total UI-related dependencies | 40+ |
| Largest screen file | `group_helper.dart` (3673 lines) |
| Largest pure screen | `settings_screen.dart` (3258 lines) |
| Home screen + widgets | 5456 lines combined |
| Theme files | 4 (define, config, dark, light) |
| Icon definitions | ~1400 (antdesign.dart) |
| State management | Provider only |
| Navigation pattern | Single-screen + modal pushes |
| Platform targets | Android, iOS, macOS, Windows, Apple TV |
| Material version | Material 3 |
| Default corner radius | 0 (sharp) |
| Supported themes | System, Light, Dark |
| Localization | Yes (slang, 5+ languages) |
