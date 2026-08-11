# ahk-scripts

Personal [AutoHotkey v2](https://www.autohotkey.com/) scripts for window and virtual desktop management on Windows.

## Prerequisites

1. Download and install **AutoHotkey v2.0** from https://www.autohotkey.com/ (make sure to pick the v2 installer, not v1.1).
2. Clone or copy this repository to a folder on your Windows machine.

## Scripts

### `windowSwitcher.ahk`

Adds hotkeys (`Win+Shift+<key>`) that switch to a running application, or launch it if it isn't running. Pressing the hotkey again while that app is focused cycles to the next window in the same group.

Programs are configured in the `Programs` map at the top of the file. Each entry maps a name to the `ahk_` criteria used to find its window:

```ahk
'Chrome', { criteriaType: 'ahk_exe', criteriaValue: 'chrome.exe' },
```

Hotkeys are registered near the bottom via `mapKey(shortcut, program)`, e.g.:

```ahk
mapKey('+#r', 'Chrome')
```

To add a new shortcut, add an entry to `Programs` and a corresponding `mapKey(...)` call.

### `virtualDesktopSwitcher.ahk`

Adds hotkeys for navigating Windows virtual desktops (create, delete, switch to previous/next, jump to a specific desktop number). See the `; === key mapping ===` section in the file for the exact bindings.

### `startWindowSwitcher.ps1`

A small PowerShell helper that starts `windowSwitcher.ahk`. Useful for launching the script automatically (e.g. from a shortcut, Task Scheduler, or the Startup folder) without having to double-click the `.ahk` file manually. Update the path in the script to match where you placed this repository before using it.

## Running the scripts

- **Manually:** double-click a `.ahk` file (requires AutoHotkey to be installed) to run it. An AutoHotkey tray icon will appear while the script is active.
- **Via PowerShell:** run `startWindowSwitcher.ps1` to launch `windowSwitcher.ahk`.
- **At Windows startup:** place a shortcut to the `.ahk` file(s) (or to `startWindowSwitcher.ps1`) in the Startup folder (`Win+R` → `shell:startup`), or create a Task Scheduler task that runs at logon.

To stop a running script, right-click its tray icon and choose **Exit**, or use **Reload** to apply changes after editing.
